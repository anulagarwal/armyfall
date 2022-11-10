// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "sndy/GlossyEmissiveColor"
{
	Properties
	{
		_metallic("metallic", Range( 0 , 4)) = 0
		_smoothness("smoothness", Range( 0 , 1)) = 0
		_color("color", Color) = (0.3644536,0.8490566,0.7650407,0)
		_glowColor("glowColor", Color) = (1,1,1,0)
		_glow("glow", Range( 0 , 2)) = 0
		_glowScale("glowScale", Range( 0 , 3)) = 0
		_glowPower("glowPower", Range( 0 , 8)) = 0
		_glowBias("glowBias", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Standard keepalpha 
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
		};

		uniform float4 _color;
		uniform float4 _glowColor;
		uniform float _glowBias;
		uniform float _glowScale;
		uniform float _glowPower;
		uniform float _glow;
		uniform float _metallic;
		uniform float _smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = i.worldNormal;
			float fresnelNdotV2 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode2 = ( _glowBias + _glowScale * pow( 1.0 - fresnelNdotV2, _glowPower ) );
			float4 temp_output_10_0 = ( _color + ( _glowColor * fresnelNode2 * _glow ) );
			float4 temp_cast_0 = (0.1).xxxx;
			float4 temp_cast_1 = (1.0).xxxx;
			float4 clampResult36 = clamp( temp_output_10_0 , temp_cast_0 , temp_cast_1 );
			o.Emission = clampResult36.rgb;
			o.Metallic = saturate( _metallic );
			o.Smoothness = saturate( _smoothness );
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
90.4;84.8;1290.4;644.6;658.3488;441.4458;2.046376;True;False
Node;AmplifyShaderEditor.RangedFloatNode;12;-835.5,303;Inherit;False;Property;_glowScale;glowScale;5;0;Create;True;0;0;0;False;0;False;0;1.33;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-848.5,393;Inherit;False;Property;_glowPower;glowPower;6;0;Create;True;0;0;0;False;0;False;0;1.95;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-841.5,222;Inherit;False;Property;_glowBias;glowBias;7;0;Create;True;0;0;0;False;0;False;0;0.126;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;2;-535.5,260;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;3;-499.5,54;Inherit;False;Property;_glowColor;glowColor;3;0;Create;True;0;0;0;False;0;False;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-454.5,512;Inherit;False;Property;_glow;glow;4;0;Create;True;0;0;0;False;0;False;0;0.362;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-163.5,150;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1;-496.5,-116;Inherit;False;Property;_color;color;2;0;Create;True;0;0;0;False;0;False;0.3644536,0.8490566,0.7650407,0;1,0.4720202,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;38;72.44067,-251.3526;Inherit;False;Constant;_Float1;Float 0;8;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;52.5,246;Inherit;True;Property;_smoothness;smoothness;1;0;Create;True;0;0;0;False;0;False;0;0.81;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;67.49582,95.14841;Inherit;False;Property;_metallic;metallic;0;0;Create;True;0;0;0;False;0;False;0;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;10;6.208933,-110.6103;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;37;76.44067,-332.3526;Inherit;False;Constant;_Float0;Float 0;8;0;Create;True;0;0;0;False;0;False;0.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;36;309.4407,-324.3526;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;34;405.9898,-10.71835;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;35;488.9493,175.3127;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;32;206.1185,-173.8835;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1393.149,-186.9753;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;sndy/GlossyEmissiveColor;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;9.4;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;1;11;0
WireConnection;2;2;12;0
WireConnection;2;3;13;0
WireConnection;4;0;3;0
WireConnection;4;1;2;0
WireConnection;4;2;5;0
WireConnection;10;0;1;0
WireConnection;10;1;4;0
WireConnection;36;0;10;0
WireConnection;36;1;37;0
WireConnection;36;2;38;0
WireConnection;34;0;8;0
WireConnection;35;0;7;0
WireConnection;32;0;10;0
WireConnection;0;2;36;0
WireConnection;0;3;34;0
WireConnection;0;4;35;0
ASEEND*/
//CHKSM=9BBCA718CDC1DE92864B693F886CF43159B51F5D