// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Checkerboard"
{
	Properties
	{
		_MainColor("Main Color", Color) = (1,0.7731253,0,0)
		_ScondaryColor("Scondary Color", Color) = (0.7924528,0.01868992,0.01868992,0)
		_ScaleX("Scale X", Float) = 3
		_ScaleY("Scale Y", Float) = 3
		_Balance("Balance", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			float2 uv_texcoord;
		};

		uniform float4 _MainColor;
		uniform float4 _ScondaryColor;
		uniform float _ScaleX;
		uniform float _Balance;
		uniform float _ScaleY;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 temp_cast_0 = (_ScaleX).xx;
			float2 uv_TexCoord28 = i.uv_texcoord * temp_cast_0;
			float temp_output_41_0 = step( frac( uv_TexCoord28.x ) , _Balance );
			float2 temp_cast_1 = (_ScaleY).xx;
			float2 uv_TexCoord89 = i.uv_texcoord * temp_cast_1;
			float temp_output_43_0 = step( _Balance , frac( uv_TexCoord89.y ) );
			float4 lerpResult40 = lerp( _MainColor , _ScondaryColor , ( ( 1.0 - ( temp_output_41_0 - temp_output_43_0 ) ) * ( 1.0 - ( ( 1.0 - temp_output_41_0 ) - ( 1.0 - temp_output_43_0 ) ) ) ));
			float4 Checkerboard77 = lerpResult40;
			o.Albedo = Checkerboard77.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
1920;55;1872;966;6242.375;1659.893;4.455506;True;True
Node;AmplifyShaderEditor.CommentaryNode;26;-3763.524,452.4164;Inherit;False;2894.077;1821.588;Comment;19;35;43;49;37;41;32;28;27;40;39;38;63;66;67;68;75;76;88;89;Checkerboard;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-3652.286,763.5551;Inherit;False;Property;_ScaleX;Scale X;2;0;Create;True;0;0;False;0;3;3.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;88;-3700.896,1211.578;Inherit;False;Property;_ScaleY;Scale Y;3;0;Create;True;0;0;False;0;3;3.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-3445.603,738.8199;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;89;-3469.405,1188.302;Inherit;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;35;-3127.573,1228.868;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-2961.138,891.0812;Inherit;True;Property;_Balance;Balance;4;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;32;-3134.594,581.0352;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;43;-2582.118,1202.302;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;41;-2619.071,560.7987;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;66;-2232.162,1251.277;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;67;-2241.053,1570.952;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;49;-2220.849,628.8887;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;63;-1965.278,1567.815;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;75;-1767.6,764.7006;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;68;-1650.564,1415.108;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;39;-1421.295,837.4118;Inherit;False;Property;_ScondaryColor;Scondary Color;1;0;Create;True;0;0;False;0;0.7924528,0.01868992,0.01868992,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-1422.314,1137.706;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;38;-1429.164,626.7242;Inherit;False;Property;_MainColor;Main Color;0;0;Create;True;0;0;False;0;1,0.7731253,0,0;1,0.7731253,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;40;-1128.504,877.5236;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;77;-574.3692,893.968;Inherit;False;Checkerboard;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;78;-348.6459,9.00655;Inherit;False;77;Checkerboard;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Checkerboard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;27;0
WireConnection;89;0;88;0
WireConnection;35;0;89;2
WireConnection;32;0;28;1
WireConnection;43;0;37;0
WireConnection;43;1;35;0
WireConnection;41;0;32;0
WireConnection;41;1;37;0
WireConnection;66;0;41;0
WireConnection;67;0;43;0
WireConnection;49;0;41;0
WireConnection;49;1;43;0
WireConnection;63;0;66;0
WireConnection;63;1;67;0
WireConnection;75;0;49;0
WireConnection;68;0;63;0
WireConnection;76;0;75;0
WireConnection;76;1;68;0
WireConnection;40;0;38;0
WireConnection;40;1;39;0
WireConnection;40;2;76;0
WireConnection;77;0;40;0
WireConnection;0;0;78;0
ASEEND*/
//CHKSM=8C3FCCA00C28E5ACBAF74A872A59A76D9BAF00ED