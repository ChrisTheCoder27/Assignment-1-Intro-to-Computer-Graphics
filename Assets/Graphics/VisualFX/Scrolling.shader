Shader "VisualFX/Scrolling"
{
    Properties
    {
        _MainTex ("Texture 1", 2D) = "white" {}
        _ScrollTex ("Texture 2", 2D) = "white" {}
        _ScrollX ("Scroll X", Range(-5,5)) = 1
        _ScrollY ("Scroll Y", Range(-5,5)) = 0
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _ScrollTex;
        float _ScrollX;
        float _ScrollY;

        struct Input
        {
            float2 uv_MainTex;
            float3 vertColor;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            _ScrollX *= _Time;
            _ScrollY *= _Time;
            float3 tex1 = (tex2D(_MainTex, IN.uv_MainTex + float2(_ScrollX, _ScrollY))).rgb;
            float3 tex2 = (tex2D(_ScrollTex, IN.uv_MainTex + float2(_ScrollX/2.0, _ScrollY/2.0))).rgb;
            o.Albedo = (tex1 + tex2)/2.0;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
