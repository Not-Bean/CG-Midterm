Shader "Custom/Toon Shader"
{
    
    //Code used from in class lecture "Visual effects" Page 47/48
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)//get a default colour
        _RampTex("Ramp Texture", 2D) = "white" {}//get a texture for the toon shader to pick colours from
    }
    SubShader
    {
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf ToonRamp//tell unity the surface will be a toonramp

        float4 _Color;//instantiate the variables
        sampler2D _RampTex;
        
        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed atten){
            float diff = dot (s.Normal, lightDir);//dot product for diffuse lighting
            float h = diff * 0.5 + 0.5;//get the diffuse lighting to equal 1 or 0
            float2 rh = h;
            float3 ramp = tex2D(_RampTex, rh).rgb;//get ramp texture

            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (ramp);
            c.a = s.Alpha;
            return c;
        }
        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = _Color.rgb;
        }
        
        
        ENDCG
    }
    FallBack "Diffuse"
}
