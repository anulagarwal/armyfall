using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundChecker : MonoBehaviour
{
    private void OnTriggerExit(Collider other)
    {
        if(other.gameObject.tag== "Ground")
        {
            //GetComponentInParent<Character>().Fall();
            //Enable Ragdoll
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        if(other.gameObject.tag == "Air")
        {
            GetComponentInParent<Character>().Fall();
        }
        if (GetComponentInParent<Wall>() != null)
        {
            if (other.gameObject.tag == "Objective")
            {
                GameManager.Instance.WinLevel();
            }

            else if (other.gameObject.tag == "PlayerBase")
            {
                GameManager.Instance.LoseLevel();
            }
        }
    }
}
