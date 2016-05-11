/*
 * 
 * */

using UnityEngine;
using System.Collections;

public class ChangeSameValueToMesh : MonoBehaviour {

	private float value1;
	private float value2;
	private float value3;
	private float value4;

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {

		value1 = gameObject.GetComponent<Renderer> ().material.GetFloat ("_Value1");
		value2 = gameObject.GetComponent<Renderer> ().material.GetFloat ("_Value2");
		value3 = gameObject.GetComponent<Renderer> ().material.GetFloat ("_Value3");
		value4 = gameObject.GetComponent<Renderer> ().material.GetFloat ("_Value4");

		string meshObjectString = gameObject.name + "_m";
		GameObject meshObject = GameObject.Find(meshObjectString);
		meshObject.GetComponent<Renderer> ().material.SetFloat("_Value1", value1);
		meshObject.GetComponent<Renderer> ().material.SetFloat("_Value2", value2);
		meshObject.GetComponent<Renderer> ().material.SetFloat("_Value3", value3);
		meshObject.GetComponent<Renderer> ().material.SetFloat("_Value4", value4);
	}
}
