Shader "Custom/M_Shader"
{
	Properties
	{
		_Color("Main Color", Color) = (1, 1, 1, 1)
		_MainTex("MainTex", 2D) = "white" {}

		_EdgeThickness("Outline Thickness", Float) = 0.0

		[Enum(OFF,0,FRONT,1,BACK,2)] _CullMode("Cull Mode", int) = 2

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
		Tags
		{
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
			"LightMode" = "ForwardBase"
		}

		LOD 450

		Pass
		{
			Cull[_CullMode]
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

		Pass
		{
			Cull Front
			ZTest Less
			CGPROGRAM
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "M_Outline.cg"
			ENDCG
		}
	}
	FallBack "Diffuse"
}