using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySpawner : MonoBehaviour
{
    [Header("Attributes")]
    [SerializeField] int numberOfCharacters;
    [SerializeField] float speed;

    [Header("Component References")]
    [SerializeField] GameObject enemy;
    [SerializeField] List<Character> spawnedEnemies;
    [SerializeField] List<Transform> spawnPoints;

    public static EnemySpawner Instance = null;


    private void Awake()
    {
        Application.targetFrameRate = 100;
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
        }
        Instance = this;
    }


    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.A))
        {
            Spawn(spawnPoints[Random.Range(0, spawnPoints.Count)].position);
        }
    }

    public void Spawn(Vector3 pos)
    {
        GameObject g = Instantiate(enemy, pos, enemy.transform.rotation);
        AddEnemy(g.GetComponent<Character>());
    }

    public void Defeat()
    {
        foreach (Character c in spawnedEnemies)
        {
            if (c != null)
            {
                Destroy(c.gameObject);
            }
            else
            {
                spawnedEnemies.Remove(c);
            }
        }
    }

    public void AddEnemy(Character e)
    {
        spawnedEnemies.Add(e);
    }

    public void RemoveEnemy(Character e)
    {
        spawnedEnemies.Remove(e);
    }
}
