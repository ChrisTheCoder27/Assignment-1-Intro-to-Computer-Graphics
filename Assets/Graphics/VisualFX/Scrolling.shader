Shader "VisualFX/Scrolling"
{
    Properties
    {
        _MainTex ("Texture 1", 2D) = "white" {}
        _ScrollTex ("Texture 2", 2D) = "white" {}
        _ScrollX ("Scroll X", Range(-5,15)) = 1
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _ScrollTex;
        float _ScrollX;

        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            float3 tex1 = (tex2D(_MainTex, IN.uv_MainTex + float2(0, 0))).rgb;
            float3 tex2 = (tex2D(_ScrollTex, IN.uv_MainTex + float2(_ScrollX/2.0, 0))).rgb;
            o.Albedo = (tex1 + tex2)/2.0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
