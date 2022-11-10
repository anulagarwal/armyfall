// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "DistanceBlend"
{
	Properties
	{
		[Header(Albedo)]_MainTex("Main Tex", 2D) = "white" {}
		_Tint("Tint", Color) = (1,1,1,0)
		[Header(Distance Blend)]_FarBlendColor("Far Blend Color", Color) = (0.2335347,1,0,0)
		_SaturationFar("Saturation Far", Range( 0 , 1)) = 0.3426822
		_CloseBlendColor("Close Blend Color", Color) = (1,1,1,0)
		_SaturationClose("Saturation Close", Range( 0 , 1)) = 1
		_TransitionDistance("Transition Distance", Range( 0 , 500)) = 10.14719
		_TransitionFalloff("Transition Falloff", Range( 0 , 50)) = 5
		[Header(Rim)]_RimColor("Rim Color", Color) = (0,0.5549643,1,0)
		_RimLightAlpha("Rim Light Alpha", Range( 0 , 1)) = 0
		_RimSmoothstep("Rim Smoothstep", Range( 0.1 , 3)) = 0
		_RimDotAdd("Rim Dot Add", Float) = 0.24
		[Header(Weighted Vertex (Optional))]_VertexColor("Vertex Color", Color) = (1,0,0,0)
		[Header(Checker)]_Checker1("Checker 1", Color) = (1,1,1,0)
		_Checker2("Checker 2", Color) = (0,0,0,0)
		_CheckerAlpha("Checker Alpha", Range( 0 , 1)) = 0
		_CheckerOffset("Checker Offset", Vector) = (0,0,0,0)
		_CheckerTiling("Checker Tiling", Int) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform float _RimLightAlpha;
		uniform float _RimSmoothstep;
		uniform float _RimDotAdd;
		uniform float4 _RimColor;
		uniform float4 _VertexColor;
		uniform float4 _Checker1;
		uniform float4 _Checker2;
		uniform int _CheckerTiling;
		uniform float2 _CheckerOffset;
		uniform float _CheckerAlpha;
		uniform float4 _CloseBlendColor;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _SaturationClose;
		uniform float _SaturationFar;
		uniform float4 _FarBlendColor;
		uniform float _TransitionDistance;
		uniform float _TransitionFalloff;
		uniform float4 _Tint;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float3 mainLight155 = ( 1 * ase_lightColor.rgb );
			float3 lerpResult138 = lerp( float3( 1,1,1 ) , mainLight155 , _RimLightAlpha);
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_normWorldNormal = normalize( ase_worldNormal );
			float3 worldNormal159 = ase_normWorldNormal;
			float dotResult148 = dot( ase_worldViewDir , worldNormal159 );
			float smoothstepResult137 = smoothstep( 0.0 , _RimSmoothstep , ( 1.0 - saturate( ( dotResult148 + _RimDotAdd ) ) ));
			float4 Rim151 = ( float4( lerpResult138 , 0.0 ) * smoothstepResult137 * _RimColor );
			float2 temp_cast_1 = _CheckerTiling;
			float2 uv_TexCoord218 = i.uv_texcoord * temp_cast_1 + _CheckerOffset;
			float2 FinalUV13_g4 = ( float2( 1,1 ) * ( 0.5 + uv_TexCoord218 ) );
			float2 temp_cast_2 = (0.5).xx;
			float2 temp_cast_3 = (1.0).xx;
			float4 appendResult16_g4 = (float4(ddx( FinalUV13_g4 ) , ddy( FinalUV13_g4 )));
			float4 UVDerivatives17_g4 = appendResult16_g4;
			float4 break28_g4 = UVDerivatives17_g4;
			float2 appendResult19_g4 = (float2(break28_g4.x , break28_g4.z));
			float2 appendResult20_g4 = (float2(break28_g4.x , break28_g4.z));
			float dotResult24_g4 = dot( appendResult19_g4 , appendResult20_g4 );
			float2 appendResult21_g4 = (float2(break28_g4.y , break28_g4.w));
			float2 appendResult22_g4 = (float2(break28_g4.y , break28_g4.w));
			float dotResult23_g4 = dot( appendResult21_g4 , appendResult22_g4 );
			float2 appendResult25_g4 = (float2(dotResult24_g4 , dotResult23_g4));
			float2 derivativesLength29_g4 = sqrt( appendResult25_g4 );
			float2 temp_cast_4 = (-1.0).xx;
			float2 temp_cast_5 = (1.0).xx;
			float2 clampResult57_g4 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g4 + 0.25 ) ) - temp_cast_2 ) ) * 4.0 ) - temp_cast_3 ) * ( 0.35 / derivativesLength29_g4 ) ) , temp_cast_4 , temp_cast_5 );
			float2 break71_g4 = clampResult57_g4;
			float2 break55_g4 = derivativesLength29_g4;
			float4 lerpResult73_g4 = lerp( _Checker1 , _Checker2 , saturate( ( 0.5 + ( 0.5 * break71_g4.x * break71_g4.y * sqrt( saturate( ( 1.1 - max( break55_g4.x , break55_g4.y ) ) ) ) ) ) ));
			float4 lerpResult211 = lerp( float4( 1,1,1,0 ) , lerpResult73_g4 , _CheckerAlpha);
			float4 Checkerboard214 = lerpResult211;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode12 = tex2D( _MainTex, uv_MainTex );
			float4 temp_output_36_0 = ( tex2DNode12 + tex2DNode12 );
			float4 lerpResult39 = lerp( tex2DNode12 , temp_output_36_0 , _SaturationClose);
			float4 TextureClose122 = lerpResult39;
			float4 lerpResult54 = lerp( temp_output_36_0 , tex2DNode12 , ( 1.0 - _SaturationFar ));
			float4 TextureFar121 = lerpResult54;
			float clampResult9 = clamp( pow( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _TransitionDistance ) , _TransitionFalloff ) , 0.0 , 1.0 );
			float DistanceClamp41 = clampResult9;
			float4 lerpResult34 = lerp( ( _CloseBlendColor * TextureClose122 ) , ( TextureFar121 * _FarBlendColor ) , DistanceClamp41);
			float4 Albedo81 = ( Checkerboard214 * lerpResult34 * _Tint );
			float4 lerpResult135 = lerp( ( _VertexColor * Albedo81 ) , Albedo81 , i.vertexColor);
			o.Albedo = ( Rim151 + lerpResult135 ).rgb;
			o.Metallic = 0.0;
			o.Smoothness = 0.0;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float3 worldNormal : TEXCOORD3;
				half4 color : COLOR0;
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
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.worldNormal = worldNormal;
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = IN.worldNormal;
				surfIN.vertexColor = IN.color;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
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
2;38;1913;981;1177.812;2149.57;3.077925;True;False
Node;AmplifyShaderEditor.CommentaryNode;42;-1035.17,117.4226;Inherit;False;1972.5;563.1619;Comment;9;32;4;41;9;7;33;6;1;2;Distance Clamp;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-882.4714,188.8398;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceCameraPos;1;-897.7192,388.797;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;223;-1856.637,-2050.561;Inherit;False;1843.321;610.1708;Comment;9;219;222;218;216;217;213;212;211;214;Checker;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;158;-1998.979,1152.288;Inherit;False;1109;303;;4;162;161;160;159;Normals;1,1,1,1;0;0
Node;AmplifyShaderEditor.DistanceOpNode;4;-566.6765,181.8355;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;32;-371.7976,423.1208;Inherit;False;Property;_TransitionDistance;Transition Distance;7;0;Create;True;0;0;0;False;0;False;10.14719;126;0;500;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;83;-1860.181,-1256.233;Inherit;False;3142.481;1288.686;Comment;22;172;81;209;210;34;43;14;61;122;60;10;121;54;39;36;86;58;40;85;55;12;215;Albedo;0.1827594,1,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-593.1221,-558.3987;Inherit;False;Property;_SaturationFar;Saturation Far;3;0;Create;True;0;0;0;False;0;False;0.3426822;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;222;-1806.637,-1993.1;Inherit;False;Property;_CheckerTiling;Checker Tiling;24;0;Create;True;0;0;0;False;0;False;1;1;False;0;1;INT;0
Node;AmplifyShaderEditor.Vector2Node;219;-1753.168,-1820.258;Inherit;False;Property;_CheckerOffset;Checker Offset;23;0;Create;True;0;0;0;False;0;False;0,0;0.96,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleDivideOpNode;6;-44.79738,234.6281;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-1386.707,-858.2128;Inherit;True;Property;_MainTex;Main Tex;0;1;[Header];Create;True;1;Albedo;0;0;False;0;False;-1;None;8adacc9260a82469dba594bf5180a3be;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-159.702,528.464;Inherit;False;Property;_TransitionFalloff;Transition Falloff;9;0;Create;True;0;0;0;False;0;False;5;3.5;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;162;-1372.982,1202.288;Inherit;True;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;40;-493.3737,-745.0999;Inherit;False;Property;_SaturationClose;Saturation Close;5;0;Create;True;0;0;0;False;0;False;1;0.825;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;218;-1322.929,-2000.56;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;86;-522.9672,-644.0964;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;85;-284.0399,-553.3259;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;217;-1335.364,-1652.39;Inherit;False;Property;_Checker2;Checker 2;21;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;136;-770.4154,851.4845;Inherit;False;1778.676;659.1279;;15;150;149;148;147;146;145;144;143;142;141;140;138;137;151;171;Rim Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;58;-502.6691,-932.41;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-708.3583,-869.0349;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;7;148.1458,228.0462;Inherit;True;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;216;-1325.416,-1860.05;Inherit;False;Property;_Checker1;Checker 1;20;1;[Header];Create;True;1;Checker;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;159;-1132.982,1202.288;Inherit;False;worldNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;9;431.3465,224.7626;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;212;-919.6198,-1645.474;Inherit;False;Property;_CheckerAlpha;Checker Alpha;22;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;54;-72.95505,-702.9947;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;150;-720.4154,1058.963;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;149;-720.4154,1218.963;Inherit;True;159;worldNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;39;-238.5206,-992.3267;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;213;-923.6976,-1890.603;Inherit;False;Checkerboard;-1;;4;43dad715d66e03a4c8ad5f9564018081;0;4;1;FLOAT2;0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;140.128,-703.3998;Inherit;False;TextureFar;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-42.74309,-998.6225;Inherit;False;TextureClose;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;148;-464.4155,1138.963;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;708.3293,256.989;Inherit;False;DistanceClamp;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;157;-1535.483,924.4572;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;60;-349.3359,-1211.769;Inherit;False;Property;_CloseBlendColor;Close Blend Color;4;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,0.9490196,0.3725483,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;154;-1595.158,828.0081;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;147;-464.4155,1250.963;Float;False;Property;_RimDotAdd;Rim Dot Add;16;0;Create;True;0;0;0;False;0;False;0.24;0.33;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;10;168.2249,-277.5929;Inherit;False;Property;_FarBlendColor;Far Blend Color;2;1;[Header];Create;True;1;Distance Blend;0;0;False;0;False;0.2335347,1,0,0;0,0.8773585,0.5683796,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;211;-484.3369,-1672.905;Inherit;False;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;-1334.922,832.968;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;214;-237.3149,-1615.303;Inherit;False;Checkerboard;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;438.3722,-319.466;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;145;-240.4156,1138.963;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;178.7315,-1136.392;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;490.0478,-117.3823;Inherit;False;41;DistanceClamp;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;144;-112.4156,1138.963;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;155;-1181.158,843.008;Inherit;False;mainLight;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;215;482.8567,-633.524;Inherit;False;214;Checkerboard;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;34;630.2714,-533.9991;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;210;642.0833,-333.7808;Inherit;False;Property;_Tint;Tint;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;142;-32.62468,919.4845;Inherit;False;155;mainLight;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;171;-58.11035,1248.091;Inherit;False;Property;_RimSmoothstep;Rim Smoothstep;15;0;Create;True;0;0;0;False;0;False;0;1.07;0.1;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;146;31.58411,1138.963;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;209;866.0901,-553.4621;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;141;-67.25481,1016.095;Inherit;False;Property;_RimLightAlpha;Rim Light Alpha;14;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;81;1050.333,-538.9764;Inherit;True;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;143;225.7118,1303.219;Inherit;False;Property;_RimColor;Rim Color;13;1;[Header];Create;True;1;Rim;0;0;False;0;False;0,0.5549643,1,0;1,0,0.302545,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;138;287.5838,962.9629;Inherit;False;3;0;FLOAT3;1,1,1;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;137;223.5838,1138.963;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;134;1347.279,-226.9736;Inherit;False;Property;_VertexColor;Vertex Color;17;1;[Header];Create;True;1;Weighted Vertex (Optional);0;0;False;0;False;1,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;82;1428.366,30.3555;Inherit;False;81;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;140;543.5838,1122.963;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;151;759.6628,1186.549;Inherit;False;Rim;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;132;1713.621,225.8872;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;1634.006,-219.9803;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;135;1942.487,10.19261;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;2006.735,-77.90756;Inherit;False;151;Rim;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;101;-1103.074,1655.988;Inherit;False;2108.588;1208.89;Comment;20;118;119;113;114;120;112;111;110;117;109;115;108;106;107;105;104;116;102;103;123;Shadow Light Texture Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;199;2173.367,-445.2086;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.6;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;201;1943.036,-307.571;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;117;-102.1636,2428.081;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;115;-630.1137,2565.857;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;52;2625.8,241.8294;Inherit;False;Constant;_Smoothness;Smoothness;8;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;204;2608.751,-497.174;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;119;-359.1785,2764.5;Inherit;False;81;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;103;-1030.18,2010.845;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;112;351.5581,2210.499;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;160;-1676.982,1202.288;Inherit;True;Property;_Normal;Normal;11;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;197;1937.421,-599.6993;Inherit;False;Constant;_Color0;Color 0;17;0;Create;True;0;0;0;False;0;False;1,0.2688679,0.2688679,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;167;-1639.197,150.7553;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;172;-690.4187,-1154.007;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;-363.2408,2641.407;Inherit;False;121;TextureFar;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;170;-1454.169,46.01534;Inherit;False;Reconstruct World Position From Depth;-1;;6;e7094bcbcc80eb140b2a3dbe6a861de8;0;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-1948.981,1250.288;Inherit;False;Property;_NormalScale;Normal Scale;12;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;109;-363.5975,1746.662;Inherit;False;Property;_ShadowColor;ShadowColor;6;0;Create;True;0;0;0;False;0;False;0.529434,0,0.5754717,0;0.7264151,0.05105435,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-615.8878,1831.091;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;111;27.7654,1967.072;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;107;-505.9497,2078.861;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;655.138,2059.121;Inherit;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;108;-314.7736,2195.229;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightAttenuation;104;-796.4759,2313.154;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;102;-1038.587,2255.525;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector2Node;206;1353.161,-466.2758;Inherit;False;Property;_Vector0;Vector 0;19;0;Create;True;0;0;0;False;0;False;0,0;-1.24,0.92;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LightColorNode;116;-942.4756,2432.154;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-597.4757,2310.154;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;152;2257.702,-71.71739;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TransformPositionNode;169;-1423.435,124.2101;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;196;1345.924,-644.1736;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;53;2624.361,166.2571;Inherit;False;Constant;_Metallic;Metallic;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosFromTransformMatrix;168;-1402.896,328.9052;Inherit;False;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;105;-748.6128,2044.351;Inherit;False;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;205;1677.594,-564.5885;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;202;1582.09,-356.7275;Inherit;False;Property;_Float0;Float 0;18;0;Create;True;0;0;0;False;0;False;0.47;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-1008.072,1828.883;Inherit;False;Property;_Hardness;Hardness;10;0;Create;True;0;0;0;False;0;False;2.980268;2.980268;1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;198;2351.735,-591.2729;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;110;-369.2756,1948.561;Inherit;False;Property;_LightColor;LightColor;8;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;200;1895.284,-424.1415;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;68.4745,2519.416;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;225;3010.24,124.6215;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;DistanceBlend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;2;0
WireConnection;4;1;1;0
WireConnection;6;0;4;0
WireConnection;6;1;32;0
WireConnection;218;0;222;0
WireConnection;218;1;219;0
WireConnection;86;0;12;0
WireConnection;85;0;55;0
WireConnection;58;0;12;0
WireConnection;36;0;12;0
WireConnection;36;1;12;0
WireConnection;7;0;6;0
WireConnection;7;1;33;0
WireConnection;159;0;162;0
WireConnection;9;0;7;0
WireConnection;54;0;36;0
WireConnection;54;1;86;0
WireConnection;54;2;85;0
WireConnection;39;0;58;0
WireConnection;39;1;36;0
WireConnection;39;2;40;0
WireConnection;213;1;218;0
WireConnection;213;2;216;0
WireConnection;213;3;217;0
WireConnection;121;0;54;0
WireConnection;122;0;39;0
WireConnection;148;0;150;0
WireConnection;148;1;149;0
WireConnection;41;0;9;0
WireConnection;211;1;213;0
WireConnection;211;2;212;0
WireConnection;156;0;154;0
WireConnection;156;1;157;1
WireConnection;214;0;211;0
WireConnection;14;0;121;0
WireConnection;14;1;10;0
WireConnection;145;0;148;0
WireConnection;145;1;147;0
WireConnection;61;0;60;0
WireConnection;61;1;122;0
WireConnection;144;0;145;0
WireConnection;155;0;156;0
WireConnection;34;0;61;0
WireConnection;34;1;14;0
WireConnection;34;2;43;0
WireConnection;146;0;144;0
WireConnection;209;0;215;0
WireConnection;209;1;34;0
WireConnection;209;2;210;0
WireConnection;81;0;209;0
WireConnection;138;1;142;0
WireConnection;138;2;141;0
WireConnection;137;0;146;0
WireConnection;137;2;171;0
WireConnection;140;0;138;0
WireConnection;140;1;137;0
WireConnection;140;2;143;0
WireConnection;151;0;140;0
WireConnection;133;0;134;0
WireConnection;133;1;82;0
WireConnection;135;0;133;0
WireConnection;135;1;82;0
WireConnection;135;2;132;0
WireConnection;199;0;200;0
WireConnection;199;1;201;0
WireConnection;201;0;202;0
WireConnection;117;0;108;0
WireConnection;117;1;115;0
WireConnection;204;0;198;0
WireConnection;112;0;111;0
WireConnection;112;1;118;0
WireConnection;160;5;161;0
WireConnection;172;0;12;0
WireConnection;172;1;36;0
WireConnection;113;0;114;0
WireConnection;113;1;105;0
WireConnection;111;0;109;0
WireConnection;111;1;110;0
WireConnection;111;2;108;0
WireConnection;107;0;105;0
WireConnection;120;0;112;0
WireConnection;108;0;107;0
WireConnection;108;1;106;0
WireConnection;106;0;104;0
WireConnection;106;1;116;1
WireConnection;152;0;153;0
WireConnection;152;1;135;0
WireConnection;169;0;167;0
WireConnection;105;0;103;2
WireConnection;105;1;102;0
WireConnection;205;0;196;2
WireConnection;205;1;206;1
WireConnection;205;2;206;2
WireConnection;198;0;197;0
WireConnection;198;2;199;0
WireConnection;200;0;205;0
WireConnection;118;0;117;0
WireConnection;118;1;119;0
WireConnection;225;0;152;0
WireConnection;225;3;53;0
WireConnection;225;4;52;0
ASEEND*/
//CHKSM=4EDFC8C5308821C65DA5589695A71B89968CEB6F