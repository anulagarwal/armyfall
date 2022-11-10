// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "StripedSimple"
{
	Properties
	{
		_Tint("Tint", Color) = (0.735849,0.735849,0.735849,0)
		_Thikness("Thikness", Range( 0 , 1)) = 0.5
		_Tiling("Tiling", Float) = 5
		_StripeStrength("StripeStrength", Float) = 2.22
		_Darken("Darken", Float) = 13.99
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Tint;
		uniform float _Tiling;
		uniform float _Thikness;
		uniform float _StripeStrength;
		uniform float _Darken;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Tiling).xx;
			float2 uv_TexCoord1 = i.uv_texcoord * temp_cast_0;
			o.Albedo = ( ( _Tint * ( step( frac( uv_TexCoord1.y ) , _Thikness ) + _StripeStrength ) ) / _Darken ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
1920;8;1920;1013;1168.929;529.71;1.374954;True;True
Node;AmplifyShaderEditor.RangedFloatNode;6;-1258.933,-79.03806;Inherit;True;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;5;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1000.933,-268.0379;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;2;-695.9331,-236.0379;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-695.9331,51.96206;Inherit;True;Property;_Thikness;Thikness;1;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-59.22714,121.5681;Inherit;False;Property;_StripeStrength;StripeStrength;3;0;Create;True;0;0;False;0;2.22;0.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;3;-444.9329,-165.038;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;149.3072,-51.25829;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;136.4524,-316.9254;Inherit;False;Property;_Tint;Tint;0;0;Create;True;0;0;False;0;0.735849,0.735849,0.735849,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;437.827,-152.6689;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;12;379.043,72.68204;Inherit;True;Property;_Darken;Darken;4;0;Create;True;0;0;False;0;13.99;13.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;11;609.528,-66.70461;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;937.6007,-141.8937;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;StripedSimple;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;0;6;0
WireConnection;2;0;1;2
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;9;0;3;0
WireConnection;9;1;8;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;11;0;10;0
WireConnection;11;1;12;0
WireConnection;0;0;11;0
ASEEND*/
//CHKSM=C6D6506A020BAFB21143C1633FD4C19C70B6416D