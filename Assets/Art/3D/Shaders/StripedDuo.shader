// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "StripedDuo"
{
	Properties
	{
		_Color1("Color 1", Color) = (1,0.7731253,0,0)
		_Color2("Color 2", Color) = (0.7924528,0.01868992,0.01868992,0)
		_Tiling("Tiling", Float) = 3.71
		_Thikness("Thikness", Range( 0 , 1)) = 0.5
		_DiagonalA("Diagonal A", Range( -1 , 1)) = 1
		_DiagonalB("Diagonal B", Range( -1 , 1)) = 1
		[Toggle(_ISSTEPPED_ON)] _isStepped("is Stepped", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma shader_feature _ISSTEPPED_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color2;
		uniform float4 _Color1;
		uniform float _Tiling;
		uniform float _DiagonalA;
		uniform float _DiagonalB;
		uniform float _Thikness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_Tiling).xx;
			float2 uv_TexCoord36 = i.uv_texcoord * temp_cast_0;
			float temp_output_33_0 = frac( ( ( uv_TexCoord36.x * _DiagonalA ) + ( _DiagonalB * uv_TexCoord36.y ) ) );
			#ifdef _ISSTEPPED_ON
				float staticSwitch21 = step( temp_output_33_0 , _Thikness );
			#else
				float staticSwitch21 = temp_output_33_0;
			#endif
			float4 lerpResult17 = lerp( _Color2 , _Color1 , staticSwitch21);
			o.Albedo = lerpResult17.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
1966;41;1872;971;1627.274;1233.51;1.865405;True;True
Node;AmplifyShaderEditor.CommentaryNode;51;-1310.117,-921.2386;Inherit;False;2184.957;973.9358;Comment;14;14;7;17;34;36;45;40;43;44;42;49;33;48;21;Rotatable Lines;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-1279.678,-684.4373;Inherit;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;3.71;3.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;36;-1072.995,-709.1724;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;-744.4874,-629.7881;Inherit;False;Property;_DiagonalB;Diagonal B;5;0;Create;True;0;0;False;0;1;1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-747.8299,-707.3268;Inherit;False;Property;_DiagonalA;Diagonal A;4;0;Create;True;0;0;False;0;1;-0.22;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-535.5782,-482.0002;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-588.2212,-871.2386;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;42;-385.6851,-769.2819;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;49;-417.3306,-243.2784;Inherit;True;Property;_Thikness;Thikness;3;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;33;-156.7801,-596.9866;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;48;60.73924,-201.3028;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;313.5573,-433.4545;Inherit;False;Property;_Color1;Color 1;0;0;Create;True;0;0;False;0;1,0.7731253,0,0;1,0.7731253,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;21;327.1537,-237.2519;Inherit;False;Property;_isStepped;is Stepped;6;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;314.1291,-631.3801;Inherit;False;Property;_Color2;Color 2;1;0;Create;True;0;0;False;0;0.7924528,0.01868992,0.01868992,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;50;-1139.464,217.7945;Inherit;False;1634.434;709.6412;SimpleHorizontal;8;4;3;27;25;24;26;1;2;Horizontal Lines;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-115.8799,668.4357;Inherit;True;Constant;_linewidth;linewidth;4;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;17;609.8399,-306.6984;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-912.926,780.1198;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;False;0;90;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;24;-468.3987,526.7979;Inherit;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;27;-1000.421,651.3102;Inherit;False;Constant;_Vector0;Vector 0;5;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.StepOpNode;3;259.9698,509.8279;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;2;-206.0567,338.1183;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-876.1957,267.7945;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;25;-728.9185,788.3587;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1304.552,-289.1603;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;StripedDuo;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;36;0;34;0
WireConnection;44;0;45;0
WireConnection;44;1;36;2
WireConnection;43;0;36;1
WireConnection;43;1;40;0
WireConnection;42;0;43;0
WireConnection;42;1;44;0
WireConnection;33;0;42;0
WireConnection;48;0;33;0
WireConnection;48;1;49;0
WireConnection;21;1;33;0
WireConnection;21;0;48;0
WireConnection;17;0;7;0
WireConnection;17;1;14;0
WireConnection;17;2;21;0
WireConnection;24;0;1;1
WireConnection;24;1;27;0
WireConnection;24;2;25;0
WireConnection;3;0;2;0
WireConnection;3;1;4;0
WireConnection;2;0;1;2
WireConnection;25;0;26;0
WireConnection;0;0;17;0
ASEEND*/
//CHKSM=0E5E26040ABE96BA96CB182D0289E97C2A150B4B