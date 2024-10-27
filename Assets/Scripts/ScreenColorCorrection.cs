using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenColorCorrection : MonoBehaviour
{
    public Material m_renderMaterial;

    bool colorGradingActive = false;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (colorGradingActive)
        {
            Graphics.Blit(source, destination, m_renderMaterial);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            Debug.Log("Turn LUT off");
            colorGradingActive = false;
        }
        else if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            Debug.Log("Turn LUT on");
            colorGradingActive = true;
        }
    }
}
