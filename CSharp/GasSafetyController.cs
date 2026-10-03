using UnityEngine;

public class GasSafetyController : MonoBehaviour
{
    public ParticleSystem gasCloud;     // Link your ToxicGasCloud here
    public GameObject valveObject;      // Link your MainGasValve here

    private bool leakFixed = false;
    private float valveRotationProgress = 0f;

    void Update()
    {
        if (leakFixed) return;

        // Simulate a tap or click on the physical valve wheel
        if (Input.GetMouseButton(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                // If the worker successfully clicks/taps directly on the Valve object
                if (hit.transform == valveObject.transform)
                {
                    TurnValve();
                }
            }
        }
    }

    void TurnValve()
    {
        // Visually rotate the valve handle while clicking to simulate turning it off
        valveObject.transform.Rotate(Vector3.up * Time.deltaTime * 100f);
        valveRotationProgress += Time.deltaTime * 0.35f; // Takes about 3 seconds to fully close

        if (valveRotationProgress >= 1f)
        {
            leakFixed = true;
            if (gasCloud != null)
            {
                gasCloud.Stop(); // Stop the gas leak!
            }
            Debug.Log("SUCCESS: Main Valve Closed. Gas leak stopped, area secure.");
        }
    }
}
