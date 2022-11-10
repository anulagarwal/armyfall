// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndyCustomLightWithClamp"
{
	Properties
	{
		_Main("Main", 2D) = "white" {}
		_TextureOpacity("Texture Opacity", Range( 0 , 1)) = 1
		_TextureTint("Texture Tint", Color) = (1,0.4321439,0.2235294,0)
		[Toggle(_FLIPTEXTURE_ON)] _FlipTexture("Flip Texture", Float) = 0
		_ShadowColor("ShadowColor", Color) = (0.09382871,0.005384479,0.1037736,0)
		_LightColor("LightColor", Color) = (0,0,0,0)
		_Falloff("Falloff", Range( 0 , 10)) = 0
		_Distance("Distance", Range( 0 , 20)) = 0
		_Min("Min", Range( 0 , 1)) = 0
		_TextureTiling("Texture Tiling", Vector) = (1,1,0,0)
		_Max("Max", Range( 0 , 1)) = 1
		_TextureOffset("Texture Offset", Vector) = (0,0,0,0)
		_WhiteColorInfluence("White Color Influence", Color) = (1,0.8622642,0.8622642,0)
		_BlackColorInfluence("Black Color Influence", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Overlay+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend One OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _FLIPTEXTURE_ON
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float eyeDepth;
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

		uniform float _Falloff;
		uniform float _Distance;
		uniform float _Min;
		uniform float _Max;
		uniform float4 _ShadowColor;
		uniform float4 _LightColor;
		uniform float4 _BlackColorInfluence;
		uniform float4 _WhiteColorInfluence;
		uniform sampler2D _Main;
		uniform float2 _TextureTiling;
		uniform float2 _TextureOffset;
		uniform float _TextureOpacity;
		uniform float4 _TextureTint;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

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
			float cameraDepthFade68 = (( i.eyeDepth -_ProjectionParams.y - _Distance ) / _Falloff);
			float clampResult72 = clamp( saturate( cameraDepthFade68 ) , _Min , _Max );
			float FadeWithDistance73 = clampResult72;
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
			c.a = FadeWithDistance73;
			c.rgb *= c.a;
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
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.x = customInputData.eyeDepth;
				o.customPack1.yz = customInputData.uv_texcoord;
				o.customPack1.yz = v.texcoord;
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
				surfIN.eyeDepth = IN.customPack1.x;
				surfIN.uv_texcoord = IN.customPack1.yz;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;8;1273;661;102.4917;129.1087;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;40;-3178.601,-527.1761;Inherit;False;3097.279;1512.381;Comment;33;11;58;56;55;60;59;18;20;8;52;53;54;49;27;21;38;19;17;14;15;13;12;9;7;6;4;5;3;1;2;61;63;64;Shadow Light Texture Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;60;-3132.194,297.6816;Inherit;False;Property;_TextureOffset;Texture Offset;17;0;Create;True;0;0;0;False;0;False;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;59;-3133.194,161.6816;Inherit;False;Property;_TextureTiling;Texture Tiling;15;0;Create;True;0;0;0;False;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;55;-2845.209,222.4556;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;56;-2583.296,338.2473;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;2;-1981.499,31.68572;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1;-1973.092,-212.9927;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;58;-2388.32,218.0527;Inherit;False;Property;_FlipTexture;Flip Texture;4;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DotProductOpNode;5;-1691.525,-179.4867;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-1941.569,900.3748;Inherit;False;Property;_TextureOpacity;Texture Opacity;2;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;63;-2125.303,420.3282;Inherit;False;Property;_WhiteColorInfluence;White Color Influence;18;0;Create;True;0;0;0;False;0;False;1,0.8622642,0.8622642,0;1,0.8622642,0.8622642,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;64;-2124.303,244.3282;Inherit;False;Property;_BlackColorInfluence;Black Color Influence;19;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-2166.629,595.9293;Inherit;True;Property;_Main;Main;1;0;Create;True;0;0;0;False;0;False;-1;387dc9cb29c56b146a2fadccaf58cef4;92ea895d681c10a4d9d9c279d63a9c87;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;3;-1739.388,89.31465;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;4;-1885.388,208.3148;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMaxOpNode;6;-1448.862,-144.9784;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;65;-2169.463,-1514.373;Inherit;False;1346.363;481.0297;Comment;8;73;72;71;70;69;68;67;66;Fade With Distance;0.3726415,0.6757348,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;54;-1892.868,703.3748;Inherit;False;Constant;_DarkColorInfluence;Dark Color Influence;11;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;61;-1798.303,380.3282;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;53;-1630.867,863.9748;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1540.388,86.31465;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;8;-1239.584,724.7124;Inherit;False;Property;_TextureTint;Texture Tint;3;0;Create;True;0;0;0;False;0;False;1,0.4321439,0.2235294,0;0.3789193,0.7075472,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1257.686,-28.61002;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;12;-1573.026,342.0184;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;52;-1276.219,487.995;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-2118.519,-1333.784;Inherit;False;Property;_Distance;Distance;12;0;Create;True;0;0;0;False;0;False;0;4.5;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;-2115.697,-1435.784;Inherit;False;Property;_Falloff;Falloff;10;0;Create;True;0;0;0;False;0;False;0;6;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-1312.188,-275.2765;Inherit;False;Property;_LightColor;LightColor;6;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-996.3607,588.0251;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;15;-1306.51,-477.1763;Inherit;False;Property;_ShadowColor;ShadowColor;5;0;Create;True;0;0;0;False;0;False;0.09382871,0.005384479,0.1037736,0;0.490566,0.3170167,0.3866712,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1045.076,204.2418;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CameraDepthFade;68;-1810.212,-1471.904;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-1811.339,-1330.046;Inherit;False;Property;_Min;Min;14;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-1810.644,-1237.563;Inherit;False;Property;_Max;Max;16;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;69;-1544.208,-1472.327;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;17;-915.147,-256.766;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;18;-740.1458,451.0726;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-627.61,88.17497;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;72;-1377.179,-1403.401;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.3;False;2;FLOAT;0.9;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;42;-2055.55,1142.602;Inherit;False;1623.33;675.8921;Comment;11;41;34;45;39;33;35;44;37;36;46;47;Specular;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;73;-1213.742,-1407.735;Inherit;False;FadeWithDistance;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;38;-305.3212,319.7141;Inherit;False;ShadowLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;39;-1190.173,1207.179;Inherit;False;38;ShadowLight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;45;-1533.925,1412.961;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-1328.904,1305.332;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectSpecularLight;35;-1814.313,1368.158;Inherit;False;Tangent;3;0;FLOAT3;0,0,1;False;1;FLOAT;0.5;False;2;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-1878.753,-357.7451;Inherit;False;Property;_Hardness;Hardness;7;0;Create;True;0;0;0;False;0;False;3.647059;0;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;34;-966.6829,1355.841;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FresnelNode;33;-1490.495,1547.505;Inherit;True;Standard;TangentNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;9.48;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;36;-1924.557,1723.643;Inherit;False;Property;_Smoothness;Smoothness;8;0;Create;True;0;0;0;False;0;False;5.389696;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-656.2207,1220.522;Inherit;True;Specular;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1558.8,-392.7475;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;46;-1797.73,1191.715;Inherit;False;Property;_HighlightColor;Highlight Color;13;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;37;-1892.727,1638.595;Inherit;False;Property;_HighlightScale;Highlight Scale;9;0;Create;True;0;0;0;False;0;False;0.07033552;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;561.1583,269.9913;Inherit;False;73;FadeWithDistance;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;559.9789,548.584;Inherit;False;38;ShadowLight;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1895.669,1544.859;Inherit;False;Property;_HighlightlBias;Highlightl Bias;11;0;Create;True;0;0;0;False;0;False;0.01093873;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;48;-2099.398,1314.474;Inherit;False;Normal From Height;-1;;1;1942fe2c5f1a1f94881a33d532e4afeb;0;2;20;FLOAT;0;False;110;FLOAT;1;False;2;FLOAT3;40;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1077.783,179.7108;Float;False;True;-1;2;ASEMaterialInspector;0;0;CustomLighting;sndyCustomLightWithClamp;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Overlay;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;3;1;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;55;0;59;0
WireConnection;55;1;60;0
WireConnection;56;0;55;0
WireConnection;58;1;55;0
WireConnection;58;0;56;0
WireConnection;5;0;1;0
WireConnection;5;1;2;0
WireConnection;11;1;58;0
WireConnection;6;0;5;0
WireConnection;61;0;64;0
WireConnection;61;1;63;0
WireConnection;61;2;11;0
WireConnection;53;0;49;0
WireConnection;7;0;3;0
WireConnection;7;1;4;1
WireConnection;9;0;6;0
WireConnection;9;1;7;0
WireConnection;52;0;61;0
WireConnection;52;1;54;0
WireConnection;52;2;53;0
WireConnection;20;0;52;0
WireConnection;20;1;8;0
WireConnection;14;0;9;0
WireConnection;14;1;12;0
WireConnection;68;0;67;0
WireConnection;68;1;66;0
WireConnection;69;0;68;0
WireConnection;17;0;15;0
WireConnection;17;1;13;0
WireConnection;17;2;9;0
WireConnection;18;0;14;0
WireConnection;18;1;20;0
WireConnection;19;0;17;0
WireConnection;19;1;18;0
WireConnection;72;0;69;0
WireConnection;72;1;71;0
WireConnection;72;2;70;0
WireConnection;73;0;72;0
WireConnection;38;0;19;0
WireConnection;45;0;35;0
WireConnection;47;0;46;0
WireConnection;47;1;45;0
WireConnection;35;0;48;0
WireConnection;34;0;39;0
WireConnection;34;1;47;0
WireConnection;34;2;33;0
WireConnection;33;1;44;0
WireConnection;33;2;37;0
WireConnection;41;0;34;0
WireConnection;27;0;21;0
WireConnection;27;1;5;0
WireConnection;0;9;74;0
WireConnection;0;13;43;0
ASEEND*/
//CHKSM=6922EE5F0A8264F5A94B7145C070B25BB7794A55