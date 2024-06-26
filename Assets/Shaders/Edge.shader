Shader "Unlit/NewUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _EdgeDarkenAmount ("Edge Darken Amount", Range(0, 1)) = 0.5
        _SepiaAmount ("Sepia Amount", Range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _EdgeDarkenAmount;
            float _SepiaAmount;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half4 color = tex2D(_MainTex, i.uv);

                // Darken edges
                float edgeFactor = 1.0 - smoothstep(0.0, _EdgeDarkenAmount, length(i.uv - 0.5));
                color.rgb *= edgeFactor;
                color.rgb = lerp(color.rgb, float3(0.393, 0.349, 0.272) + (color.rgb - 0.5) * 2.0, _SepiaAmount);
                return color;
            }
            ENDCG
        }
    }
}
