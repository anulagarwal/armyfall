using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class Wheel
{
   public int spawnNumber;
   public float wait;
}
public class EnemySpawner : MonoBehaviour
{
    [Header("Attributes")]
    [SerializeField] int numberOfCharacters;
    [SerializeField] float speed;
    [SerializeField] List<Wheel> wheel;
    [SerializeField] float spawnDelay = 0.1f;
    [SerializeField] float upgradeStrength;

    [Header("Component References")]
    [SerializeField] GameObject enemy;
    [SerializeField] List<Character> spawnedEnemies;
    [SerializeField] List<Transform> spawnPoints;

    public static EnemySpawner Instance = null;

    [SerializeField] private float startTime;
    private float wheelStartTime;
    [SerializeField] int wheelIndex;
    [SerializeField] bool isWaiting = true;

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
        startTime = Time.time;
        wheelIndex = 0;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.A))
        {
           // Spawn(spawnPoints[Random.Range(0, spawnPoints.Count)].position);
            Spawn(spawnPoints[GetNumberFromRange(spawnPoints.Count-1, spawnedEnemies.Count)].position);
        }

        if(startTime + wheel[wheelIndex].wait < Time.time && isWaiting)
        {
            if (wheelIndex < wheel.Count-1)
            {
                wheelIndex++;
                startTime = Time.time;
            }
            else
            {
                isWaiting = false;
            }

            StartCoroutine( StartSpawn());
        }
    }

    IEnumerator StartSpawn()
    {

        for (int i =0; i< wheel[wheelIndex].spawnNumber; i++)
        {
            Spawn(spawnPoints[GetNumberFromRange(spawnPoints.Count - 1, spawnedEnemies.Count)].position);
            yield return new WaitForSeconds(spawnDelay);
        }
        isWaiting = true;
        //At end spawn, increase index;
    }

    public void Spawn(Vector3 pos)
    {
        GameObject g = Instantiate(enemy, pos, enemy.transform.rotation);
        AddEnemy(g.GetComponent<Character>());
        g.GetComponent<Character>().UpdateDeathCoin(UpgradeManager.Instance.GetUpgradeValue(UpgradeType.Income));
    }


   
   
    public void Defeat()
    {
        isWaiting = false;
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


    public float CalculateTotalStrength()
    {
        float f = 0;
        foreach (Character c in spawnedEnemies)
        {
            if (c.GetState() == CharacterState.Push)
            {
                f += c.GetStrength();
            }
        }
        if (f != 0)
            return f;
        else
            return 0;
    }

    public void UpdateFriction(float v)
    {
        foreach (Character c in spawnedEnemies)
        {
            c.GetComponent<CapsuleCollider>().material.dynamicFriction = v;
            c.GetComponent<CapsuleCollider>().material.staticFriction = v;

        }
    }

   public void UpdateIncome(int v)
    {
        foreach (Character c in spawnedEnemies)
        {
            c.UpdateDeathCoin(v);
        }
    }
    public int GetNumberFromRange(int maxNumber, int testNumber)
    {       
        if (testNumber > maxNumber)
        {
            int newId = testNumber % maxNumber;
            if (newId == 0)
            {
                newId = maxNumber;
            }
            return newId;
        }
        else
        {
            return testNumber;
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
