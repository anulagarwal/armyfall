// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndy/Charge"
{
	Properties
	{
		_Tint("Tint", Color) = (0,0,0,0)
		_Main("Main", 2D) = "white" {}
		_Speed("Speed", Range( 0 , 10)) = 1
		_StartOffset("Start Offset", Range( 0 , 1)) = 0
		_RotationSpeed("Rotation Speed", Range( 0 , 2)) = 0
		_RotationOffset("Rotation Offset", Range( 0 , 1)) = 0
		_Intensity("Intensity", Range( 0 , 1)) = 1
		_MaskOut("Mask Out", 2D) = "white" {}
		_MaskIn("Mask In", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Front
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Tint;
		uniform sampler2D _Main;
		uniform float _RotationOffset;
		uniform float _RotationSpeed;
		uniform float _Speed;
		uniform float _StartOffset;
		uniform sampler2D _MaskOut;
		uniform float4 _MaskOut_ST;
		uniform sampler2D _MaskIn;
		uniform float _Intensity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 appendResult6 = (float4(( _RotationOffset + ( _RotationSpeed * _Time.y ) ) , ( 1.0 - ( ( _Speed * _Time.y ) + _StartOffset ) ) , 0.0 , 0.0));
			float2 uv_TexCoord2 = i.uv_texcoord + appendResult6.xy;
			float4 tex2DNode1 = tex2D( _Main, uv_TexCoord2 );
			float4 Texture13 = ( _Tint + tex2DNode1 );
			o.Emission = Texture13.rgb;
			float4 Transparency32 = tex2DNode1;
			float2 uv_MaskOut = i.uv_texcoord * _MaskOut_ST.xy + _MaskOut_ST.zw;
			o.Alpha = ( ( ( Transparency32 * tex2D( _MaskOut, uv_MaskOut ) ) * tex2D( _MaskIn, i.uv_texcoord ) ) * _Intensity ).r;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

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
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
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
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
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
-3424.8;21.6;1532;791;2223.037;958.1819;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;15;-1914.57,-840.6014;Inherit;False;1949.822;621.6268;Comment;18;5;6;8;13;32;12;1;10;2;3;52;68;69;70;71;72;73;74;TextureMovement;0.9433962,0.4076805,0,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1852.609,-450.2043;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1889.141,-544.7877;Inherit;False;Property;_Speed;Speed;2;0;Create;True;0;0;0;False;0;False;1;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;69;-1824.037,-334.1819;Inherit;False;Property;_StartOffset;Start Offset;3;0;Create;True;0;0;0;False;0;False;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;72;-1714.984,-636.7542;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1606.716,-533.0598;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1883.037,-722.1819;Inherit;False;Property;_RotationSpeed;Rotation Speed;4;0;Create;True;0;0;0;False;0;False;0;0.26;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;71;-1485.091,-669.6097;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-1686.601,-789.3182;Inherit;False;Property;_RotationOffset;Rotation Offset;5;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;70;-1510.037,-401.1819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-1345.037,-716.1819;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;52;-1395.463,-515.6628;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;6;-1211.124,-608.9237;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;2;-1041.677,-538.1156;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-797.0695,-557.6856;Inherit;True;Property;_Main;Main;1;0;Create;True;0;0;0;False;0;False;-1;18a25a13d8542ee429133e0d786f91e0;18a25a13d8542ee429133e0d786f91e0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-447.0809,-446.3532;Inherit;False;Transparency;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;54;-1575.374,250.9372;Inherit;True;Property;_MaskOut;Mask Out;7;0;Create;True;0;0;0;False;0;False;-1;eb6e18607cef13a459dc27db6c70433a;eb6e18607cef13a459dc27db6c70433a;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-732.274,-790.6014;Inherit;False;Property;_Tint;Tint;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;1,0.3940722,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;67;-1433.115,514.1521;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;33;-1216.928,158.6358;Inherit;True;32;Transparency;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;65;-1154.115,472.1521;Inherit;True;Property;_MaskIn;Mask In;8;0;Create;True;0;0;0;False;0;False;-1;3ad12780d1f8ecf4686358180372f688;3ad12780d1f8ecf4686358180372f688;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-927.3229,190.9549;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-392.2738,-622.6016;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-618.1152,244.1521;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-188.7478,-631.3104;Inherit;False;Texture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-415.9861,489.9985;Inherit;False;Property;_Intensity;Intensity;6;0;Create;True;0;0;0;False;0;False;1;0.672;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;14;-156.235,-15.14303;Inherit;False;13;Texture;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TimeNode;47;-763.2313,-28.62466;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-185.7242,189.1223;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;159,-22;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;sndy/Charge;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;5;0;8;0
WireConnection;5;1;3;0
WireConnection;71;0;73;0
WireConnection;71;1;72;0
WireConnection;70;0;5;0
WireConnection;70;1;69;0
WireConnection;74;0;68;0
WireConnection;74;1;71;0
WireConnection;52;0;70;0
WireConnection;6;0;74;0
WireConnection;6;1;52;0
WireConnection;2;1;6;0
WireConnection;1;1;2;0
WireConnection;32;0;1;0
WireConnection;65;1;67;0
WireConnection;53;0;33;0
WireConnection;53;1;54;0
WireConnection;12;0;10;0
WireConnection;12;1;1;0
WireConnection;64;0;53;0
WireConnection;64;1;65;0
WireConnection;13;0;12;0
WireConnection;50;0;64;0
WireConnection;50;1;44;0
WireConnection;0;2;14;0
WireConnection;0;9;50;0
ASEEND*/
//CHKSM=FF40BF0810C03CF703FEDB62E45B9E772F93A57D