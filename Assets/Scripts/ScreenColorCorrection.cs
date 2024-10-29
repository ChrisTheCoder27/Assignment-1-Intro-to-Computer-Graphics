using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenColorCorrection : MonoBehaviour
{
    public Material m_renderMaterial;
    public Material m_renderMaterial2;
    public Material m_renderMaterial3;

    bool colorGrading1Active = false;
    bool colorGrading2Active = false;
    bool colorGrading3Active = false;

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (colorGrading1Active)
        {
            Graphics.Blit(source, destination, m_renderMaterial);
        }
        else if (colorGrading2Active)
        {
            Graphics.Blit(source, destination, m_renderMaterial2);
        }
        else if (colorGrading3Active)
        {
            Graphics.Blit(source, destination, m_renderMaterial3);
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
            colorGrading1Active = false;
            colorGrading2Active = false;
            colorGrading3Active = false;
        }
        else if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            colorGrading1Active = true;
            colorGrading2Active = false;
            colorGrading3Active = false;
        }
        else if (Input.GetKeyDown(KeyCode.Alpha3))
        {
            colorGrading1Active = false;
            colorGrading2Active = true;
            colorGrading3Active = false;
        }
        else if (Input.GetKeyDown(KeyCode.Alpha4))
        {
            colorGrading1Active = false;
            colorGrading2Active = false;
            colorGrading3Active = true;
        }
    }
}
