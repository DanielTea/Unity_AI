using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.IO;

public class PlayerController : MonoBehaviour {
	public float speed;
	public Text countText;
	public Text winText;
	public int count;
	public int won = 0;
	public int scorePlayer;

	public static PlayerController instance;
	public float moveHorizontal;
	public float moveVertical;

	void Start() {
		count = 0;
		//countText = GetComponent<Text>();
		SetCountText();
		winText.text = "";
		instance = this;

		
	}

	// Before physics calculations
	void FixedUpdate() {

		Time.timeScale = 3.0f;

		Vector3 movement = new Vector3(moveHorizontal, 0.0f, moveVertical);

		GetComponent<Rigidbody>().AddForce(movement * speed * Time.deltaTime);

		if (count != 0 ){
			scorePlayer = count;
		}

	}

	void OnTriggerEnter(Collider other) {
		if (other.gameObject.tag == "PickUp") {
			other.gameObject.SetActive (false);
			count++;
			SetCountText();
		}
	}


	void SetCountText() {
		countText.text = "Count: " + count.ToString();
		if (count >= 12) {
			winText.text = "YOU WIN!";
			won = 1;			

			Application.LoadLevel ("MiniGame");
		}
		

	}
}
