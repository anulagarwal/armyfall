// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndy/SimpleWater"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Color1("Color 1", Color) = (0.2431372,0.6039216,0.3446084,0)
		_Color0("Color 0", Color) = (0.5990566,1,0.8536515,0)
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_size("size", Range( 0 , 10)) = 2.476316
		_depthFadeDistance("depthFadeDistance", Range( 0 , 10)) = 0
		_depthFadeFallOff("depthFadeFallOff", Range( 0 , 10)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
		};

		uniform float4 _Color1;
		uniform float4 _Color0;
		uniform sampler2D _TextureSample0;
		uniform float _size;
		uniform sampler2D _TextureSample1;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _depthFadeDistance;
		uniform float _depthFadeFallOff;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 appendResult12 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_14_0 = (appendResult12*_size + 0.0);
			float2 panner29 = ( 1.0 * _Time.y * float2( 0.1,0.2 ) + temp_output_14_0);
			float2 panner30 = ( 0.1 * _Time.y * float2( -0.5,-0.3 ) + (temp_output_14_0*0.3 + 0.0));
			float4 lerpResult8 = lerp( _Color1 , _Color0 , ( tex2D( _TextureSample0, panner29 ) * tex2D( _TextureSample1, panner30 ) ));
			float4 color21 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth18 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth18 = abs( ( screenDepth18 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _depthFadeDistance ) );
			o.Emission = ( lerpResult8 + saturate( ( color21 * ( ( 1.0 - distanceDepth18 ) / _depthFadeFallOff ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
90.4;84.8;1290.4;644.6;941.804;263.3254;1;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;11;-1340.153,-57.60699;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;12;-1146.082,-28.78096;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1313.355,98.87719;Inherit;False;Property;_size;size;4;0;Create;True;0;0;0;False;0;False;2.476316;0.22;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-519.8711,743.7041;Inherit;False;Property;_depthFadeDistance;depthFadeDistance;5;0;Create;True;0;0;0;False;0;False;0;1.08;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;14;-1001.763,90.85437;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;31;-1005.27,316.4079;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0.3;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DepthFade;18;-251.3687,629.367;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;19.90817,655.9558;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;30;-762.1005,336.4338;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.5,-0.3;False;1;FLOAT;0.1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;29;-764.9603,199.1136;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.2;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-261.9474,847.4064;Inherit;False;Property;_depthFadeFallOff;depthFadeFallOff;6;0;Create;True;0;0;0;False;0;False;0;1.94;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-519.7571,197.041;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;d7411be06f377e348b0221bfceeff41e;d7411be06f377e348b0221bfceeff41e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;172.8012,767.6352;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-533.7,382.7;Inherit;True;Property;_TextureSample1;Texture Sample 1;3;0;Create;True;0;0;0;False;0;False;-1;be0c1fd6197626c4fa1d84e76c49495c;be0c1fd6197626c4fa1d84e76c49495c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;81.08532,378.6385;Inherit;False;Constant;_Color2;Color 2;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-439.7,-199.3;Inherit;False;Property;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;0.2431372,0.6039216,0.3446084,0;0.2431372,0.6001562,0.6039216,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;328.3521,463.1778;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-197.5818,325.5518;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1;-441.7,-22.30002;Inherit;False;Property;_Color0;Color 0;2;0;Create;True;0;0;0;False;0;False;0.5990566,1,0.8536515,0;0.5990566,1,0.8536515,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;26;553.04,521.6765;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;8;33.68868,61.49686;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;541.2854,187.1308;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;864.1071,79.29074;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;sndy/SimpleWater;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;1
WireConnection;12;1;11;3
WireConnection;14;0;12;0
WireConnection;14;1;15;0
WireConnection;31;0;14;0
WireConnection;18;0;22;0
WireConnection;24;0;18;0
WireConnection;30;0;31;0
WireConnection;29;0;14;0
WireConnection;3;1;29;0
WireConnection;27;0;24;0
WireConnection;27;1;28;0
WireConnection;6;1;30;0
WireConnection;20;0;21;0
WireConnection;20;1;27;0
WireConnection;9;0;3;0
WireConnection;9;1;6;0
WireConnection;26;0;20;0
WireConnection;8;0;7;0
WireConnection;8;1;1;0
WireConnection;8;2;9;0
WireConnection;25;0;8;0
WireConnection;25;1;26;0
WireConnection;0;2;25;0
ASEEND*/
//CHKSM=F72C55C43394D6B64A643061827F9801658CE67E