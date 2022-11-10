// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Sunday/Flag"
{
	Properties
	{
		_Color("Color", Color) = (1,0,0,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_TimeScale("Time Scale", Float) = 5
		_Strength("Strength", Float) = 0.3
		_Width("Width", Float) = 10
		_Adjustment("Adjustment", Float) = 0
		[Toggle(_FLIPLOCKEDSIDE_ON)] _FlipLockedSide("Flip Locked Side", Float) = 0
		[Toggle(_FLIPAXIS_ON)] _FlipAxis("Flip Axis", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature_local _FLIPAXIS_ON
		#pragma shader_feature_local _FLIPLOCKEDSIDE_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _Adjustment;
		uniform float _Width;
		uniform float _TimeScale;
		uniform float _Strength;
		uniform float4 _Color;
		uniform float _Metallic;
		uniform float _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 ase_vertex3Pos = v.vertex.xyz;
			#ifdef _FLIPLOCKEDSIDE_ON
				float staticSwitch25 = ( 1.0 - v.texcoord.x );
			#else
				float staticSwitch25 = v.texcoord.x;
			#endif
			float temp_output_11_0 = ( ( sin( ( ( ase_vertex3Pos.x * _Width ) + ( _Time.y * _TimeScale ) ) ) * staticSwitch25 ) * _Strength );
			float4 appendResult15 = (float4(ase_vertexNormal.x , ( _Adjustment + ( ase_vertexNormal.y + temp_output_11_0 ) ) , ase_vertexNormal.z , 0.0));
			float4 appendResult26 = (float4(ase_vertexNormal.x , ase_vertexNormal.y , ( _Adjustment + ( temp_output_11_0 + ase_vertexNormal.z ) ) , 0.0));
			#ifdef _FLIPAXIS_ON
				float4 staticSwitch30 = appendResult26;
			#else
				float4 staticSwitch30 = appendResult15;
			#endif
			v.vertex.xyz += staticSwitch30.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color.rgb;
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
Version=18900
-38;100;1835;850;901.5314;102.0359;1.189944;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-1585.001,333.2077;Inherit;False;Property;_Width;Width;5;0;Create;True;0;0;0;False;0;False;10;6.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;2;-1626.928,89.09417;Inherit;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;17;-1336.506,556.8288;Inherit;False;Property;_TimeScale;Time Scale;3;0;Create;True;0;0;0;False;0;False;5;-5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;6;-1350.736,413.0165;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-1313.228,177.6667;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1156.101,411.075;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;9;-1170.952,625.426;Inherit;True;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;4;-997.6819,190.4346;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;-805.1442,664.2876;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;25;-702.8099,495.3163;Inherit;False;Property;_FlipLockedSide;Flip Locked Side;7;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;5;-723.7646,192.1506;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-461.9741,320.6668;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-309.0589,613.8;Inherit;False;Property;_Strength;Strength;4;0;Create;True;0;0;0;False;0;False;0.3;-0.005;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;27;-103.0785,594.0814;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-161.8086,342.6706;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;19;-342.9672,-51.20819;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-3.593281,194.9586;Inherit;False;Property;_Adjustment;Adjustment;6;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;79.9407,308.73;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;107.022,552.1651;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;20;271.3707,261.6687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;428.156,533.6625;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;405.3523,49.6439;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;26;594.2286,527.4445;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;31;143.2394,140.7128;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;153.2458,-99.94015;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;149.7482,-28.82285;Inherit;False;Property;_Smoothness;Smoothness;1;0;Create;True;0;0;0;False;0;False;0;0.408;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;133.7269,-287.5381;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;30;566.8597,213.2995;Inherit;False;Property;_FlipAxis;Flip Axis;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;792.9025,-218.6359;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Sunday/Flag;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;2;1
WireConnection;3;1;1;0
WireConnection;7;0;6;0
WireConnection;7;1;17;0
WireConnection;4;0;3;0
WireConnection;4;1;7;0
WireConnection;24;0;9;1
WireConnection;25;1;9;1
WireConnection;25;0;24;0
WireConnection;5;0;4;0
WireConnection;10;0;5;0
WireConnection;10;1;25;0
WireConnection;11;0;10;0
WireConnection;11;1;16;0
WireConnection;12;0;19;2
WireConnection;12;1;11;0
WireConnection;28;0;11;0
WireConnection;28;1;27;3
WireConnection;20;0;21;0
WireConnection;20;1;12;0
WireConnection;29;0;21;0
WireConnection;29;1;28;0
WireConnection;15;0;19;1
WireConnection;15;1;20;0
WireConnection;15;2;19;3
WireConnection;26;0;27;1
WireConnection;26;1;27;2
WireConnection;26;2;29;0
WireConnection;31;0;21;0
WireConnection;30;1;15;0
WireConnection;30;0;26;0
WireConnection;0;0;13;0
WireConnection;0;3;23;0
WireConnection;0;4;22;0
WireConnection;0;11;30;0
ASEEND*/
//CHKSM=22074A79E45DF7F4C13457D38290E4B5B3530BF2