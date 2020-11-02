using UnityEngine;

public class CardBehaviour : RondinelliBehaviour
{
    public MeshRenderer meshRenderer;

    // Start is called before the first frame update
    void Start()
    {
        // configure android
        AndroidJavaClass UnityPlayer = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
        AndroidJavaObject currentActivity = UnityPlayer.GetStatic<AndroidJavaObject>("currentActivity");
        if (currentActivity != null)
        {
            AndroidJavaObject intent = currentActivity.Call<AndroidJavaObject>("getIntent");
            string cardBase64Image = GetStringExtraParams(intent, "cardBase64Image");
            ToggleImage(meshRenderer, cardBase64Image);
        }
    }
}
