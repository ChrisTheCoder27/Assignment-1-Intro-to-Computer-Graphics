using Cinemachine;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    public static bool gameOver;

    [SerializeField] CinemachineVirtualCamera vCamera;

    void Awake()
    {
        gameOver = false;
        Time.timeScale = 1.0f;
        UnlockCamera();
    }

    void Update()
    {
        if (gameOver)
        {
            Time.timeScale = 0f;
            LockCamera();
        }
    }

    void LockCamera()
    {
        vCamera.enabled = false;
    }

    void UnlockCamera()
    {
        vCamera.enabled = true;
    }

    public void Retry()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
    }
}
