using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class ChangeAllChildValue : MonoBehaviour {

	private float value1;
	private float value2;
	private float value3;
	public Color color;
	private GameObject Value1SliderGet;
	private GameObject Value2SliderGet;
	private GameObject Value3SliderGet;

	// Use this for initialization
	void Start () {
		//Renderer[] renderers = GetComponentsInChildren<Renderer>();

	}
	
	// Update is called once per frame
	void Update () {
		Renderer[] renderers = GetComponentsInChildren<Renderer>();
		Value1SliderGet = GameObject.Find ("Value 1 Slider");
		value1 = Value1SliderGet.GetComponent<Slider> ().value;

		Value2SliderGet = GameObject.Find ("Value 2 Slider");
		value2 = Value2SliderGet.GetComponent<Slider> ().value;

		Value3SliderGet = GameObject.Find ("Value 3 Slider");
		value3 = Value3SliderGet.GetComponent<Slider> ().value;
	
		for (int i = 0; i < renderers.Length; i++) {
			renderers [i].material.SetFloat ("_Value1", value1);
			renderers [i].material.SetFloat ("_Value2", value2);
			renderers [i].material.SetFloat ("_Value3", value3);
		}
	
	}
}
