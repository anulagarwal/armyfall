using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GroundChecker : MonoBehaviour
{
    private void OnTriggerExit(Collider other)
    {
        if(other.gameObject.tag== "Ground")
        {
            GetComponentInParent<Character>().Fall();
            //Enable Ragdoll
        }
    }
}
