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
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    #region Upgrades

    public void UpgradeStrength()
    {
        foreach(Character c in characters)
        {
            c.UpgradeStrength(upgradeVal);
        }
    }

    public void SpawnCharacter()
    {
        GameObject g = Instantiate(character, spawnPoints[Random.Range(0, spawnPoints.Count)].position, Quaternion.identity);
        AddCharacter(g.GetComponent<Character>());
    }

    public void UpgradeIncome()
    {
        //For everycharacter that falls
    }

    #endregion

    public void AddCharacter(Character c)
    {
        characters.Add(c);
    }

    public void RemoveCharacter(Character c)
    {
        characters.Remove(c);
    }

    
}
