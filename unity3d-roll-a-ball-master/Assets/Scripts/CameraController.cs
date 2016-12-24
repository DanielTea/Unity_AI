using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour {
	public GameObject player;
	private Vector3 offset;

	void Start () {
		
		offset = transform.position;
	}

	void LateUpdate () {
		//Screen.SetResolution(50, 50, true);
		transform.position = player.transform.position + offset;
	}
}
