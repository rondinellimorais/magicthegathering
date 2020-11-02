using UnityEngine;

public class ButtonBehaviour : RondinelliBehaviour
{
    static int currentImageIndex = 0;
    public MeshRenderer magicCardFront;

    public void NextImage()
    {
        if (cardsBase64Image.Length > 0)
        {
            currentImageIndex = Mathf.Min(cardsBase64Image.Length - 1, currentImageIndex + 1);
            ToggleImage(magicCardFront, cardsBase64Image[currentImageIndex]);
        }
    }

    public void PreviousImage()
    {
        if (cardsBase64Image.Length > 0)
        {
            currentImageIndex = Mathf.Max(0, currentImageIndex - 1);
            ToggleImage(magicCardFront, cardsBase64Image[currentImageIndex]);
        }
    }
}
