// Upgrade NOTE: upgraded instancing buffer 'Decal' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Decal"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Mask("Mask", 2D) = "white" {}
		_MJetallic("MJetallic", Float) = 0
		_Emission("Emission", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Mask;
		uniform float _Cutoff = 0.5;

		UNITY_INSTANCING_BUFFER_START(Decal)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Mask_ST)
#define _Mask_ST_arr Decal
			UNITY_DEFINE_INSTANCED_PROP(float, _Emission)
#define _Emission_arr Decal
			UNITY_DEFINE_INSTANCED_PROP(float, _MJetallic)
#define _MJetallic_arr Decal
		UNITY_INSTANCING_BUFFER_END(Decal)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 _Mask_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Mask_ST_arr, _Mask_ST);
			float2 uv_Mask = i.uv_texcoord * _Mask_ST_Instance.xy + _Mask_ST_Instance.zw;
			float4 tex2DNode1 = tex2D( _Mask, uv_Mask );
			float _Emission_Instance = UNITY_ACCESS_INSTANCED_PROP(_Emission_arr, _Emission);
			o.Albedo = ( tex2DNode1 * _Emission_Instance ).rgb;
			float _MJetallic_Instance = UNITY_ACCESS_INSTANCED_PROP(_MJetallic_arr, _MJetallic);
			o.Metallic = _MJetallic_Instance;
			o.Alpha = 1;
			float4 clampResult10 = clamp( ( tex2DNode1 * float4(5,5,5,5) ) , float4( 0,0,0,0 ) , float4(1,1,1,1) );
			float2 temp_output_17_0 = ( (clampResult10).rg + (clampResult10).b );
			float clampResult21 = clamp( ( (temp_output_17_0).x + (temp_output_17_0).y ) , 0.0 , 1.0 );
			clip( clampResult21 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
633;1482;1920;977;1774.501;448.1678;1.422758;True;False
Node;AmplifyShaderEditor.Vector4Node;13;-1018,497.5;Inherit;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;0;False;0;False;5,5,5,5;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1177,274.5;Inherit;True;Property;_Mask;Mask;1;0;Create;True;0;0;0;False;0;False;-1;3cba8b3c80952b049b0cd149a20c3228;16466d62cf523ab41bb6f4cef5339721;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;14;-714,624.5;Inherit;False;Constant;_Vector1;Vector 1;5;0;Create;True;0;0;0;False;0;False;1,1,1,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-812,291.5;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT4;5,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;10;-476,292.5;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;15;-185,452.5;Inherit;False;True;True;False;False;1;0;COLOR;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;16;-182,535.5;Inherit;False;False;False;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;25,482.5;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;19;164,533.5;Inherit;False;False;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;18;162,454.5;Inherit;False;True;False;False;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;396,494.5;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;241.2883,118.8523;Inherit;False;InstancedProperty;_Emission;Emission;3;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;437.9787,-0.2477294;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;21;522,474.5;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;440.9787,283.7522;Inherit;False;InstancedProperty;_MJetallic;MJetallic;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;784.4777,-8.243202;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Decal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Custom;;Transparent;All;18;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;1;0
WireConnection;9;1;13;0
WireConnection;10;0;9;0
WireConnection;10;2;14;0
WireConnection;15;0;10;0
WireConnection;16;0;10;0
WireConnection;17;0;15;0
WireConnection;17;1;16;0
WireConnection;19;0;17;0
WireConnection;18;0;17;0
WireConnection;20;0;18;0
WireConnection;20;1;19;0
WireConnection;11;0;1;0
WireConnection;11;1;12;0
WireConnection;21;0;20;0
WireConnection;0;0;11;0
WireConnection;0;3;7;0
WireConnection;0;10;21;0
ASEEND*/
//CHKSM=C3612E618AEF707D6DD3907A8D7346660D9EDEA3