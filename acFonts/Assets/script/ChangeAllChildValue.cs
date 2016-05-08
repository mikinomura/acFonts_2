using UnityEngine;
using System.Collections;

public class ChangeAllChildValue : MonoBehaviour {

	public float value1;
	public float value2;
	public float value3;
	public Color color;

	// Use this for initialization
	void Start () {
		//Renderer[] renderers = GetComponentsInChildren<Renderer>();

	}
	
	// Update is called once per frame
	void Update () {
		Renderer[] renderers = GetComponentsInChildren<Renderer>();
		for (int i = 0; i < renderers.Length; i++) {
			renderers [i].material.SetFloat ("_Value1", value1);
			renderers [i].material.SetFloat ("_Value2", value2);
			renderers [i].material.SetFloat ("_Value3", value3);
		}
	
	}
}
