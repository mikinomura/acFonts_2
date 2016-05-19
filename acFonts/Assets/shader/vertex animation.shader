Shader "Anclin/Experiments/Vertex Animation"
{
	Properties
	{
		_Value1( "Value 1", Float ) = 0
		_Value2( "Value 2", Float ) = 0
		_Value3( "Value 3", Float ) = 0
		_Value4( "Value 4", Float) = 0
		_ColorX ("Color X", COLOR) = (1,1,1,1)
      	_ColorY ("Color Y", COLOR) = (1,1,1,1)
      	_GradientStrength ("Graident Strength", Float) = 1
      	_yPosLow ("Y Pos Low", Float) = 0
      	_yPosHigh ("Y Pos High", Float) = 10
      	_ColorLow ("Color Low", COLOR) = (1,1,1,1)
      	_ColorHigh ("Color High", COLOR) = (1,1,1,1)
		_Rotation("Rotation", Float) = 0
		_MainTex("Base texture", 2D) = "white" {}//テクスチャ
		_Tess ("Tessellation", Range(1,32)) = 4
	}

	SubShader
	{
		Pass
		{
			Tags {"Queue" = "Geometry" "RenderType" = "Transparent" 
				"LightMode" = "ForwardBase"} // for shadows
			//透明にするために必要↓
			Blend SrcAlpha OneMinusSrcAlpha

			// Render faces when looking from the inside
			Cull Off

			CGPROGRAM

			// Pragmas
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase

			#include "UnityCG.cginc"

			#include "AutoLight.cginc"

			#include "Lighting.cginc"

			// User defined variables
			uniform fixed4 _Color;
			uniform float _Value1;
			uniform float _Value2;
			uniform float _Value3;
			uniform float _Value4;
			fixed4 _ColorLow;
      		fixed4 _ColorHigh;
      		fixed4 _ColorX;
      		fixed4 _ColorY;
      		half _yPosLow;
      		half _yPosHigh;
      		half _GradientStrength;
      		half _EmissiveStrengh;
			uniform float _Rotation;
			uniform sampler2D _MainTex;

			#define RIGHT float3(1,0,0)
			#define UP float3(0,1,0)
			#define LEFT float3(0,0,1)
			#define WHITE3 fixed3(1,1,1)

			float _Tess;

			float4 tessFixed()
            {
                return _Tess;
            }

			// Base input structs
			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0; //1つ目のUV座標セマンティクス
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 color : COLOR;
				float2 uv : TEXCOORD0;

				LIGHTING_COORDS(0,1)
			};

			float4 _MainTex_ST;//?

			float rand(float3 co) {
				return frac(sin(dot(co.xy, float2(12.9898, 78.233))) * 43758.5453);
			}


			// Vertex function
			v2f vert( vertexInput i )
			{
				v2f o;

				// VERTEX ANIMATION ///////////////////////////////////////////////////////////////

				// Fat mesh
				//i.vertex.xyz += i.normal * _Value1;
				
				// Waving mesh
				//i.vertex.x += sin( ( i.vertex.y + _Time * _Value3 ) * _Value2 ) * _Value1;

				// Bubbling mesh
				//i.vertex.xyz += i.normal * ( sin( (i.vertex.x + _Time * _Value3) * _Value2 ) + cos( (i.vertex.z + _Time * _Value3) * _Value2 )  ) * _Value1;
				i.vertex.xyz += i.normal * (sin((i.vertex.x + i.vertex.y + _Time * _Time) * _Value2) + cos(i.vertex.y + i.vertex.z + _Time)) * _Value3 * 0.01;
				i.vertex.xyz += i.vertex.xyz * (sin((i.vertex.x + i.vertex.y + _Time) * _Value2) + cos(i.vertex.y + i.vertex.z + _Time)) * _Value1;
				i.vertex.xyz += rand(i.vertex.xyz) * _Value4;
				//i.vertex.xyz = pos + i.normal * ( sin( (i.vertex.x + _Time * _Value3) * _Value2 )) * _Value1;



				//////////////////////////////////////////////////////////// EO VERTEX ANIMATION //

				// COLOR
				o.uv = TRANSFORM_TEX (i.texcoord, _MainTex);

				// gradient color at this height
         		half3 gradient = lerp(_ColorLow, _ColorHigh,  smoothstep( _yPosLow, _yPosHigh, i.texcoord.y )).rgb;

         		// lerp the 
         		gradient = lerp(WHITE3, gradient, _GradientStrength);

				//// add ColorX if the normal is facing positive X-ish
				half3 finalColor = _ColorX.rgb * max(0,dot(i.normal, RIGHT))* _ColorX.a;

				// add ColorY if the normal is facing positive Y-ish (up)
        		finalColor += _ColorY.rgb * max(0,dot(i.normal, UP)) * _ColorY.a;

        		// add ColorY if the normal is facing positive Y-ish (up)
        		finalColor += _ColorY.rgb * max(0,dot(i.normal, LEFT)) * _ColorY.a;

        		// add ColorY if the normal is facing positive Y-ish (up)
        		finalColor += _ColorY.rgb * max(0,dot(i.normal, LEFT+RIGHT)) * _ColorY.a;

        		finalColor += (_ColorX + _ColorY) / 2;;

				// scale down to 0-1 values
         		finalColor = saturate(finalColor);

         		o.color = float4(finalColor, 1);
	
				// This line must be after the vertex manipulation
				o.pos = mul( UNITY_MATRIX_MVP, i.vertex );

				//for light
				TRANSFER_VERTEX_TO_FRAGMENT(o);
				return o;
			}


			// Fragment function
			fixed4 frag( v2f i ) : COLOR
			{	
				float attenuation = LIGHT_ATTENUATION(i); //for light
				i.color.a = 1;
				fixed4 texcol = tex2D (_MainTex, i.uv);
				return texcol * i.color * attenuation;
				//return tex2D(_MainTex, i.uv);
			}



			ENDCG
		}
	}

	// Fallback commented out during development
	Fallback "Diffuse"
	//Fallback "VertexLit"
}
