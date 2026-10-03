using UnityEngine;

public class SimulationManager : MonoBehaviour
{
    [Header("Safety Module Prefabs")]
    public GameObject firePrefab;
    public GameObject gasPrefab;
    public GameObject machineryPrefab;

    [Header("Spawn Reference")]
    public Transform spawnPoint; 

    private GameObject currentActiveModule;

    void Update()
    {
        // For testing inside the Unity Editor without a phone
        if (Input.GetKeyDown(KeyCode.Alpha1)) 
        {
            LoadSafetyModule("FireSafety");
        }
    }

    public void LoadSafetyModule(string moduleName)
    {
        if (currentActiveModule != null) 
        {
            Destroy(currentActiveModule);
        }

        switch (moduleName)
        {
            case "FireSafety":
                if (firePrefab != null && spawnPoint != null)
                {
                    currentActiveModule = Instantiate(firePrefab, spawnPoint.position, spawnPoint.rotation);
                }
                break;
            default:
                Debug.LogWarning("Unknown module: " + moduleName);
                break;
        }
    }
}