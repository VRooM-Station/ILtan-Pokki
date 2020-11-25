using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class playerscript : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        GameObject obj = (GameObject)Resources.Load("Tako");
        Instantiate(obj);
        string s = "tako";
        Debug.Log(s);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
