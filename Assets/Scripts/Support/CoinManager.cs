using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CoinManager : MonoBehaviour
{
    [Header("Attributes")]
    [SerializeField] int startCoins;
    [SerializeField] int currentCoins = 500;

    [Header("Rewards")]
    [SerializeField] int levelReward;

    public static CoinManager Instance = null;

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
        startCoins = PlayerPrefs.GetInt("coins", startCoins);
        //currentCoins = startCoins;
       // currentCoins = 1500;
        UIManager.Instance.UpdateCurrentCoins(currentCoins);

    }

    // Update is called once per frame
    void Update()
    {
        
    }

    #region Level Rewards

    public void AddToLevelReward(int v)
    {
        levelReward += v;
        UIManager.Instance.UpdateLevelReward(levelReward);
    }

    public void MultiplyLevelReward(int v)
    {
        levelReward *= v;
        UIManager.Instance.UpdateLevelReward(levelReward);
    }

    #endregion

    
    #region Coin Getter Setter

    public int GetCoins()
    {
        return currentCoins;
    }
    public void AddCoins(int v)
    {
        currentCoins += v;
        PlayerPrefs.SetInt("coins", currentCoins);
        UIManager.Instance.UpdateCurrentCoins(currentCoins);
        GetComponent<UpgradeManager>().CheckAvailableUpgrades();

        //After every addition, check against upgrade values and check if need to be greyed;
    }

    public bool SubtractCoins(int v)
    {
        if (currentCoins - v >= 0)
        {
            currentCoins -= v;
            PlayerPrefs.SetInt("coins", currentCoins);
            UIManager.Instance.UpdateCurrentCoins(currentCoins);
            GetComponent<UpgradeManager>().CheckAvailableUpgrades();
            return true;
        }
        else
        {
            return false;
        }
    }

    #endregion

}
