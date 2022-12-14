using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using TMPro;
public class Character : MonoBehaviour
{
    [Header("Attributes")]
    [SerializeField] float speed;
    [SerializeField] CharacterState state = CharacterState.Run;
    [SerializeField] CharacterType type = CharacterType.Player;
    [SerializeField] bool canMove;
    [SerializeField] Vector3 swimDirection;
    [SerializeField] float swimSpeed;
    [SerializeField] int deathCoins;
    [SerializeField] TextMeshPro tm;



    [Header("Component References")]
    [SerializeField] Animator animator;
    [SerializeField] Transform ground;
    [SerializeField] public LayerMask IgnoreMe;
    [SerializeField] public ParticleSystem ps;



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
            if (state == CharacterState.Run)
            {
                if (type == CharacterType.Player)
                {
                    GetComponent<Rigidbody>().AddForce(Vector3.forward * 500 * Time.deltaTime, ForceMode.Force);
                }
                else
                {
                    GetComponent<Rigidbody>().AddForce(-Vector3.forward * 500 * Time.deltaTime, ForceMode.Force);
                }
            }
            else
            {
                if (type == CharacterType.Player)
                {
                    GetComponent<Rigidbody>().AddForce(Vector3.forward * 500 * Time.deltaTime, ForceMode.Force);
                }
                else
                {
                    GetComponent<Rigidbody>().AddForce(-Vector3.forward * 500 * Time.deltaTime, ForceMode.Force);
                }
            }
        }
        if(state== CharacterState.Swim)
        {
            //move right
            transform.Translate(swimDirection * speed * Time.deltaTime);
        }
          
       
    }
    private void OnDestroy()
    {
        if(type  == CharacterType.Player)
        CharacterManager.Instance.RemoveCharacter(this);

        else
        {
            EnemySpawner.Instance.RemoveEnemy(this);
        }
    }

    public void Fall()
    {
        if (state != CharacterState.Celebrate)
        {
            canMove = false;
            UpdateState(CharacterState.Fall);
        }
        //Enable Ragdoll
    }

    public void UpgradeStrength(int val)
    {
        speed += val;
        ps.Play();
    }
    public void UpdateStrength(int val)
    {
        speed = val;
    }

    public void UpdateDeathCoin(int val)
    {
        deathCoins = val;
       
    }
    public CharacterState GetState()
    {
        return state;
    }
    public float GetStrength()
    {
        return speed;
    }
    public void UpdateState(CharacterState st)
    {
        if (state != CharacterState.Celebrate)
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
                    if (type == CharacterType.Enemy)
                    {
                        UIManager.Instance.SpawnAwesomeText(transform.position, "+"+deathCoins);
                        CoinManager.Instance.AddCoins(deathCoins);
                    }
                    break;

                case CharacterState.Celebrate:
                    animator.Play("Victory");
                    canMove = false;
                    break;
                case CharacterState.Defeat:
                    //animator.Play("Defeat");
                    canMove = false;
                    break;

                case CharacterState.Swim:
                    canMove = false;

                    Destroy(gameObject, 5f);
                    break;
            }
        }
    }

}
