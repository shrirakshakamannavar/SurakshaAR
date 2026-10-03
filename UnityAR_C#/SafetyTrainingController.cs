/*using UnityEngine;

public class SafetyTrainingController : MonoBehaviour
{
    public ParticleSystem extinguisherFoam; // Link your foam particles here
    public ParticleSystem targetFire;       // Link your fire particles here
    public GameObject quizPanel;
    
    private float fireHealth = 1.0f;        // 1.0 = Max Fire, 0.0 = Put Out
    private bool isExtinguishing = false;

    void Update()
    {
        // Simulate pressing the fire extinguisher handle (Hold Mouse Left-Click or Screen Tap)
        if (Input.GetMouseButton(0))
        {
            isExtinguishing = true;
            
            // Turn on the foam spray effect
            if (extinguisherFoam != null && !extinguisherFoam.isPlaying)
            {
                extinguisherFoam.Play();
            }

            // Aiming check: Cast a virtual laser beam from the screen center forward
            Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0));
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                // Check if the user is aiming at the base of the fire
                if (hit.transform.gameObject.name.Contains("Fire") || hit.transform.gameObject.name.Contains("IndustrialFire"))
                {
                    ReduceFire();
                }
            }
        }
        else
        {
            isExtinguishing = false;
            // Stop spraying when button/tap is released
            if (extinguisherFoam != null && extinguisherFoam.isPlaying)
            {
                extinguisherFoam.Stop();
            }
        }
    }

    void ReduceFire()
    {
        // Shrink the fire over time while the user is accurately aiming at it
        fireHealth -= Time.deltaTime * 0.25f; // Takes ~4 seconds of continuous accurate aiming

        if (fireHealth <= 0)
        {
            fireHealth = 0;
            if (targetFire != null) targetFire.Stop(); 
            GetComponent<QuizSystem>().ActivateQuiz();
            if(quizPanel!=null) quizPanel.SetActive(true);
            // Put out the fire!
            Debug.Log("SUCCESS: Fire Extinguished! Safety Training Objective Achieved.");
        }
        else
        {
            // Dynamically scale down the fire object to visually show progress
            targetFire.transform.localScale = Vector3.one * fireHealth;
        }
    }
}
*/using UnityEngine;

public class SafetyTrainingController : MonoBehaviour
{
    public ParticleSystem extinguisherFoam; // Attached under your Main Camera

    private GameObject activeFireObject;
    private ParticleSystem activeFireParticles;
    private float fireHealth = 1.0f;        // 1.0 = Max Fire, 0.0 = Put Out

    void Update()
    {
        // 1. Handle Hold Left-Click / Screen Tap
        if (Input.GetMouseButton(0))
        {
            if (extinguisherFoam != null && !extinguisherFoam.isPlaying)
            {
                extinguisherFoam.Play();
            }

            // 2. Cast a virtual laser beam from the center of your screen forward
            Ray ray = Camera.main.ScreenPointToRay(new Vector3(Screen.width / 2, Screen.height / 2, 0));
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                // This line prints the exact name of whatever your mouse is touching! Watch your console window!
                Debug.Log("Your extinguisher foam is hitting: " + hit.transform.gameObject.name);

                // 3. Dynamically catch the fire if we point our hose at it
                if (hit.transform.gameObject.name.Contains("Fire") || hit.transform.gameObject.name.Contains("IndustrialFire"))
                {
                    // Cache the fire dynamically so we don't have to link it manually in the inspector
                    if (activeFireObject != hit.transform.gameObject)
                    {
                        activeFireObject = hit.transform.gameObject;
                        activeFireParticles = activeFireObject.GetComponent<ParticleSystem>();
                        
                        // If it doesn't have a particle system on itself, look in its children
                        if (activeFireParticles == null)
                        {
                            activeFireParticles = activeFireObject.GetComponentInChildren<ParticleSystem>();
                        }
                    }

                    ReduceFire();
                }
            }
        }
        else
        {
            // Stop spraying foam when left-click is released
            if (extinguisherFoam != null && extinguisherFoam.isPlaying)
            {
                extinguisherFoam.Stop();
            }
        }
    }

    void ReduceFire()
    {
        if (fireHealth <= 0) return;

        // Shrink the fire by 25% every second of continuous accurate aiming
        fireHealth -= Time.deltaTime * 0.25f; 

        if (fireHealth <= 0)
        {
            fireHealth = 0;
            if (activeFireParticles != null) activeFireParticles.Stop();
            
            Debug.Log("SUCCESS: Fire Extinguished! Safety Training Objective Achieved.");
            activeFireObject.SetActive(false); // Make the fire asset disappear
        }
        else
        {
            // Visually shrink the fire object to show the worker it's working
            if (activeFireObject != null)
            {
                activeFireObject.transform.localScale = Vector3.one * fireHealth;
            }
        }
    }
}