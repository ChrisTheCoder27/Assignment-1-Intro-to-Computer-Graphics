Shader "Custom/NormalMapping"
{
    Properties {
        _myDiffuse ("Diffuse Texture", 2D) = "white" {} //Main texture for diffuse color
        _myBump ("Bump Texture", 2D) = "bump" {}       //Texture for normal/bump mapping
        _mySlider ("Bump Amount", Range(0,10)) = 1     //Slider to control the intensity of the bump effect
        [Toggle] _ShowTexture ("Texture Shown", Float) = 0    //Toggle texture on or off
    }

    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert

        // Shader properties
        sampler2D _myDiffuse;  //Diffuse texture
        sampler2D _myBump;     //Bump (normal) texture
        half _mySlider;        //Slider to control intensity
        float _ShowTexture;

        struct Input 
        {
            float2 uv_myDiffuse;  //UV coordinates for diffuse texture
            float2 uv_myBump;     //UV coordinates for bump texture
        };

        // Surface shader function to set up lighting and normal mapping
        void surf (Input IN, inout SurfaceOutput o) {
            // Sample the diffuse texture color and assign it to the object's color (Albedo) if toggled on
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb * _ShowTexture;

            // Sample the bump map and unpack it to retrieve the normal information
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
            
            // Adjust the intensity of the normal mapping
            o.Normal *= float3(_mySlider, _mySlider, 1);
        }
        ENDCG    
    }    

    FallBack "Diffuse"
}
