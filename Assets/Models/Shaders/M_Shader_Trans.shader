Shader "Custom/M_Shader_Trans"
{
	Properties
	{
		_Color("Main Color", Color) = (1, 1, 1, 1)
		_MainTex("MainTex", 2D) = "white" {}

		_ShadowColor1("Shadow1_Color", Color) = (1, 1, 1, 0)
		_BaseColor_Step ("Shadow1_Step", Range(0, 1)) = 0.5
		_BaseShade_Feather ("Shadow1_Feather", Range(0.0001, 1)) = 0.2

		_ShadowColor2("Shadow2_Color", Color) = (1, 1, 1, 0)
		_ShadeColor_Step ("Shadow2_Step", Range(0, 1)) = 0.3
		_1st2nd_Shades_Feather ("Shadow2_Feather", Range(0.0001, 1)) = 0.2

		[MaterialToggle] _MixShadow ("MixShadow", Float ) = 0

		[Enum(Add,0,Dodge,1)] _SphereCalculation("SphereAddition", int ) = 0
		_SphereSampler("Sphere Control", 2D) = "black" {}
	}

	SubShader
	{
		Blend SrcAlpha OneMinusSrcAlpha, One One 
		Tags
		{
			"Queue" = "AlphaTest"
			"IgnoreProjector"="True"
			"RenderType" = "Overlay"
			"LightMode" = "ForwardBase"
		}

		LOD 250

		Pass
		{
			Cull Back
			ZTest LEqual
			CGPROGRAM
			#pragma multi_compile_fwdbase
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "AutoLight.cginc"

			#define ENABLE_CAST_SHADOWS
			#define ENABLE_RIMLIGHT
			#define ENABLE_SPHERE

			#include "M_Skin.cg"
			ENDCG
		}
	}
	FallBack "Diffuse"
}