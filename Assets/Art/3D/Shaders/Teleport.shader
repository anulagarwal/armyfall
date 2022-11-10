// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "_BURC/Teleport"
{
	Properties
	{
		_NoiseTexture("Noise Texture", 2D) = "white" {}
		_SpeedX("Speed X", Range( -2 , 2)) = -1
		_SpeedY("Speed Y", Range( -2 , 2)) = 0
		_Mask("Mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:premul keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NoiseTexture;
		uniform float _SpeedX;
		uniform float _SpeedY;
		uniform sampler2D _Mask;
		SamplerState sampler_Mask;
		uniform float4 _Mask_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult21 = (float2(_SpeedX , _SpeedY));
			float2 panner7 = ( _Time.y * appendResult21 + i.uv_texcoord);
			o.Albedo = tex2D( _NoiseTexture, panner7 ).rgb;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			o.Alpha = tex2D( _Mask, uv_Mask ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18500
1792;-433;1920;1036;2494.574;564.5516;1.431507;True;False
Node;AmplifyShaderEditor.RangedFloatNode;22;-1947.712,92.75966;Inherit;True;Property;_SpeedY;Speed Y;2;0;Create;True;0;0;False;0;False;0;2;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1933.959,-139.0413;Inherit;True;Property;_SpeedX;Speed X;1;0;Create;True;0;0;False;0;False;-1;2;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;21;-1479.13,-120.4226;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;8;-1391.054,127.521;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1690.799,-414.291;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;7;-1191.104,-113.0611;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;-655.8079,-160.8601;Inherit;True;Property;_NoiseTexture;Noise Texture;0;0;Create;True;0;0;False;0;False;-1;ac8f353f6b93d40a689089c1cede1af3;ac8f353f6b93d40a689089c1cede1af3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;36;-435.2482,210.074;Inherit;True;Property;_Mask;Mask;3;0;Create;True;0;0;False;0;False;-1;4fe273ab511db41f79ece67c5dbfb9aa;4fe273ab511db41f79ece67c5dbfb9aa;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;211,-60;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;_BURC/Teleport;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Premultiply;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;3;1;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;20;0
WireConnection;21;1;22;0
WireConnection;7;0;9;0
WireConnection;7;2;21;0
WireConnection;7;1;8;0
WireConnection;1;1;7;0
WireConnection;0;0;1;0
WireConnection;0;9;36;1
ASEEND*/
//CHKSM=C28C8556B655E66EE0BC6951752E70919205B5DB