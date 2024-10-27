using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameManager : MonoBehaviour
{
    public static bool gameOver;

    void Awake()
    {
        gameOver = false;
        Time.timeScale = 1.0f;
    }

    void Update()
    {
        if (gameOver)
        {
            Time.timeScale = 0f;
        }
    }
}
