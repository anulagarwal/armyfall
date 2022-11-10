// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GlowyAnimated"
{
	Properties
	{
		_GlowTexture("GlowTexture", 2D) = "white" {}
		_Brightness("Brightness", Range( 0 , 1)) = 0
		_Color1("Color 1", Color) = (0,0,0,0)
		_Color0("Color 0", Color) = (1,1,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color1;
		uniform sampler2D _GlowTexture;
		uniform float _Brightness;
		uniform float4 _Color0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner20 = ( _Time.y * float2( 0.1,0.1 ) + i.uv_texcoord);
			float4 temp_cast_0 = (_Brightness).xxxx;
			float4 temp_cast_1 = (1.0).xxxx;
			float4 clampResult29 = clamp( min( tex2D( _GlowTexture, panner20 ) , temp_cast_0 ) , float4( 0,0,0,0 ) , temp_cast_1 );
			o.Albedo = ( _Color1 + ( clampResult29 * _Color0 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
337.6;219.2;996;871.8;-1805.989;-238.7165;2.193828;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;1903.779,1116.201;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;22;1547.666,1326.499;Inherit;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;0;False;0;False;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TimeNode;21;1481.666,1542.499;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;20;2207.731,1298.573;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;2459.507,1382.028;Inherit;True;Property;_Brightness;Brightness;1;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;2425.449,1154.465;Inherit;True;Property;_GlowTexture;GlowTexture;0;0;Create;True;0;0;0;False;0;False;-1;None;d429427b24a220a45ba31a7e4b3ce10d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMinOpNode;26;2865.332,1192.814;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;30;2811.721,1434.419;Inherit;False;Constant;_Float2;Float 2;2;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;29;3107.158,1274.97;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;37;3172.931,1055.253;Inherit;False;Property;_Color0;Color 0;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,0,0.02995586,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;3560.637,1014.235;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;47;3563.85,717.5222;Inherit;False;Property;_Color1;Color 1;2;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.4183483,0,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;48;3863.567,854.6024;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4254.258,509.3506;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;GlowyAnimated;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;23;0
WireConnection;20;2;22;0
WireConnection;20;1;21;2
WireConnection;15;1;20;0
WireConnection;26;0;15;0
WireConnection;26;1;16;0
WireConnection;29;0;26;0
WireConnection;29;2;30;0
WireConnection;36;0;29;0
WireConnection;36;1;37;0
WireConnection;48;0;47;0
WireConnection;48;1;36;0
WireConnection;0;0;48;0
ASEEND*/
//CHKSM=560457BBE0D5202EAABC4508F114CE93803F1E30