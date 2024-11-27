Shader "Custom/Decal"
{
    Properties
    {
        _DecalTexture ("Decal Texture", 2D) = "white" {}
        _DecalColor ("Decal Color", Color) = (1,1,1,1)
        _Opacity ("Opacity", Range(0,1)) = 1.0
    }
    SubShader
    {
        Tags { "Queue" = "Transparent" "RenderType" = "Transparent" }
        Pass
        {
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            Cull Back
            Lighting Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _DecalTexture;
            fixed4 _DecalColor;
            float _Opacity;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord.xy;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 decal = tex2D(_DecalTexture, i.uv) * _DecalColor;
                decal.a *= _Opacity; // Adjust transparency based on _Opacity
                return decal;
            }
            ENDCG
        }
    }
}
