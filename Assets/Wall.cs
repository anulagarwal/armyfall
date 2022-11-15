using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Wall : MonoBehaviour
{
    [Header("Attributes")]
    [SerializeField] public float moveStrength;
    [SerializeField] public float playerStrength;
    [SerializeField] public float enemyStrength;
    [SerializeField] public float speed;
    [SerializeField] public float moveSpeed;
    [SerializeField] public float maxFriction;



    void Start()
    {
        playerStrength = CharacterManager.Instance.CalculateTotalStrength();
        enemyStrength = EnemySpawner.Instance.CalculateTotalStrength();
    }

    private void Update()
    {
        playerStrength = CharacterManager.Instance.CalculateTotalStrength();
        enemyStrength = EnemySpawner.Instance.CalculateTotalStrength();
        if (playerStrength !=0&& enemyStrength != 0)
        {
            float diff = 1 - (playerStrength / enemyStrength);
            moveSpeed = diff;
            diff /= 10;

            transform.Translate(Vector3.forward * -diff * speed);
            if (diff < 0)
            {
                //Player push
                EnemySpawner.Instance.UpdateFriction(Mathf.Clamp(maxFriction - Mathf.Abs(diff), 0.06f, 0.25f));
                CharacterManager.Instance.UpdateFriction(0.3f);

                //print(Mathf.Clamp(maxFriction - Mathf.Abs(diff), 0.06f, 0.25f));

            }
            if (diff > 0)
            {
                //Enemy push
                CharacterManager.Instance.UpdateFriction(Mathf.Clamp(maxFriction - Mathf.Abs(diff), 0.06f, 0.25f));
                EnemySpawner.Instance.UpdateFriction(0.3f);
            }
        }
    }

    private void OnCollisionEnter(Collision collision)
    {
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
