// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CurvedSurface"
{
	Properties
	{
		_CurveX("CurveX", Range( -1 , 1)) = 0
		_CurveY("CurveY", Range( -1 , 1)) = 0
		_Albedo("Albedo", 2D) = "white" {}
		_AlbedoTint("Albedo Tint", Color) = (1,1,1,0)
		[Toggle]_EmissionOn("Emission On", Float) = 0
		_Emission("Emission", 2D) = "white" {}
		_EmissionTint("Emission Tint", Color) = (1,1,1,0)
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
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _CurveX;
		uniform float _CurveY;
		uniform float4 _AlbedoTint;
		uniform sampler2D _Albedo;
		uniform float _EmissionOn;
		uniform float4 _EmissionTint;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 matrixToPos18 = float4( float4x4( 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1 )[3][0],float4x4( 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1 )[3][1],float4x4( 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1 )[3][2],float4x4( 1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1 )[3][3]);
			float4 appendResult14 = (float4(_CurveX , _CurveY , 0.0 , 0.0));
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float cameraDepthFade29 = (( -UnityObjectToViewPos( v.vertex.xyz ).z -_ProjectionParams.y - 0.0 ) / 1.0);
			float4 temp_cast_1 = (cameraDepthFade29).xxxx;
			float4 VertexOffset59 = ( matrixToPos18 + mul( ( ( appendResult14 / 100.0 ) * pow( ( ( ase_grabScreenPosNorm * float4( _WorldSpaceCameraPos , 0.0 ) ) - temp_cast_1 ).z , 2.0 ) ), UNITY_MATRIX_IT_MV ) );
			v.vertex.xyz += VertexOffset59.xyz;
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 Albedo49 = ( _AlbedoTint * tex2D( _Albedo, i.uv_texcoord ) );
			o.Albedo = Albedo49.rgb;
			float4 color55 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float4 Emission51 = (( _EmissionOn )?( ( _EmissionTint * tex2D( _Emission, uv_Emission ) ) ):( color55 ));
			o.Emission = Emission51.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
-1920;700;1570;308;3024.115;1500.542;1.982419;True;False
Node;AmplifyShaderEditor.CommentaryNode;60;-2681.511,-154.9324;Inherit;False;1946.516;909.8007;Comment;19;31;9;6;29;8;1;2;10;14;16;15;11;20;17;22;18;24;32;59;Vertex Offset;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;9;-2631.511,456.0363;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GrabScreenPosition;31;-2545.612,-90.63122;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CameraDepthFade;29;-2319.412,594.4686;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-2272.211,325.7363;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-2189.613,107.4106;Inherit;False;Property;_CurveY;CurveY;1;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;8;-2090.208,357.7364;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-2186.613,10.41071;Inherit;False;Property;_CurveX;CurveX;0;0;Create;True;0;0;0;False;0;False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1909.759,238.2958;Inherit;False;Constant;_Float0;Float 0;3;0;Create;True;0;0;0;False;0;False;100;100;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;10;-1900.207,353.7363;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;14;-1888.76,88.29571;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;11;-1729.418,486.7025;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;15;-1715.76,186.2958;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;52;-2049.041,-846.7911;Inherit;False;1331.638;659.0848;Comment;6;55;47;51;45;46;56;Emission;1,0.9119362,0.5990566,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;48;-1837.983,-1412.922;Inherit;False;1093.969;547.1655;Comment;5;49;41;3;42;62;Albedo;0,0.5678592,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1531.76,312.2959;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.InverseTranspMVMatrixNode;20;-1730.76,584.2958;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.ColorNode;46;-1880.824,-796.7911;Inherit;False;Property;_EmissionTint;Emission Tint;6;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;47;-2000.043,-617.8318;Inherit;True;Property;_Emission;Emission;5;0;Create;True;0;0;0;False;0;False;-1;98aca841ef8b84c76921bcfb17c79953;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;62;-1798.981,-1334.019;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1327.76,422.2959;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-1603.924,-591.3907;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;42;-1483.415,-1362.922;Inherit;False;Property;_AlbedoTint;Albedo Tint;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;55;-1580.054,-792.7564;Inherit;False;Constant;_Color1;Color 1;7;0;Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1601.636,-1183.962;Inherit;True;Property;_Albedo;Albedo;2;0;Create;True;0;0;0;False;0;False;-1;04ab59309bdb57f42854f7305f8949e7;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PosFromTransformMatrix;18;-1556.76,43.29571;Inherit;False;1;0;FLOAT4x4;1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-1126.76,197.2958;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1206.514,-1157.522;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;56;-1292.343,-657.6772;Inherit;False;Property;_EmissionOn;Emission On;4;0;Create;True;0;0;0;False;0;False;0;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-994.9065,-577.4723;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;59;-958.9935,283.4616;Inherit;False;VertexOffset;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;-966.0137,-1136.722;Inherit;True;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;50;-365.0106,-476.3394;Inherit;False;49;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-369.0461,-155.9272;Inherit;False;59;VertexOffset;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;32;-2532.611,100.4686;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;53;-366.6086,-393.4542;Inherit;False;51;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-126.5588,-437.4737;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;CurvedSurface;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;6;0;31;0
WireConnection;6;1;9;0
WireConnection;8;0;6;0
WireConnection;8;1;29;0
WireConnection;10;0;8;0
WireConnection;14;0;1;0
WireConnection;14;1;2;0
WireConnection;11;0;10;2
WireConnection;15;0;14;0
WireConnection;15;1;16;0
WireConnection;17;0;15;0
WireConnection;17;1;11;0
WireConnection;22;0;17;0
WireConnection;22;1;20;0
WireConnection;45;0;46;0
WireConnection;45;1;47;0
WireConnection;3;1;62;0
WireConnection;24;0;18;0
WireConnection;24;1;22;0
WireConnection;41;0;42;0
WireConnection;41;1;3;0
WireConnection;56;0;55;0
WireConnection;56;1;45;0
WireConnection;51;0;56;0
WireConnection;59;0;24;0
WireConnection;49;0;41;0
WireConnection;0;0;50;0
WireConnection;0;2;53;0
WireConnection;0;11;61;0
ASEEND*/
//CHKSM=2AA7C6D842A460BE4D8082A2C5F02A9F65D4ECA1