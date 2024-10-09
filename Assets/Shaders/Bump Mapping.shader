Shader "Custom/Bump Mapping"
{
    //Code used from Lecture 4, lighting and Shading. Page 74
    Properties
    {
        _myDiffuse("Diffuse Texture", 2D) = "white"{}//sets default colour to white
        _myBump("Bump Texture", 2D) = "bump" {}//gets a bump from a texture
        _mySlider("Bump Amount", Range(0,10)) = 1//lets me choose how much bump there is
    }
    SubShader
    {
        CGPROGRAM

        #pragma surface surf Lambert//lambert lighting
        sampler2D _myDiffuse;//instantiating the variables
        sampler2D _myBump;
        half _mySlider;
        struct Input//the inputs
        {
            float2 uv_myDiffuse;
            float2 uv_myBump;
        };
        
        
        void surf (Input IN, inout SurfaceOutput o)//the outputs
        {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;//diffuse lighting on the bumps
            o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));//unpacked normal for the bump lighting
            o.Normal *= float3 (_mySlider, _mySlider, 1);//slider bumps
        }
        ENDCG
    }
    FallBack "Diffuse"
}
