using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelsManager : MonoBehaviour
{
    public static LevelsManager Instance = null;


    [Header("Attributes")]
    //Custom level class with difficulty level
    [SerializeField] List<GameObject> defaultLevelProgression;
    [SerializeField] List<GameObject> proLevelProgression;
    [SerializeField] List<GameObject> noobLevelProgression;
    [SerializeField] int currentLevel;




    private void Awake()
    {
        Application.targetFrameRate = 100;
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
        }
        Instance = this;
    }

    
}
