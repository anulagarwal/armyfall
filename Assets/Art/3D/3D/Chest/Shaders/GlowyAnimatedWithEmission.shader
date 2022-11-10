// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GlowyAnimatedWithEmission"
{
	Properties
	{
		_GlowTexture("GlowTexture", 2D) = "white" {}
		_GlowAmount("GlowAmount", Range( 0 , 1)) = 0
		_GlowBrightness("GlowBrightness", Range( 0 , 1)) = 0
		_GlowColor2("GlowColor2", Color) = (0,0,0,0)
		_GlowColor1("GlowColor1", Color) = (1,1,1,0)
		_AlbedoColor("AlbedoColor", Color) = (1,0.780975,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha noshadow 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _AlbedoColor;
		uniform float4 _GlowColor2;
		uniform sampler2D _GlowTexture;
		uniform float _GlowAmount;
		uniform float _GlowBrightness;
		uniform float4 _GlowColor1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _AlbedoColor.rgb;
			float2 panner20 = ( _Time.y * float2( 0.1,0.1 ) + i.uv_texcoord);
			float4 temp_cast_1 = (_GlowAmount).xxxx;
			float4 temp_cast_2 = (_GlowBrightness).xxxx;
			float4 clampResult29 = clamp( min( tex2D( _GlowTexture, panner20 ) , temp_cast_1 ) , float4( 0,0,0,0 ) , temp_cast_2 );
			float4 temp_cast_3 = (1.66753).xxxx;
			o.Emission = ( _GlowColor2 + pow( ( clampResult29 * _GlowColor1 ) , temp_cast_3 ) ).rgb;
			o.Metallic = 1.0;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
337.6;219.2;996;871.8;-2350.557;-312.7867;1.803142;False;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;1903.779,1116.201;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;22;1547.666,1326.499;Inherit;False;Constant;_Vector0;Vector 0;7;0;Create;True;0;0;0;False;0;False;0.1,0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TimeNode;21;1481.666,1542.499;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;20;2207.731,1298.573;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;16;2482.447,1394.262;Inherit;True;Property;_GlowAmount;GlowAmount;1;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;2425.449,1154.465;Inherit;True;Property;_GlowTexture;GlowTexture;0;0;Create;True;0;0;0;False;0;False;-1;None;d429427b24a220a45ba31a7e4b3ce10d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;2811.721,1436.613;Inherit;False;Property;_GlowBrightness;GlowBrightness;2;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;26;2865.332,1192.814;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;29;3107.158,1274.97;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;37;3172.931,1055.253;Inherit;False;Property;_GlowColor1;GlowColor1;4;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,0.8289473,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;3560.637,1014.235;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;52;3619.384,1276.026;Inherit;False;Constant;_GlowContrast;GlowContrast;5;0;Create;True;0;0;0;False;0;False;1.66753;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;51;3929.834,1048.158;Inherit;True;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;47;3563.85,717.5222;Inherit;False;Property;_GlowColor2;GlowColor2;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.4794945,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;48;3946.149,736.845;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;50;3715.553,479.1403;Inherit;False;Constant;_Metallic;Metallic;5;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;49;3704.467,271.8189;Inherit;False;Property;_AlbedoColor;AlbedoColor;5;0;Create;True;0;0;0;False;0;False;1,0.780975,0,0;1,0.780975,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4254.258,509.3506;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;GlowyAnimatedWithEmission;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
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
WireConnection;51;0;36;0
WireConnection;51;1;52;0
WireConnection;48;0;47;0
WireConnection;48;1;51;0
WireConnection;0;0;49;0
WireConnection;0;2;48;0
WireConnection;0;3;50;0
ASEEND*/
//CHKSM=571F5679EED5BEACE7C3AA8279D00672C745ADF0