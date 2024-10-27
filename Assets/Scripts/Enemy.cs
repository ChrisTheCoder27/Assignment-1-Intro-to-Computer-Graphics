using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    [SerializeField] float XRotation;
    [SerializeField] GameObject loseScreen;

    void Awake()
    {
        loseScreen.SetActive(false);
    }

    void Update()
    {
        
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject.CompareTag("Player"))
        {
            loseScreen.SetActive(true);
            GameManager.gameOver = true;
        }
    }
}
