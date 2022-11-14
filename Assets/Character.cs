using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Character : MonoBehaviour
{
    [Header("Attributes")]
    [SerializeField] float speed;
    [SerializeField] CharacterState state = CharacterState.Run;
    [SerializeField] CharacterType type = CharacterType.Player;
    [SerializeField] bool canMove;

    [Header("Component References")]
    [SerializeField] Animator animator;
    [SerializeField] Transform ground;
    [SerializeField] public LayerMask IgnoreMe;


    // Start is called before the first frame update
    void Start()
    {
        UpdateState(state);
    }

    // Update is called once per frame
    void Update()
    {
        if (canMove)
        {
            //transform.Translate(Vector3.forward * speed * Time.deltaTime);
            if (type == CharacterType.Player)
            {
                GetComponent<Rigidbody>().AddForce(Vector3.forward * speed * Time.deltaTime, ForceMode.Force);
            }
            else
            {
                GetComponent<Rigidbody>().AddForce(-Vector3.forward * speed * Time.deltaTime, ForceMode.Force);
            }
        }
          
       
    }

    public void Fall()
    {
        canMove = false;
        //Enable Ragdoll
    }

    public void UpgradeStrength(int val)
    {
        speed += val;
    }

    public CharacterState GetState()
    {
        return state;
    }

    public void UpdateState(CharacterState st)
    {
        state = st;
        switch (st)
        {
            case CharacterState.Run:
                animator.Play("Run");
                break;

            case CharacterState.Push:
                animator.Play("Push");

                break;

            case CharacterState.Fall:
                animator.Play("Fall");

                break;

            case CharacterState.Celebrate:
                animator.Play("Celebrate");

                break;
        }
    }

}
