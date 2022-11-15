using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wall : MonoBehaviour
{
   void Start()
    {

    }

    private void OnCollisionEnter(Collision collision)
    {
        print(collision.gameObject.tag);
        if (collision.gameObject.tag == "Objective")
        {
            GameManager.Instance.WinLevel();
        }

        else if (collision.gameObject.tag == "PlayerBase")
        {
            GameManager.Instance.LoseLevel();
        }
    }
}
