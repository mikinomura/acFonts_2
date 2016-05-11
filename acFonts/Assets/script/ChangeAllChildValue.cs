using UnityEngine;
using System.Collections;
using UnityEngine.UI;

public class ChangeAllChildValue : MonoBehaviour {

	private float value1;
	private float value2;
	private float value3;
	private float value4;
	public Color color;
	private GameObject Value1SliderGet;
	private GameObject Value2SliderGet;
	private GameObject Value3SliderGet;
	private GameObject Value4SliderGet;

	public Slider value1Slider;
	public Slider value2Slider;
	public Slider value3Slider;
	public Slider value4Slider;

	// Use this for initialization
	void Start () {
		//Renderer[] renderers = GetComponentsInChildren<Renderer>();
		//Adds a listener to the main slider and invokes a method when the value changes.
		value1Slider.onValueChanged.AddListener (delegate {ChangeParameter ();});
		value2Slider.onValueChanged.AddListener (delegate {ChangeParameter ();});
		value3Slider.onValueChanged.AddListener (delegate {ChangeParameter ();});
		value4Slider.onValueChanged.AddListener (delegate {ChangeParameter ();});
	}
	
	// Update is called once per frame
	void Update () {
		
	}
		
	void ChangeParameter(){
		Renderer[] renderers = GetComponentsInChildren<Renderer>();
		Value1SliderGet = GameObject.Find ("Value 1 Slider");
		value1 = Value1SliderGet.GetComponent<Slider> ().value;

		Value2SliderGet = GameObject.Find ("Value 2 Slider");
		value2 = Value2SliderGet.GetComponent<Slider> ().value;

		Value3SliderGet = GameObject.Find ("Value 3 Slider");
		value3 = Value3SliderGet.GetComponent<Slider> ().value;

		Value4SliderGet = GameObject.Find ("Value 4 Slider");
		value4 = Value4SliderGet.GetComponent<Slider> ().value / 10f;

		for (int i = 0; i < renderers.Length; i++) {
			renderers [i].material.SetFloat ("_Value1", Random.Range(0,value1));
			renderers [i].material.SetFloat ("_Value2", Random.Range(0,value2));
			renderers [i].material.SetFloat ("_Value3", value3);
			renderers [i].material.SetFloat ("_Value4", value4);
		}
	}
}
