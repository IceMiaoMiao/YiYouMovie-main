// Upgrade NOTE: upgraded instancing buffer 'NewAmplifyShader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "New Amplify Shader"
{
	Properties
	{
		_Float0("Float 0", Float) = 0.4
		_Power("Power", Float) = 0
		_Base_Color("Base_Color", Color) = (0,0,0,0)
		_LayerOffest("Layer Offest", Float) = 0
		_LayerNumber("Layer Number", Float) = 5
		_Normal_Tex("Normal_Tex", 2D) = "white" {}
		[Toggle(_NORMAL_ON)] _Normal("Normal?", Float) = 0
		[Toggle(_COLORTEX_ON)] _ColorTex("ColorTex", Float) = 0
		[Toggle(_30_ON)] _30("30?", Float) = 0
		_low_poly_interior_1024("low_poly_interior_1024", 2D) = "white" {}
		_T_Room_01_BC("T_Room_01_BC", 2D) = "white" {}
		[Toggle(_EMISSION_ON)] _Emission("Emission?", Float) = 0
		[Toggle(_FAN_ON)] _fan("fan?", Float) = 0
		[Toggle(_CURTAIN_ON)] _Curtain("Curtain?", Float) = 0
		_vmghdejo_2K_Displacement("vmghdejo_2K_Displacement", 2D) = "white" {}
		_Float3("Float 3", Float) = 1
		_Mul("Mul", Float) = 0
		_Add("Add", Float) = 0
		_Roughness("Roughness", Float) = 0
		_Metallic("Metallic", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma shader_feature_local _CURTAIN_ON
		#pragma shader_feature_local _FAN_ON
		#pragma shader_feature_local _COLORTEX_ON
		#pragma shader_feature_local _30_ON
		#pragma shader_feature_local _NORMAL_ON
		#pragma shader_feature_local _EMISSION_ON
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float3 worldNormal;
		};

		uniform sampler2D _vmghdejo_2K_Displacement;
		uniform sampler2D _low_poly_interior_1024;
		uniform sampler2D _T_Room_01_BC;
		uniform sampler2D _Normal_Tex;

		UNITY_INSTANCING_BUFFER_START(NewAmplifyShader)
			UNITY_DEFINE_INSTANCED_PROP(float4, _low_poly_interior_1024_ST)
#define _low_poly_interior_1024_ST_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float4, _T_Room_01_BC_ST)
#define _T_Room_01_BC_ST_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float4, _Base_Color)
#define _Base_Color_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float4, _Normal_Tex_ST)
#define _Normal_Tex_ST_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Add)
#define _Add_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Power)
#define _Power_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Mul)
#define _Mul_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Float3)
#define _Float3_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Float0)
#define _Float0_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _LayerOffest)
#define _LayerOffest_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _LayerNumber)
#define _LayerNumber_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Metallic)
#define _Metallic_arr NewAmplifyShader
			UNITY_DEFINE_INSTANCED_PROP(float, _Roughness)
#define _Roughness_arr NewAmplifyShader
		UNITY_INSTANCING_BUFFER_END(NewAmplifyShader)

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 transform84 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float _Add_Instance = UNITY_ACCESS_INSTANCED_PROP(_Add_arr, _Add);
			float _Power_Instance = UNITY_ACCESS_INSTANCED_PROP(_Power_arr, _Power);
			float _Mul_Instance = UNITY_ACCESS_INSTANCED_PROP(_Mul_arr, _Mul);
			float clampResult75 = clamp( ( 1.0 - ( pow( ( (( ase_worldPos - (transform84).xyz )).y + _Add_Instance ) , _Power_Instance ) * _Mul_Instance ) ) , 0.0 , 1.0 );
			float2 appendResult82 = (float2(( v.texcoord.xy + ( _CosTime.x * float2( 0,0.2 ) ) )));
			float _Float3_Instance = UNITY_ACCESS_INSTANCED_PROP(_Float3_arr, _Float3);
			float4 transform153 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float3 temp_cast_0 = (( (( ase_worldPos - (transform153).xyz )).y * 0.0 )).xxx;
			#ifdef _FAN_ON
				float3 staticSwitch152 = temp_cast_0;
			#else
				float3 staticSwitch152 = ( float3(0,0,1) * ( ( clampResult75 * (tex2Dlod( _vmghdejo_2K_Displacement, float4( appendResult82, 0, 0.0) )).rgb ) * _Float3_Instance ) );
			#endif
			#ifdef _CURTAIN_ON
				float3 staticSwitch85 = staticSwitch152;
			#else
				float3 staticSwitch85 = float3(0,0,0);
			#endif
			v.vertex.xyz += staticSwitch85;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 temp_cast_0 = (1.0).xxxx;
			float4 _low_poly_interior_1024_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_low_poly_interior_1024_ST_arr, _low_poly_interior_1024_ST);
			float2 uv_low_poly_interior_1024 = i.uv_texcoord * _low_poly_interior_1024_ST_Instance.xy + _low_poly_interior_1024_ST_Instance.zw;
			float4 _T_Room_01_BC_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_T_Room_01_BC_ST_arr, _T_Room_01_BC_ST);
			float2 uv_T_Room_01_BC = i.uv_texcoord * _T_Room_01_BC_ST_Instance.xy + _T_Room_01_BC_ST_Instance.zw;
			#ifdef _30_ON
				float4 staticSwitch42 = tex2D( _T_Room_01_BC, uv_T_Room_01_BC );
			#else
				float4 staticSwitch42 = tex2D( _low_poly_interior_1024, uv_low_poly_interior_1024 );
			#endif
			#ifdef _COLORTEX_ON
				float4 staticSwitch39 = staticSwitch42;
			#else
				float4 staticSwitch39 = temp_cast_0;
			#endif
			float4 _Base_Color_Instance = UNITY_ACCESS_INSTANCED_PROP(_Base_Color_arr, _Base_Color);
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult7 = dot( ase_worldNormal , ase_worldlightDir );
			float _Float0_Instance = UNITY_ACCESS_INSTANCED_PROP(_Float0_arr, _Float0);
			float lerpResult10 = lerp( ( ( dotResult7 * 0.5 ) + 0.5 ) , dotResult7 , _Float0_Instance);
			float4 _Normal_Tex_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Normal_Tex_ST_arr, _Normal_Tex_ST);
			float2 uv_Normal_Tex = i.uv_texcoord * _Normal_Tex_ST_Instance.xy + _Normal_Tex_ST_Instance.zw;
			float4 normalizeResult27 = normalize( tex2D( _Normal_Tex, uv_Normal_Tex ) );
			float dotResult29 = dot( lerpResult10 , (normalizeResult27).g );
			#ifdef _NORMAL_ON
				float staticSwitch30 = dotResult29;
			#else
				float staticSwitch30 = lerpResult10;
			#endif
			float _LayerOffest_Instance = UNITY_ACCESS_INSTANCED_PROP(_LayerOffest_arr, _LayerOffest);
			float _LayerNumber_Instance = UNITY_ACCESS_INSTANCED_PROP(_LayerNumber_arr, _LayerNumber);
			float temp_output_18_0 = ( ( staticSwitch30 + _LayerOffest_Instance ) * _LayerNumber_Instance );
			float4 temp_output_24_0 = ( ( staticSwitch39 * _Base_Color_Instance ) * ( ( 0.0 + floor( temp_output_18_0 ) ) / 5.0 ) );
			o.Albedo = temp_output_24_0.rgb;
			float4 temp_cast_2 = (0.0).xxxx;
			#ifdef _EMISSION_ON
				float4 staticSwitch45 = temp_output_24_0;
			#else
				float4 staticSwitch45 = temp_cast_2;
			#endif
			o.Emission = staticSwitch45.rgb;
			float _Metallic_Instance = UNITY_ACCESS_INSTANCED_PROP(_Metallic_arr, _Metallic);
			o.Metallic = _Metallic_Instance;
			float _Roughness_Instance = UNITY_ACCESS_INSTANCED_PROP(_Roughness_arr, _Roughness);
			o.Smoothness = _Roughness_Instance;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
640;1458;1920;1001;20.90558;307.5256;1;True;False
Node;AmplifyShaderEditor.WorldNormalVector;4;-1893.073,-32.65799;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;5;-1936.073,155.3421;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;84;-2204.832,1296.515;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;7;-1612.073,97.34207;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;63;-1930.69,1059.584;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ComponentMaskNode;64;-1962.595,1269.162;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1420.073,86.34207;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;26;-1956.539,552.839;Inherit;True;Property;_Normal_Tex;Normal_Tex;6;0;Create;True;0;0;0;False;0;False;-1;e880d91f3c4600a4bac6b774f3d3af35;e880d91f3c4600a4bac6b774f3d3af35;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;-1693.69,1180.985;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;27;-1585.421,574.056;Inherit;False;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1385.073,283.3421;Inherit;False;InstancedProperty;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;0.4;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-1487.732,1359.224;Inherit;False;InstancedProperty;_Add;Add;18;0;Create;True;0;0;0;False;0;False;0;3.01;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-1238.073,81.34207;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosTime;77;-1586.702,1841.806;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;66;-1484.028,1183.548;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;78;-1425.492,2008.558;Inherit;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;0;False;0;False;0,0.2;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;-1267.519,1845.228;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;-1472.92,1615.127;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;38;-1403.208,570.578;Inherit;True;False;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;10;-1099.073,128.3421;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-1202.097,1141.715;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1306.585,1365.24;Inherit;False;InstancedProperty;_Power;Power;2;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-1139.519,1361.902;Inherit;False;InstancedProperty;_Mul;Mul;17;0;Create;True;0;0;0;False;0;False;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-1134.918,1700.927;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;72;-1020.103,1157.117;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;29;-1045.758,548.7527;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;30;-863.7574,422.6531;Inherit;False;Property;_Normal;Normal?;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-974.0616,313.2036;Inherit;False;InstancedProperty;_LayerOffest;Layer Offest;4;0;Create;True;0;0;0;False;0;False;0;0.27;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;67;-812.6045,1169.294;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;82;-955.5176,1658.627;Inherit;False;FLOAT2;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;146;-613.1302,1143.254;Inherit;False;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;120;-718.825,1614.021;Inherit;True;Property;_vmghdejo_2K_Displacement;vmghdejo_2K_Displacement;15;0;Create;True;0;0;0;False;0;False;-1;c4b5221be07f9d94d80397b1d93c566b;c4b5221be07f9d94d80397b1d93c566b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-790.0627,127.1488;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;153;-1701.191,2494.794;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;19;-745.8615,308.0642;Inherit;False;InstancedProperty;_LayerNumber;Layer Number;5;0;Create;True;0;0;0;False;0;False;5;3.87;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;41;-592.1423,-523.8241;Inherit;True;Property;_low_poly_interior_1024;low_poly_interior_1024;10;0;Create;True;0;0;0;False;0;False;-1;a88252e61605e464ea8a261d7bfa37a9;a88252e61605e464ea8a261d7bfa37a9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-597.8405,130.2326;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;154;-1427.049,2257.863;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;43;-586.1423,-286.8241;Inherit;True;Property;_T_Room_01_BC;T_Room_01_BC;11;0;Create;True;0;0;0;False;0;False;-1;ae6befbf0c2ac05459037b0187686217;ae6befbf0c2ac05459037b0187686217;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;121;-360.825,1626.021;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;75;-366.0382,1134.081;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;155;-1458.954,2467.441;Inherit;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-206.1423,-608.8241;Inherit;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;-89.79578,957.736;Inherit;False;InstancedProperty;_Float3;Float 3;16;0;Create;True;0;0;0;False;0;False;1;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;42;-235.1423,-411.8241;Inherit;False;Property;_30;30?;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-56.9488,1564.237;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FloorOpNode;21;-202.0874,134.3444;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;156;-1190.049,2379.264;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;157;-980.3865,2381.827;Inherit;False;False;True;False;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;39;-13.14233,-504.8241;Inherit;False;Property;_ColorTex;ColorTex;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;172.072,838.8226;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;22;20.97275,107.6183;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;151;208.4973,604.957;Inherit;False;Constant;_Vector3;Vector 3;21;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;3;-100.8387,-150.6766;Inherit;False;InstancedProperty;_Base_Color;Base_Color;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;23;339.7928,114.4384;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-479.0635,2424.79;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;150;514.6929,757.8264;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;269.9584,-267.4384;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;542.2943,21.9251;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector3Node;86;666.4429,397.7877;Inherit;False;Constant;_Vector1;Vector 1;15;0;Create;True;0;0;0;False;0;False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;152;823.3685,672.3353;Inherit;False;Property;_fan;fan?;13;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;46;681.0975,194.2027;Inherit;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;85;956.3672,411.528;Inherit;False;Property;_Curtain;Curtain?;14;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;132;-162.448,212.8144;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;20;-447.7625,-6.481445;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;45;944.9972,183.8266;Inherit;False;Property;_Emission;Emission?;12;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;44;-40.33716,-310.2824;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;167;957.0945,-170.5256;Inherit;False;InstancedProperty;_Metallic;Metallic;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;168;956.0944,-80.52563;Inherit;False;InstancedProperty;_Roughness;Roughness;19;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1265.657,-3.851386;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;New Amplify Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;ForwardOnly;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;1000;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;4;0
WireConnection;7;1;5;0
WireConnection;64;0;84;0
WireConnection;8;0;7;0
WireConnection;65;0;63;0
WireConnection;65;1;64;0
WireConnection;27;0;26;0
WireConnection;9;0;8;0
WireConnection;66;0;65;0
WireConnection;80;0;77;1
WireConnection;80;1;78;0
WireConnection;38;0;27;0
WireConnection;10;0;9;0
WireConnection;10;1;7;0
WireConnection;10;2;12;0
WireConnection;68;0;66;0
WireConnection;68;1;139;0
WireConnection;81;0;79;0
WireConnection;81;1;80;0
WireConnection;72;0;68;0
WireConnection;72;1;71;0
WireConnection;29;0;10;0
WireConnection;29;1;38;0
WireConnection;30;1;10;0
WireConnection;30;0;29;0
WireConnection;67;0;72;0
WireConnection;67;1;137;0
WireConnection;82;0;81;0
WireConnection;146;1;67;0
WireConnection;120;1;82;0
WireConnection;16;0;30;0
WireConnection;16;1;17;0
WireConnection;18;0;16;0
WireConnection;18;1;19;0
WireConnection;121;0;120;0
WireConnection;75;0;146;0
WireConnection;155;0;153;0
WireConnection;42;1;41;0
WireConnection;42;0;43;0
WireConnection;76;0;75;0
WireConnection;76;1;121;0
WireConnection;21;0;18;0
WireConnection;156;0;154;0
WireConnection;156;1;155;0
WireConnection;157;0;156;0
WireConnection;39;1;40;0
WireConnection;39;0;42;0
WireConnection;129;0;76;0
WireConnection;129;1;131;0
WireConnection;22;1;21;0
WireConnection;23;0;22;0
WireConnection;166;0;157;0
WireConnection;150;0;151;0
WireConnection;150;1;129;0
WireConnection;32;0;39;0
WireConnection;32;1;3;0
WireConnection;24;0;32;0
WireConnection;24;1;23;0
WireConnection;152;1;150;0
WireConnection;152;0;166;0
WireConnection;85;1;86;0
WireConnection;85;0;152;0
WireConnection;20;0;18;0
WireConnection;45;1;46;0
WireConnection;45;0;24;0
WireConnection;0;0;24;0
WireConnection;0;2;45;0
WireConnection;0;3;167;0
WireConnection;0;4;168;0
WireConnection;0;11;85;0
ASEEND*/
//CHKSM=E2C942DEE926FC785DBB139CC437989400F03C19