// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndy/SimpleShadowTint"
{
	Properties
	{
		_Main("Main", 2D) = "white" {}
		_TextureOpacity("Texture Opacity", Range( 0 , 1)) = 1
		_TextureTint("Texture Tint", Color) = (1,0.4321439,0.2235294,0)
		[Toggle(_FLIPTEXTURE_ON)] _FlipTexture("Flip Texture", Float) = 0
		_ShadowColor("ShadowColor", Color) = (0.09382871,0.005384479,0.1037736,0)
		_LightColor("LightColor", Color) = (0,0,0,0)
		_TextureTiling("Texture Tiling", Vector) = (1,1,0,0)
		_TextureOffset("Texture Offset", Vector) = (0,0,0,0)
		_WhiteColorInfluence("White Color Influence", Color) = (1,0.8622642,0.8622642,0)
		_BlackColorInfluence("Black Color Influence", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _FLIPTEXTURE_ON
		#pragma surface surf StandardCustomLighting keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		struct Input
		{
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
			float2 uv_texcoord;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float4 _ShadowColor;
		uniform float4 _LightColor;
		uniform float4 _BlackColorInfluence;
		uniform float4 _WhiteColorInfluence;
		uniform sampler2D _Main;
		uniform float2 _TextureTiling;
		uniform float2 _TextureOffset;
		uniform float _TextureOpacity;
		uniform float4 _TextureTint;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult5 = dot( ase_worldNormal , ase_worldlightDir );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 temp_output_9_0 = ( max( dotResult5 , 0.0 ) * ( ase_lightAtten * ase_lightColor.rgb ) );
			float4 lerpResult17 = lerp( _ShadowColor , _LightColor , float4( temp_output_9_0 , 0.0 ));
			UnityGI gi12 = gi;
			float3 diffNorm12 = ase_worldNormal;
			gi12 = UnityGI_Base( data, 1, diffNorm12 );
			float3 indirectDiffuse12 = gi12.indirect.diffuse + diffNorm12 * 0.0001;
			float2 uv_TexCoord55 = i.uv_texcoord * _TextureTiling + _TextureOffset;
			#ifdef _FLIPTEXTURE_ON
				float2 staticSwitch58 = ( 1.0 - uv_TexCoord55 );
			#else
				float2 staticSwitch58 = uv_TexCoord55;
			#endif
			float4 lerpResult61 = lerp( _BlackColorInfluence , _WhiteColorInfluence , tex2D( _Main, staticSwitch58 ));
			float4 color54 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 lerpResult52 = lerp( lerpResult61 , color54 , ( 1.0 - _TextureOpacity ));
			float4 ShadowLight38 = ( lerpResult17 + ( float4( ( temp_output_9_0 + indirectDiffuse12 ) , 0.0 ) * ( lerpResult52 * _TextureTint ) ) );
			c.rgb = ShadowLight38.rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
382;194;1530;793;2476.703;-1.328201;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;40;-3178.601,-527.1761;Inherit;False;3097.279;1512.381;Comment;33;11;58;56;55;60;59;18;20;8;52;53;54;49;27;21;38;19;17;14;15;13;12;9;7;6;4;5;3;1;2;61;63;64;Shadow Light Texture Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;60;-3132.194,297.6816;Inherit;False;Property;_TextureOffset;Texture Offset;13;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;59;-3133.194,161.6816;Inherit;False;Property;_TextureTiling;Texture Tiling;12;0;Create;True;0;0;0;False;0;False;1,1;2,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-2845.209,222.4556;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;56;-2583.296,338.2473;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;2;-1981.499,31.68572;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1;-1973.092,-212.9927;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;58;-2388.32,218.0527;Inherit;False;Property;_FlipTexture;Flip Texture;3;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LightColorNode;4;-1885.388,208.3148;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightAttenuation;3;-1739.388,89.31465;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;64;-2124.303,244.3282;Inherit;False;Property;_BlackColorInfluence;Black Color Influence;15;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;5;-1691.525,-179.4867;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1941.569,900.3748;Inherit;False;Property;_TextureOpacity;Texture Opacity;1;0;Create;True;0;0;0;False;0;False;1;0.094;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-2166.629,595.9293;Inherit;True;Property;_Main;Main;0;0;Create;True;0;0;0;False;0;False;-1;387dc9cb29c56b146a2fadccaf58cef4;d6ec66299c79c234c993fabc898ee28c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;63;-2125.303,420.3282;Inherit;False;Property;_WhiteColorInfluence;White Color Influence;14;0;Create;True;0;0;0;False;0;False;1,0.8622642,0.8622642,0;1,0.8622642,0.8622642,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;53;-1630.867,863.9748;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1540.388,86.31465;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;6;-1448.862,-144.9784;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;61;-1798.303,380.3282;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;54;-1892.868,703.3748;Inherit;False;Constant;_DarkColorInfluence;Dark Color Influence;11;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;8;-1239.584,724.7124;Inherit;False;Property;_TextureTint;Texture Tint;2;0;Create;True;0;0;0;False;0;False;1,0.4321439,0.2235294,0;0.6721965,0.6440014,0.6792453,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1257.686,-28.61002;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;12;-1573.026,342.0184;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;52;-1276.219,487.995;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-996.3607,588.0251;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;13;-1312.188,-275.2765;Inherit;False;Property;_LightColor;LightColor;5;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;15;-1306.51,-477.1763;Inherit;False;Property;_ShadowColor;ShadowColor;4;0;Create;True;0;0;0;False;0;False;0.09382871,0.005384479,0.1037736,0;0.09382871,0.005384479,0.1037736,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1045.076,204.2418;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-740.1458,451.0726;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;17;-915.147,-256.766;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-627.61,88.17497;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-305.3212,319.7141;Inherit;False;ShadowLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;42;-2055.55,1142.602;Inherit;False;1623.33;675.8921;Comment;11;41;34;45;39;33;35;44;37;36;46;47;Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-437.86,-770.7596;Inherit;False;Property;_ShadowIntensity;Shadow Intensity;7;0;Create;True;0;0;0;False;0;False;4.1;4.29;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectSpecularLight;35;-1814.313,1368.158;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-751.4978,-930.5701;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-1892.727,1638.595;Inherit;False;Property;_HighlightScale;Highlight Scale;9;0;Create;True;0;0;0;False;0;False;0.07033552;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1924.557,1723.643;Inherit;False;Property;_Smoothness;Smoothness;8;0;Create;True;0;0;0;False;0;False;5.389696;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;48;-2099.398,1314.474;Inherit;False;Normal From Height;-1;;1;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;39;-1190.173,1207.179;Inherit;False;38;ShadowLight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;177.4954,301.5992;Inherit;False;38;ShadowLight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;-1797.73,1191.715;Inherit;False;Property;_HighlightColor;Highlight Color;11;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-1895.669,1544.859;Inherit;False;Property;_HighlightlBias;Highlightl Bias;10;0;Create;True;0;0;0;False;0;False;0.01093873;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1878.753,-357.7451;Inherit;False;Property;_Hardness;Hardness;6;0;Create;True;0;0;0;False;0;False;3.647059;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1328.904,1305.332;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1558.8,-392.7475;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;45;-1533.925,1412.961;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;34;-966.6829,1355.841;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-656.2207,1220.522;Inherit;True;Specular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;33;-1490.495,1547.505;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;9.48;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;695.2996,-67.27425;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;sndy/SimpleShadowTint;False;False;False;False;True;True;True;True;True;True;True;True;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;False;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;55;0;59;0
WireConnection;55;1;60;0
WireConnection;56;0;55;0
WireConnection;58;1;55;0
WireConnection;58;0;56;0
WireConnection;5;0;1;0
WireConnection;5;1;2;0
WireConnection;11;1;58;0
WireConnection;53;0;49;0
WireConnection;7;0;3;0
WireConnection;7;1;4;1
WireConnection;6;0;5;0
WireConnection;61;0;64;0
WireConnection;61;1;63;0
WireConnection;61;2;11;0
WireConnection;9;0;6;0
WireConnection;9;1;7;0
WireConnection;52;0;61;0
WireConnection;52;1;54;0
WireConnection;52;2;53;0
WireConnection;20;0;52;0
WireConnection;20;1;8;0
WireConnection;14;0;9;0
WireConnection;14;1;12;0
WireConnection;18;0;14;0
WireConnection;18;1;20;0
WireConnection;17;0;15;0
WireConnection;17;1;13;0
WireConnection;17;2;9;0
WireConnection;19;0;17;0
WireConnection;19;1;18;0
WireConnection;38;0;19;0
WireConnection;35;0;48;0
WireConnection;47;0;46;0
WireConnection;47;1;45;0
WireConnection;27;0;21;0
WireConnection;27;1;5;0
WireConnection;45;0;35;0
WireConnection;34;0;39;0
WireConnection;34;1;47;0
WireConnection;34;2;33;0
WireConnection;41;0;34;0
WireConnection;33;1;44;0
WireConnection;33;2;37;0
WireConnection;0;13;43;0
ASEEND*/
//CHKSM=F28FAEDD6EC7D39144F08E641ED78A624A334F38