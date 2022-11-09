using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Momo;
public class GameManager : MonoBehaviour
{
    #region Properties
    public static GameManager Instance = null;

    [Header("Component Reference")]
    [SerializeField] public GameObject confetti;
    [SerializeField] public List<MonoBehaviour> objectsToDisable;

    [Header("Game Attributes")]
    [SerializeField] private int currentScore;
    [SerializeField] private int currentLevel;
    [SerializeField] public GameState currentState;

    #endregion

    #region MonoBehaviour Functions
    private void Awake()
    {
        Application.targetFrameRate = 100;
        if (Instance != null && Instance != this)
        {
            Destroy(gameObject);
        }
        Instance = this;
    }

    private void Start()
    {
        currentLevel = PlayerPrefs.GetInt("level", 1);       
        UIManager.Instance.UpdateLevel(currentLevel);
        currentState = GameState.Main;
    }

    #endregion

    
    public void StartLevel()
    {
        UIManager.Instance.SwitchUIPanel(UIPanelState.Gameplay);       
        currentState = GameState.InGame;
        Analytics.Instance.StartLevel(currentLevel);
    }


    public void WinLevel()
    {
        if (currentState == GameState.InGame)
        {
            //confetti.SetActive(true);
            Invoke("ShowWinUI", 1.4f);
          
            currentState = GameState.Win;

            PlayerPrefs.SetInt("level", currentLevel + 1);
            currentLevel++;

            foreach(MonoBehaviour m in objectsToDisable)
            {
                m.enabled = false;
            }
            Analytics.Instance.WinLevel();
        }
    }

    public void LoseLevel()
    {
        if (currentState == GameState.InGame)
        {
            Invoke("ShowLoseUI", 2f);
            currentState = GameState.Lose;
            foreach (MonoBehaviour m in objectsToDisable)
            {
                m.enabled = false;
            }
            Analytics.Instance.LoseLevel();
        }
    }

    #region Scene Management



    public void ChangeLevel()
    {
            SceneManager.LoadScene("Core");       
    }

    #endregion


    #region Public Core Functions

    public void AddScore(int value)
    {
        currentScore += value;
        UIManager.Instance.UpdateScore(currentScore);
    }


    #endregion

    #region Invoke Functions

    void ShowWinUI()
    {
        UIManager.Instance.SwitchUIPanel(UIPanelState.GameWin);
    }

    void ShowLoseUI()
    {
        UIManager.Instance.SwitchUIPanel(UIPanelState.GameLose);
    }
    #endregion
}
