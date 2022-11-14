using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CharacterCollisionHandler : MonoBehaviour
{
    private void OnCollisionEnter(Collision collision)
    {
        if (collision.gameObject.tag == "Wall")
        {
            GetComponent<Character>().UpdateState(CharacterState.Push);
        }

        if (collision.gameObject.tag == "Character")
        {
            if(collision.gameObject.GetComponent<Character>().GetState() == CharacterState.Push)
            {
                print("char");

                GetComponent<Character>().UpdateState(CharacterState.Push);

            }
        }
    }
}
