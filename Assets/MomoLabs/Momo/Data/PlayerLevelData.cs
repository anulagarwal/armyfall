using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[System.Serializable]
public class PlayerLevelData
{

    public int levelNumber;
    public int retries;
    public int numberOfMoves;
    public float timeSpent;

    public void Init(int level, int retry, int moves, float time)
    {
        levelNumber = level;
        retries = retry;
        numberOfMoves = moves;
        timeSpent = time;
    }
}
