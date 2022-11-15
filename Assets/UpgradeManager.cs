using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class UpgradeManager : MonoBehaviour
{

    public static UpgradeManager Instance = null;


    [Header("Attributes")]
    [SerializeField] List<Cost> spawnUpgrade;
    [SerializeField] List<Cost> strengthUpgrade;
    [SerializeField] List<Cost> incomeUpgrade;

    [SerializeField] int spawnBaseValue;
    [SerializeField] int spawnUpgradeMultiply;

    [SerializeField] int strBaseValue;
    [SerializeField] int strUpgradeMultiply;


    [SerializeField] int incBaseValue;
    [SerializeField] int incUpgradeMultiply;

    [SerializeField] int curSpawnLevel;
    [SerializeField] int curStrengthLevel;
    [SerializeField] int curIncomeLevel;

    [SerializeField] int upgradeAmount =50;

    CoinManager cm;

    private void Awake()
    {
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
        }
        Instance = this;
    }



    // Start is called before the first frame update
    void Start()
    {
        cm = GetComponent<CoinManager>();
        curSpawnLevel = PlayerPrefs.GetInt("spawn", 1);
        curStrengthLevel = PlayerPrefs.GetInt("strength", 1);
        curIncomeLevel = PlayerPrefs.GetInt("income", 1);
        CheckAvailableUpgrades();
        strBaseValue = strengthUpgrade[0].value;
        strUpgradeMultiply = strengthUpgrade[1].value - strBaseValue;

        incBaseValue = incomeUpgrade[0].value;
        incUpgradeMultiply = incomeUpgrade[1].value - incBaseValue;

        spawnBaseValue = spawnUpgrade[0].cost;
        spawnUpgradeMultiply = spawnUpgrade[1].value - spawnBaseValue;

        UIManager.Instance.UpdateIncome(curIncomeLevel + "", GetUpgradeCost(UpgradeType.Income) + "");
        UIManager.Instance.UpdateStr(curStrengthLevel + "", GetUpgradeCost(UpgradeType.Strength) + "");
        UIManager.Instance.UpdateSpawn(curSpawnLevel + "", GetUpgradeCost(UpgradeType.Spawn) + "");

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void UpgradeStrength()
    {
        CharacterManager.Instance.UpgradeStrength(GetUpgradeValue(UpgradeType.Strength));
        print(GetUpgradeValue(UpgradeType.Strength));
        curStrengthLevel++;
        cm.SubtractCoins(GetUpgradeCost(UpgradeType.Strength)-100);

        UIManager.Instance.UpdateStr(curStrengthLevel + "", GetUpgradeCost(UpgradeType.Strength) + "");

        PlayerPrefs.SetInt("strength", curStrengthLevel);
        //Upgrade Text - Level & Cost

    }

    public void UpgradeIncome()
    {
        EnemySpawner.Instance.UpdateIncome(GetUpgradeCost(UpgradeType.Income));
        curIncomeLevel++;
        cm.SubtractCoins(GetUpgradeCost(UpgradeType.Income)-100);
        UIManager.Instance.UpdateIncome(curIncomeLevel+"", GetUpgradeCost(UpgradeType.Income)+"");
        PlayerPrefs.SetInt("income", curIncomeLevel);

        //Upgrade Text - Level & Cost
    }

    public void UpgradeSpawn()
    {
        CharacterManager.Instance.SpawnCharacter();
        curSpawnLevel++;

        cm.SubtractCoins(GetUpgradeCost(UpgradeType.Spawn)-100);
        UIManager.Instance.UpdateSpawn(curSpawnLevel + "", GetUpgradeCost(UpgradeType.Spawn) + "");

        PlayerPrefs.SetInt("spawn", curSpawnLevel);
        //Upgrade Text - Level & Cost
    }

    public void CheckAvailableUpgrades()
    {
        if(cm.GetCoins()< GetUpgradeCost(UpgradeType.Strength))
        {
            print(GetUpgradeCost(UpgradeType.Strength));
            print(cm.GetCoins());
            UIManager.Instance.StrActive(false);
        }
        else
        {
            UIManager.Instance.StrActive(true);
        }

        if (cm.GetCoins() < GetUpgradeCost(UpgradeType.Income))
        {
            UIManager.Instance.IncomeActive(false);
        }
        else
        {
            UIManager.Instance.IncomeActive(true);
        }

        if (cm.GetCoins() < GetUpgradeCost(UpgradeType.Spawn))
        {
            UIManager.Instance.SpawnActive(false);
        }
        else
        {
            UIManager.Instance.SpawnActive(true);
        }
    }
    public int GetUpgradeCost(UpgradeType t)
    {
        switch (t)
        {
            case UpgradeType.Income:
                //return incomeUpgrade[curIncomeLevel-1].cost;
                return curIncomeLevel* upgradeAmount;


            case UpgradeType.Spawn:
                // return spawnUpgrade[curSpawnLevel-1].cost;
                return curSpawnLevel * upgradeAmount;

            case UpgradeType.Strength:
                // return strengthUpgrade[curStrengthLevel-1].cost;
                return curStrengthLevel * upgradeAmount;
        }
        return 0;
    }

    public int GetUpgradeValue(UpgradeType t)
    {
        switch (t)
        {
            case UpgradeType.Income:
                //return incomeUpgrade[curIncomeLevel-1].cost;
                return incBaseValue + (incUpgradeMultiply * (curIncomeLevel-1)) ;


            case UpgradeType.Spawn:
                // return spawnUpgrade[curSpawnLevel-1].cost;
                return spawnBaseValue + (spawnUpgradeMultiply * (curSpawnLevel - 1));


            case UpgradeType.Strength:
                // return strengthUpgrade[curStrengthLevel-1].cost;
                return strBaseValue + (strUpgradeMultiply * (curStrengthLevel - 1));

        }
        return 0;
    }
}
