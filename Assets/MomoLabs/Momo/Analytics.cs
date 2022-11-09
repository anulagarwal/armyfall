using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using GameAnalyticsSDK;
namespace Momo
{
    
    public class Analytics : MonoBehaviour
    {
        [SerializeField] int appSessionCount;
        [SerializeField] int dayNumber;
        [SerializeField] int level;
        [SerializeField] float sessionTime;
        int lastLevel; 

        bool isPaused;
        Dictionary<string, object> fields = new Dictionary<string, object>();

        public static Analytics Instance = null;

        // Start is called before the first frame update
        void Awake()
        {

            GameObject[] objs = GameObject.FindGameObjectsWithTag("Analytics");

            if (objs.Length > 1)
            {
                Destroy(this.gameObject);
            }

            Application.targetFrameRate = 100;
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
            }
            Instance = this;

            DontDestroyOnLoad(this.gameObject);           
        }

        private void Start()
        {

            //Check if app opened on a new day - check when was last time opened
            //If opened on a new day, track day and level number

            appSessionCount = PlayerPrefs.GetInt("appSession", 0);
            level = PlayerPrefs.GetInt("level", 1);
          
            GameAnalytics.NewDesignEvent("session", appSessionCount);


            dayNumber = PlayerPrefs.GetInt("dayNumber", 0);
        }
  

        // Update is called once per frame
        void Update()
        {

        }


        #region App Level

        private void OnApplicationPause(bool pause)
        {
            isPaused = true;
            GameAnalytics.NewDesignEvent("sessionEnd", level);

            //Track session End with level number
        }

        private void OnApplicationFocus(bool focus)
        {
            if(focus && isPaused)
            {
                appSessionCount += 1;
                PlayerPrefs.SetInt("appSession", appSessionCount);
                GameAnalytics.NewDesignEvent("session", appSessionCount);
                isPaused = false;

                //Track session Start with level number
            }
        }

        #endregion


        #region Level Trackers

        public void StartLevel(int levelNumber)
        {
            TinySauce.OnGameStarted(levelNumber + "");
            level = levelNumber;
        }

        public void WinLevel()
        {
            TinySauce.OnGameFinished(true,0);
        }

        public void LoseLevel()
        {
            TinySauce.OnGameFinished(false, 0);
        }

        #endregion
        //Register daily logins
        //Register session times
        //Register last level left
        //FB/GA Login Events (Use Tiny Sauce)

    }
}
