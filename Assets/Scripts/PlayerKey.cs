using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerKey : MonoBehaviour
{
    bool hasKey;

    void Awake()
    {
        hasKey = false;
    }

    void OnTriggerEnter(Collider other)
    {
        // If the player runs into a key, it will track that they have a key
        if (other.gameObject.CompareTag("Key"))
        {
            hasKey = true;
        }
    }

    void OnCollisionEnter(Collision collision)
    {
        // If the player runs into a door, it will only open if they have a key
        if (collision.gameObject.CompareTag("Door"))
        {
            if (hasKey)
            {
                Destroy(collision.gameObject);
                hasKey = false;
            }
        }
    }
}
