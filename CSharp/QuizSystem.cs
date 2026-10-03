using UnityEngine;
using TMPro;

public class QuizSystem : MonoBehaviour
{
    public GameObject quizPanel;          // Link your QuizPanel GameObject here
    public TextMeshProUGUI questionText;  // Link your QuestionText object here

    void Start()
    {
        // Hide the quiz panel when the training simulation first starts
        if (quizPanel != null)
        {
            quizPanel.SetActive(false);
        }
    }

    // This method will be called when the 3D fire is successfully put out
    public void ActivateQuiz()
    {
        if (quizPanel != null)
        {
            quizPanel.SetActive(true);
        }
    }

    // Connect this to your Option A Button click event
    public void SelectOptionA()
    {
        questionText.text = "CORRECT! Safety compliance approved.";
        questionText.color = Color.green;
        Debug.Log("Quiz Passed: Worker selected the correct safety procedure.");
    }

    // Connect this to your Option B Button click event
    public void SelectOptionB()
    {
        questionText.text = "INCORRECT. Please retry the module.";
        questionText.color = Color.red;
        Debug.Log("Quiz Failed: Incorrect option selected.");
    }
}