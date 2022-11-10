// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndy/Vortex"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half filler;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
-1521;342;1389;677;1319.609;-249.9738;1.3;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;19;-1336.664,598.8655;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;50;-355.5377,-321.1974;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;20;-1183.701,-544.1263;Inherit;False;Property;_CenterColor;Center Color;0;1;[HDR];Create;True;0;0;0;False;0;False;0,6.039307,10.68063,0;0,0.5595119,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-755.4235,-153.3582;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;1.26;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;51;-1221.178,-353.1492;Inherit;False;Property;_OuterColor;Outer Color;1;1;[HDR];Create;True;0;0;0;False;0;False;0.5472606,0,4.355283,0;0,0.5595119,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;55;-1053.952,-162.7702;Inherit;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;54;-1395.146,-165.452;Inherit;True;Polar Coordinates;-1;;2;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;41;-13.67258,209.1209;Inherit;False;Property;_UseMask;Use Mask;7;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;39;-286.2008,541.382;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;61;-498.0089,719.2735;Inherit;False;Property;_FlipMask;Flip Mask;9;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VoronoiNode;14;-518.8243,365.7169;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.RangedFloatNode;42;-859.6592,523.843;Inherit;False;Property;_NoiseAngle;Noise Angle;6;0;Create;True;0;0;0;False;0;False;-0.66;-0.66;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-858.6592,603.843;Inherit;False;Property;_NoiseScale;Noise Scale;5;0;Create;True;0;0;0;False;0;False;2.61;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;62;-660.5093,954.5739;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RotatorNode;38;-837.3436,286.8185;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;6;-966.3096,747.7297;Inherit;True;Property;_Mask;Mask;8;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;9;-1159.675,215.5306;Inherit;True;Twirl;-1;;1;90936742ac32db8449cd21ab6dd337c8;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-1099.395,488.9117;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1545.042,266.0042;Inherit;False;Property;_TwirlStrength;Twirl Strength;3;0;Create;True;0;0;0;False;0;False;6.637609;42.51091;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1568.262,412.028;Inherit;False;Property;_RotationSpeed;Rotation Speed;4;0;Create;True;0;0;0;False;0;False;1;0.5647059;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-1101.182,87.16913;Inherit;False;Property;_ColorBalance;Color Balance;2;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;63;207.609,-153.1564;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;sndy/Vortex;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;50;0;20;0
WireConnection;50;1;51;0
WireConnection;50;2;59;0
WireConnection;59;0;55;0
WireConnection;59;1;60;0
WireConnection;55;0;54;0
WireConnection;41;1;14;0
WireConnection;41;0;39;0
WireConnection;39;1;14;0
WireConnection;39;2;61;0
WireConnection;61;1;6;0
WireConnection;61;0;62;0
WireConnection;14;0;38;0
WireConnection;14;1;42;0
WireConnection;14;2;43;0
WireConnection;62;0;6;0
WireConnection;38;0;9;0
WireConnection;38;2;16;0
WireConnection;9;3;10;0
WireConnection;16;0;15;0
WireConnection;16;1;19;0
ASEEND*/
//CHKSM=BAC881BDD5659A75839A8E1EC0BFE9D3DFAF16E7