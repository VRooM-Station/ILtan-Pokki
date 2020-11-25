using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.XR;

public class Iltan : MonoBehaviour
{
    List<Collider> ps = new List<Collider>();
    AudioSource audio;
    SkinnedMeshRenderer sk;
    GameObject pokki;
    GameObject cam;
    float eye = 0f;
    float mouth = 0f;
    float timer = 0f;
    public OVRHand r;
    public OVRHand l;
    // Start is called before the first frame update
    void Start()
    {
        cam = GameObject.Find("CenterEyeAnchor");
        audio = GetComponent<AudioSource>();
        pokki = GameObject.Find("Pokki");
        sk = GameObject.Find("U_Char_1").GetComponent<SkinnedMeshRenderer>();
    }
    void Update()
    {
        timer += Time.deltaTime;
        sk.SetBlendShapeWeight(27, mouth);
        this.transform.position = new Vector3(cam.transform.position.x, cam.transform.position.y, cam.transform.position.z + 0.15f);
        if(r.GetFingerPinchStrength(OVRHand.HandFinger.Ring) > 0.8f || l.GetFingerPinchStrength(OVRHand.HandFinger.Ring) > 0.8f)
        {
            SceneManager.LoadScene(SceneManager.GetActiveScene().name);
        }

    }
    void OnTriggerEnter(Collider p)
    {
        GetComponent<AutoBlink>().enabled = false;
        eye += 2.5f;
        mouth += 1f;
        if (eye < 100f)
        {
            sk.SetBlendShapeWeight(10, eye);
            //ps.Add(p);
            p.gameObject.SetActive(false);
            if(timer > 0.37f)
            {
                audio.Play();
                timer = 0f;
            }

        }
        if(mouth >= 30f)
        {
            mouth = 0f;
        }
       if(eye >= 100f)
        {
            pokki.SetActive(false);
            Invoke("OpenEye", 2f);
            mouth = 0f;
        }
    }
    void OpenEye()
    {
        eye = 0f;
        sk.SetBlendShapeWeight(10, eye);
        mouth = 0f;
        sk.SetBlendShapeWeight(29, 0f); //口を閉じる
        sk.SetBlendShapeWeight(36, 30f); // 口を横に    
        sk.SetBlendShapeWeight(12, 100f); // 眼を笑わせる

    }
}
