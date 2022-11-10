// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SUNDAY/BnW_ColorLerp"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Color1("Color 1", Color) = (1,0.6210891,0.4943396,0)
		_Color0("Color 0", Color) = (1,0.8007055,0.4943396,0)
		_contrast("contrast", Range( 0 , 5)) = 4.529412
		_size("size", Range( 0 , 5)) = 1.352941
		_Metallic("Metallic", Range( 0 , 1)) = 0.5
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
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

		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform float _contrast;
		uniform sampler2D _TextureSample0;
		uniform float _size;
		uniform float _Metallic;
		uniform float _Smoothness;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult10 = (float2(_size , _size));
			float2 uv_TexCoord13 = i.uv_texcoord * appendResult10;
			float4 lerpResult5 = lerp( _Color0 , _Color1 , CalculateContrast(_contrast,tex2D( _TextureSample0, uv_TexCoord13 )));
			o.Albedo = lerpResult5.rgb;
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
72.8;104;1290.4;644.6;1545.1;-91.82411;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-1355.7,228.1;Inherit;False;Property;_size;size;4;0;Create;True;0;0;0;False;0;False;1.352941;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;10;-1046.7,224.1;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;13;-894.7,199.1;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-623.7,581.1;Inherit;False;Property;_contrast;contrast;3;0;Create;True;0;0;0;False;0;False;4.529412;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-647.7,386.1;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;5b17456bf2245df42bc9a34a62ae1252;5b17456bf2245df42bc9a34a62ae1252;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;4;-477.7,217.1;Inherit;False;Property;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;1,0.6210891,0.4943396,0;1,0.6210891,0.4943396,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;3;-474.7,48.10001;Inherit;False;Property;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;1,0.8007055,0.4943396,0;1,0.8007055,0.4943396,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleContrastOpNode;6;-291.7,391.1;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;4.1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;5;-89.33275,8.099979;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-73.54504,166.9699;Inherit;False;Property;_Metallic;Metallic;5;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-70.54504,247.9699;Inherit;False;Property;_Smoothness;Smoothness;6;0;Create;True;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;260,5;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SUNDAY/BnW_ColorLerp;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;0;9;0
WireConnection;10;1;9;0
WireConnection;13;0;10;0
WireConnection;1;1;13;0
WireConnection;6;1;1;0
WireConnection;6;0;7;0
WireConnection;5;0;3;0
WireConnection;5;1;4;0
WireConnection;5;2;6;0
WireConnection;0;0;5;0
WireConnection;0;3;15;0
WireConnection;0;4;14;0
ASEEND*/
//CHKSM=852A1B78D931AF7C844F40E628D62E29EE147956