Shader "Custom/WaterWebGL_TilingFixed"
{
    Properties
    {
        _MainTex ("Main Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Color ("Color Tint", Color) = (0.4, 0.7, 1.0, 0.5)
        _WaveSpeed ("Wave Speed", Vector) = (0.1, 0.1, 0, 0)
    }

    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        LOD 200

        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            Cull Off
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            sampler2D _NormalMap;
            float4 _MainTex_ST;
            float4 _NormalMap_ST;
            float4 _Color;
            float4 _WaveSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uvMain : TEXCOORD0;
                float2 uvNormal : TEXCOORD1;
                float4 vertex : SV_POSITION;
                float3 worldPos : TEXCOORD2;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                // 머터리얼 설정에서의 타일링/오프셋을 반영
                o.uvMain = TRANSFORM_TEX(v.uv, _MainTex);
                o.uvNormal = TRANSFORM_TEX(v.uv, _NormalMap) + _Time.y * _WaveSpeed.xy;

                o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 tex = tex2D(_MainTex, i.uvMain);
                fixed3 normal = UnpackNormal(tex2D(_NormalMap, i.uvNormal));

                fixed3 lightDir = normalize(float3(0.3, 0.6, 1.0));
                fixed3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

                float lighting = saturate(dot(normal, lightDir));
                float fresnel = pow(1.0 - saturate(dot(viewDir, normal)), 3.0);
                float spec = pow(saturate(dot(reflect(-lightDir, normal), viewDir)), 32.0);

                fixed4 col = tex * _Color;
                col.rgb *= lighting;
                col.rgb += fresnel * 0.3;
                col.rgb += spec * 0.2;
                col.a = _Color.a;

                return col;
            }
            ENDCG
        }
    }

    FallBack Off
}
