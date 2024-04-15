using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class Edge : MonoBehaviour
{
    public Material edgeDark;
    [Range(0, 1)]
    public float edgeLight  = 0.5f;
    
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (edgeDark != null)
        {
            edgeDark.SetFloat("_EdgeDarkenAmount", edgeLight);
            Graphics.Blit(source, destination, edgeDark);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
