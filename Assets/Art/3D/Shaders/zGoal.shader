// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndy/Goal"
{
	Properties
	{
		_Frequency("Frequency", Range( 0 , 10)) = 4.353319
		_Color2("Color 2", Color) = (0,0,0,0)
		_Color3("Color 3", Color) = (1,1,1,0)
		[Toggle]_verticalhorizontal("vertical/horizontal", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Unlit keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform float _Frequency;
		uniform float _verticalhorizontal;

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float2 temp_cast_0 = (_Frequency).xx;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult16 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 appendResult18 = (float2(ase_worldPos.x , ase_worldPos.y));
			float2 FinalUV13_g1 = ( temp_cast_0 * ( 0.5 + (( _verticalhorizontal )?( appendResult18 ):( appendResult16 )) ) );
			float2 temp_cast_1 = (0.5).xx;
			float2 temp_cast_2 = (1.0).xx;
			float4 appendResult16_g1 = (float4(ddx( FinalUV13_g1 ) , ddy( FinalUV13_g1 )));
			float4 UVDerivatives17_g1 = appendResult16_g1;
			float4 break28_g1 = UVDerivatives17_g1;
			float2 appendResult19_g1 = (float2(break28_g1.x , break28_g1.z));
			float2 appendResult20_g1 = (float2(break28_g1.x , break28_g1.z));
			float dotResult24_g1 = dot( appendResult19_g1 , appendResult20_g1 );
			float2 appendResult21_g1 = (float2(break28_g1.y , break28_g1.w));
			float2 appendResult22_g1 = (float2(break28_g1.y , break28_g1.w));
			float dotResult23_g1 = dot( appendResult21_g1 , appendResult22_g1 );
			float2 appendResult25_g1 = (float2(dotResult24_g1 , dotResult23_g1));
			float2 derivativesLength29_g1 = sqrt( appendResult25_g1 );
			float2 temp_cast_3 = (-1.0).xx;
			float2 temp_cast_4 = (1.0).xx;
			float2 clampResult57_g1 = clamp( ( ( ( abs( ( frac( ( FinalUV13_g1 + 0.25 ) ) - temp_cast_1 ) ) * 4.0 ) - temp_cast_2 ) * ( 0.35 / derivativesLength29_g1 ) ) , temp_cast_3 , temp_cast_4 );
			float2 break71_g1 = clampResult57_g1;
			float2 break55_g1 = derivativesLength29_g1;
			float4 lerpResult73_g1 = lerp( _Color2 , _Color3 , saturate( ( 0.5 + ( 0.5 * break71_g1.x * break71_g1.y * sqrt( saturate( ( 1.1 - max( break55_g1.x , break55_g1.y ) ) ) ) ) ) ));
			o.Emission = lerpResult73_g1.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
90.4;84.8;1290.4;644.6;2563.935;1117.936;3.298609;True;False
Node;AmplifyShaderEditor.WorldPosInputsNode;15;-991.4896,-291.1745;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;16;-778.7121,-266.0727;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-772.1129,-167.7663;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-614.237,249.4438;Inherit;False;Property;_Frequency;Frequency;0;0;Create;True;0;0;0;False;0;False;4.353319;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-517.8923,84.49223;Inherit;False;Property;_Color3;Color 3;2;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;-522.2715,-68.78137;Inherit;False;Property;_Color2;Color 2;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;17;-539.1138,-294.7664;Inherit;False;Property;_verticalhorizontal;vertical/horizontal;3;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;10;-202.7664,96.80716;Inherit;True;Checkerboard;-1;;1;43dad715d66e03a4c8ad5f9564018081;0;4;1;FLOAT2;0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;FLOAT2;0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;379.8001,-10.9;Float;False;True;-1;2;ASEMaterialInspector;0;0;Unlit;sndy/Goal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;16;0;15;1
WireConnection;16;1;15;3
WireConnection;18;0;15;1
WireConnection;18;1;15;2
WireConnection;17;0;16;0
WireConnection;17;1;18;0
WireConnection;10;1;17;0
WireConnection;10;2;12;0
WireConnection;10;3;13;0
WireConnection;10;4;11;0
WireConnection;0;2;10;0
ASEEND*/
//CHKSM=CDDC4CC69689EA0DDCD7A12D3CBF73AD38B4B4E2