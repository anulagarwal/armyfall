// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SUNDAY/Pbr_Blink"
{
	Properties
	{
		_Color("Color", Color) = (1,0,0,0)
		_Speed("Speed", Range( 0 , 10)) = 2
		[Toggle]_blinking("blinking", Float) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0.5
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half filler;
		};

		uniform float _blinking;
		uniform float4 _Color;
		uniform float _Speed;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime4 = _Time.y * _Speed;
			o.Albedo = (( _blinking )?( ( _Color * frac( mulTime4 ) ) ):( _Color )).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
72.8;104;1290.4;644.6;1206.202;242.3997;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;7;-972.652,308.0836;Inherit;False;Property;_Speed;Speed;1;0;Create;True;0;0;0;False;0;False;2;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;4;-667.1526,313.6841;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;3;-468.2537,313.6834;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-535.4527,-47.1959;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;1,0,0,0;0.9433962,0.0925596,0.0925596,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-274.5533,127.3839;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-60.90171,325.7001;Inherit;False;Property;_Metallic;Metallic;3;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-58.30165,411.5002;Inherit;False;Property;_Smoothness;Smoothness;4;0;Create;True;0;0;0;False;0;False;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;12;-16.70221,-44.7997;Inherit;False;Property;_blinking;blinking;2;0;Create;True;0;0;0;False;0;False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;265.2,-50.69998;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SUNDAY/Pbr_Blink;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;7;0
WireConnection;3;0;4;0
WireConnection;8;0;1;0
WireConnection;8;1;3;0
WireConnection;12;0;1;0
WireConnection;12;1;8;0
WireConnection;0;0;12;0
WireConnection;0;3;13;0
WireConnection;0;4;14;0
ASEEND*/
//CHKSM=D1D8FF31874C152A9FE4B2A32E3E74A670E1BCE8