using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class CharacterManager : MonoBehaviour
{
    [Header("Component References")]
    [SerializeField] List<Transform> spawnPoints;
    [SerializeField] List<Character> characters;
    [SerializeField] GameObject character;

    [Header("Attributes")]
    [SerializeField] int upgradeVal;
    [SerializeField] int queueCount;
    [SerializeField] float spawnDelay;
    float StartTime;
    bool isSpawning;



    public static CharacterManager Instance = null;


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
        StartTime = Time.time;
    }

    // Update is called once per frame
    void Update()
    {
        if (queueCount > 0)
        {
            if(StartTime +spawnDelay < Time.time)
            {
                Spawn();
            }
        }
    }


    #region Upgrades

    public void UpgradeStrength(int val)
    {
        foreach(Character c in characters)
        {
            c.UpgradeStrength(upgradeVal);
        }
    }

    public void UpdateFriction(float v)
    {
        foreach (Character c in characters)
        {
            c.GetComponent<CapsuleCollider>().material.dynamicFriction = v;
            c.GetComponent<CapsuleCollider>().material.staticFriction = v;

        }
    }
    public void SpawnCharacter()
    {
        queueCount++;
    }

    public void Spawn()
    {
        GameObject g = Instantiate(character, spawnPoints[GetNumberFromRange(spawnPoints.Count - 1, characters.Count)].position, Quaternion.identity);
        AddCharacter(g.GetComponent<Character>());
        g.GetComponent<Character>().UpdateStrength(UpgradeManager.Instance.GetUpgradeValue(UpgradeType.Strength));
        queueCount--;
        StartTime = Time.time;
    }
 
    public void UpgradeIncome()
    {
        //For everycharacter that falls
    }
    #endregion
    public float CalculateTotalStrength()
    {
        float f = 0;
        foreach(Character c in characters)
        {
            if(c.GetState()== CharacterState.Push)
            {
                f+=c.GetStrength();
            }
        }

        if (f != 0)
            return f;
        else
            return 0;
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


  

    public void Victory()
    {
        foreach (Character c in characters)
        {
            c.UpdateState(CharacterState.Celebrate);
            if(c.GetState() == CharacterState.Push)
            c.GetComponent<Rigidbody>().isKinematic = true;
        }
    }


    public void Defeat()
    {
        foreach (Character c in characters)
        {
            c.UpdateState(CharacterState.Defeat);
            if (c.GetState() == CharacterState.Push)
                c.GetComponent<Rigidbody>().isKinematic = true;
        }
    }
    public void AddCharacter(Character c)
    {
        characters.Add(c);
    }

    public void RemoveCharacter(Character c)
    {
        characters.Remove(c);
    }

    
}
