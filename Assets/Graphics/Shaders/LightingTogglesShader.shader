Shader "Custom/LightingTogglesShader"
{
    Properties
    {
        _Color ("Color", Color) = (1.0,1.0,1.0,1.0)       
        _MainTex ("Texture", 2D) = "white" {}      
        _Shininess ("Shininess", Range(0,1)) = 0.5 
        _RimColor ("Rim Light Color", Color) = (1.0,1.0,1.0,1.0)  
        _RimPower ("Rim Power", Range(0.0,8.0)) = 1

        // Lighting Toggles
        [Toggle] _UseAmbient ("Use Ambient Lighting", Float) = 1      
        [Toggle] _UseRim ("Use Rim Lighting", Float) = 1              
        [Toggle] _UseSpecular ("Use Specular Lighting", Float) = 1    
    }

    SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        // Input struct for surface shader
        struct Input
        {
            float2 uv_MainTex;  
            float3 worldPos;    
            float3 viewDir;     
        };

        // Texture properties and colors
        sampler2D _MainTex;
        fixed4 _Color;
        half _Shininess;
        fixed4 _RimColor;  
        float _RimPower;   

        // Lighting toggle properties
        float _UseAmbient;
        float _UseRim;
        float _UseSpecular;

        // Surface shader function
        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;  // Base color for lighting

            o.Smoothness = _Shininess;

            // Lighting calculation for Ambient, Specular, and Rim lighting

            // Ambient lighting (if enabled)
            fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.rgb * c.rgb; //base color multiplied by global ambient light from unity

            // Rim lighting calculation (if enabled)
            half rimFactor = 1.0 - saturate(dot(normalize(o.Normal), normalize(IN.viewDir)));
            fixed3 rimLight = _RimColor.rgb * pow(rimFactor, _RimPower);

            // Specular lighting (if enabled)
            half3 normal = normalize(o.Normal);               //Surface normal direction
            half3 lightDir = normalize(_WorldSpaceLightPos0.xyz); //Direction to main light source
            half3 viewDir = normalize(_WorldSpaceCameraPos - IN.worldPos); //Direction to camera
            half3 halfDir = normalize(lightDir + viewDir);    //Halfway vector between light and view directions
            half NdotH = max(0, dot(normal, halfDir));        //Dot product of normal and halfway vector
            fixed specularStrength = pow(NdotH, 4.0 / _Shininess); 
            fixed3 specular = _LightColor0.rgb * specularStrength; //Final specular color

            // Initialize result color
            fixed3 resultColor = fixed3(0, 0, 0);

            // Apply lighting based on toggles
            if (_UseAmbient == 1)
            {
                resultColor += ambient;
            }
            if (_UseRim == 1)
            {
                resultColor += rimLight;
            }
            if (_UseSpecular == 1)
            {
                o.Emission = specular * _Shininess; //adding to emission for brightness
            }
            else
            {
                o.Emission = fixed3(0, 0, 0); //emission set to 0 if specular is disabled
            }

            o.Albedo = resultColor;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
