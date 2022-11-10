// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SUNDAY/Obstacle"
{
	Properties
	{
		[Toggle]_impact("impact", Float) = 0
		_Color("Color", Color) = (1,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _impact;
		uniform float4 _Color;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 temp_cast_0 = 0;
			float3 ase_worldNormal = UnityObjectToWorldNormal( v.normal );
			float mulTime9 = _Time.y * 30.0;
			float temp_output_20_0 = step( abs( sin( mulTime9 ) ) , 0.5 );
			v.vertex.xyz += (( _impact )?( ( ase_worldNormal * (0.0 + (temp_output_20_0 - 0.0) * (0.2 - 0.0) / (1.0 - 0.0)) ) ):( temp_cast_0 ));
			v.vertex.w = 1;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime9 = _Time.y * 30.0;
			float temp_output_20_0 = step( abs( sin( mulTime9 ) ) , 0.5 );
			o.Emission = (( _impact )?( ( temp_output_20_0 + _Color ) ):( _Color )).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18800
72.8;104;1290.4;644.6;1495.853;538.3547;1.630461;True;False
Node;AmplifyShaderEditor.RangedFloatNode;10;-1158.102,-202.8253;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;0;False;0;False;30;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;9;-1024.102,-204.8253;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-836.1019,-222.8253;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;12;-741.1019,-281.8253;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;20;-607.8445,-310.3697;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;22;-400.2538,318.1742;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.2;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;6;-395.3731,171.464;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;1;-700.4139,65.45547;Inherit;False;Property;_Color;Color;1;0;Create;True;0;0;0;False;0;False;1,0,0,0;1,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;16;-159.7,169.5;Inherit;False;Constant;_Int0;Int 0;1;0;Create;True;0;0;0;False;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-334.4365,-331.4292;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-160.7,275.5;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;17;91.94473,78.45801;Inherit;False;Property;_impact;impact;0;0;Create;False;0;0;0;False;0;False;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;14;88.30005,226.5;Inherit;False;Property;_impact;impact;0;0;Create;True;0;0;0;False;0;False;0;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;348,-43;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;SUNDAY/Obstacle;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;10;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;20;0;12;0
WireConnection;22;0;20;0
WireConnection;13;0;20;0
WireConnection;13;1;1;0
WireConnection;4;0;6;0
WireConnection;4;1;22;0
WireConnection;17;0;1;0
WireConnection;17;1;13;0
WireConnection;14;0;16;0
WireConnection;14;1;4;0
WireConnection;0;2;17;0
WireConnection;0;11;14;0
ASEEND*/
//CHKSM=7EBE1609C9042C79F2A68FF21DBF951C3CFBFC74