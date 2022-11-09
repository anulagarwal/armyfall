using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerManager : MonoBehaviour
{

    public static PlayerManager Instance = null;


    [Header("Attributes")]

    //Include all trackers
    //Moves, Retries, Time Spent etc. 
    [SerializeField] List<PlayerLevelData> levelsPlayed;
    [SerializeField] PlayerType playerType;


    private void Awake()
    {
        Application.targetFrameRate = 100;
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
        }
        Instance = this;
    }

    public void AddLevelData(PlayerLevelData ld)
    {
        levelsPlayed.Add(ld);
    }

    public void Analyze()
    {

    }
}
