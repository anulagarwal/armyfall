// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SUNDAY/FakeLight"
{
	Properties
	{
		_colorEnd("colorEnd", Color) = (1,1,1,0)
		_colorStart("colorStart", Color) = (0,0.9708953,1,0)
		_Oppacity("Oppacity", Range( 0.1 , 10)) = 1.148235
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _colorEnd;
		uniform float4 _colorStart;
		uniform float _Oppacity;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float temp_output_6_0 = ( 1.0 - length( (float2( -1,-1 ) + (i.uv_texcoord - float2( 0,0 )) * (float2( 1,1 ) - float2( -1,-1 )) / (float2( 1,1 ) - float2( 0,0 ))) ) );
			float4 lerpResult15 = lerp( _colorEnd , _colorStart , temp_output_6_0);
			o.Emission = lerpResult15.rgb;
			float temp_output_17_0 = ( temp_output_6_0 / _Oppacity );
			o.Alpha = temp_output_17_0;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
72.8;104;1290.4;644.6;1077.51;434.8632;1.458119;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-678.7,-59.5;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;5;-441.476,26.35222;Inherit;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LengthOpNode;4;-245.9069,-111.3427;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;6;-0.7000122,-23.5;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-186.3613,147.3749;Inherit;False;Property;_Oppacity;Oppacity;3;0;Create;True;0;0;0;False;0;False;1.148235;2.47;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;119.3,-487.5;Inherit;False;Property;_colorEnd;colorEnd;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;16;45.29999,-273.5;Inherit;False;Property;_colorStart;colorStart;1;0;Create;True;0;0;0;False;0;False;0,0.9708953,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-223.7,432.5;Inherit;False;Property;_depthDistance;depthDistance;2;0;Create;True;0;0;0;False;0;False;0;3;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;8;28.29999,288.5;Inherit;False;True;True;False;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;13;313.3,363.5;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;17;137.6387,89.37488;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;332.3,183.5;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;15;360.3,-160.5;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;2;788,-53;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;SUNDAY/FakeLight;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;3;0
WireConnection;4;0;5;0
WireConnection;6;0;4;0
WireConnection;8;0;11;0
WireConnection;13;0;8;0
WireConnection;17;0;6;0
WireConnection;17;1;18;0
WireConnection;10;0;17;0
WireConnection;10;1;13;0
WireConnection;15;0;7;0
WireConnection;15;1;16;0
WireConnection;15;2;6;0
WireConnection;2;2;15;0
WireConnection;2;9;17;0
ASEEND*/
//CHKSM=C97C7A849EF2CEE2D713914D75B6CE7358B26DD3