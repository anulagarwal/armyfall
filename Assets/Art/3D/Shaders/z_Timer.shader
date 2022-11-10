// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SUNDAY/Timer"
{
	Properties
	{
		_Level("Level", Range( 0 , 1)) = 1
		_Color0("Color 0", Color) = (1,1,1,0)
		_ColorBlink("ColorBlink", Color) = (0.05795654,0.06394283,0.8301887,0)
		_smoothness("smoothness", Range( 0 , 1)) = 0
		_metallic("metallic", Range( 0 , 1)) = 0
		_speedbrutality1("speed brutality", Range( 10 , 50)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			half filler;
		};

		uniform float4 _Color0;
		uniform float4 _ColorBlink;
		uniform float _Level;
		uniform float _speedbrutality1;
		uniform float _metallic;
		uniform float _smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float ifLocalVar26 = 0;
			if( _Level <= 0.2 )
				ifLocalVar26 = 0.7;
			else
				ifLocalVar26 = 0.4;
			float ifLocalVar22 = 0;
			if( _Level >= 0.4 )
				ifLocalVar22 = 0.4;
			else
				ifLocalVar22 = ifLocalVar26;
			float ifLocalVar18 = 0;
			if( _Level >= 0.7 )
				ifLocalVar18 = 0.0;
			else
				ifLocalVar18 = ifLocalVar22;
			float mulTime9 = _Time.y * ( ifLocalVar18 * _speedbrutality1 );
			float4 lerpResult39 = lerp( _Color0 , _ColorBlink , abs( sin( mulTime9 ) ));
			o.Albedo = lerpResult39.rgb;
			o.Metallic = _metallic;
			o.Smoothness = _smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
72.8;104;1290.4;644.6;2688.499;249.1221;2.079917;True;False
Node;AmplifyShaderEditor.RangedFloatNode;21;-2223.053,688.5944;Inherit;False;Constant;_level3;level 3;4;0;Create;True;0;0;0;False;0;False;0.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2219.605,770.8709;Inherit;False;Constant;_fast;fast;4;0;Create;True;0;0;0;False;0;False;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-2603.779,-20.12031;Inherit;False;Property;_Level;Level;0;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2039.605,518.8709;Inherit;False;Constant;_mid;mid;4;0;Create;True;0;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;26;-1920.605,668.8709;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-2039.651,444.0948;Inherit;False;Constant;_level2;level 2;4;0;Create;True;0;0;0;False;0;False;0.4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-1947.67,148.8137;Inherit;False;Constant;_level1;level 1;4;0;Create;True;0;0;0;False;0;False;0.7;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1957.605,234.8709;Inherit;False;Constant;_slow;slow;4;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;22;-1790.605,427.8709;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ConditionalIfNode;18;-1711.149,112.1947;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;42;-1623.422,621.486;Inherit;False;Property;_speedbrutality1;speed brutality;5;0;Create;True;0;0;0;False;0;False;0;36.04073;10;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1517.047,363.2019;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;50;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-1384.047,441.2019;Inherit;False;1;0;FLOAT;6.83;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-1226.047,442.2019;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;35;-714.8389,124.6459;Inherit;False;Property;_Color0;Color 0;1;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;38;-713.5276,293.2893;Inherit;False;Property;_ColorBlink;ColorBlink;2;0;Create;True;0;0;0;False;0;False;0.05795654,0.06394283,0.8301887,0;1,0.5707547,0.5707547,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.AbsOpNode;12;-1098.536,438.8853;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;39.91952,287.5683;Inherit;False;Property;_metallic;metallic;4;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;39;-275.3978,284.8893;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;40;35.60282,373.9019;Inherit;False;Property;_smoothness;smoothness;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;372.3224,101.1241;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SUNDAY/Timer;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;2;0
WireConnection;26;1;21;0
WireConnection;26;2;24;0
WireConnection;26;3;25;0
WireConnection;26;4;25;0
WireConnection;22;0;2;0
WireConnection;22;1;20;0
WireConnection;22;2;24;0
WireConnection;22;3;24;0
WireConnection;22;4;26;0
WireConnection;18;0;2;0
WireConnection;18;1;19;0
WireConnection;18;2;23;0
WireConnection;18;3;23;0
WireConnection;18;4;22;0
WireConnection;15;0;18;0
WireConnection;15;1;42;0
WireConnection;9;0;15;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;39;0;35;0
WireConnection;39;1;38;0
WireConnection;39;2;12;0
WireConnection;0;0;39;0
WireConnection;0;3;41;0
WireConnection;0;4;40;0
ASEEND*/
//CHKSM=AF65B4F3B949D8EB5E0697884BEACBF760042C07