using System;
using UnityEngine;

public class RondinelliBehaviour : MonoBehaviour
{
    GUIStyle style;

    public string message = null;
    public string[] cardsBase64Image = null;

    // Start is called before the first frame update
    void Start()
    {
        // configure android
        AndroidJavaClass UnityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
        AndroidJavaObject currentActivity = UnityPlayer.GetStatic<AndroidJavaObject>("currentActivity");
        if (currentActivity != null)
        {
            AndroidJavaObject intent = currentActivity.Call<AndroidJavaObject>("getIntent");
            cardsBase64Image = GetStringArrayExtraParams(intent, "cardsBase64Image");
        }
    }

    private void Update()
    {
        if (Application.platform == RuntimePlatform.Android)
        {
            if (Input.GetKeyDown(KeyCode.Escape))
            {
                Application.Quit();
            }
        }
    }

    public string GetStringExtraParams(AndroidJavaObject intent, string key)
    {
        var extras = GetExtraParams(intent, key);
        if (extras != null)
        {
            return extras.Call<string>("getString", key);
        }
        return null;
    }

    public string[] GetStringArrayExtraParams(AndroidJavaObject intent, string key)
    {
        var extras = GetExtraParams(intent, key);
        if (extras != null)
        {
            return extras.Call<string[]>("getStringArray", key);
        }
        return null;
    }

    public void ToggleImage(Renderer renderer, string base64String)
    {
        Texture2D texture2D = new Texture2D(1, 1);
        byte[] bytes = Convert.FromBase64String(base64String);
        texture2D.LoadImage(bytes);
        texture2D.Apply();

        renderer.material.mainTexture = texture2D;
    }

    AndroidJavaObject GetExtraParams(AndroidJavaObject intent, string key)
    {
        if (intent != null)
        {
            bool hasExtra = intent.Call<bool>("hasExtra", key);
            if (hasExtra)
            {
                return intent.Call<AndroidJavaObject>("getExtras");
            }
        }
        return null;
    }

    void OnGUI()
    {
        style = new GUIStyle
        {
            fontSize = 30,
            padding = new RectOffset()
            {
                top = 10,
                left = 10
            }
        };

        style.normal.textColor = Color.red;

        GUILayout.Label(message, style);
    }
}
