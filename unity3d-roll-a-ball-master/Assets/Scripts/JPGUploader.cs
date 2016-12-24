// Saves screenshot as PNG file.
using UnityEngine;
using System.Collections;
using System.IO;


public class JPGUploader : MonoBehaviour {

	public static JPGUploader uploader;
	public int stepnumber;
	public int gamestate;

	

	// Take a shot immediately
	IEnumerator Start () {
		uploader = this;
		stepnumber = 0;
		
		File.WriteAllText(Application.dataPath + "/../Atari2/action.txt", "5");
		File.WriteAllText(Application.dataPath + "/../Atari2/stepnumber.txt", "0");
		File.WriteAllText(Application.dataPath + "/../Atari2/startgame.txt", "0");


		while (true) {

			if(!File.Exists(Application.dataPath + "/../sem2.txt") && !File.Exists(Application.dataPath + "/../networkSWSem.txt"))
			{
			
			File.WriteAllText(Application.dataPath + "/../sem1.txt", null);
			File.WriteAllText(Application.dataPath + "/../unitySWSem.txt", null);

			yield return UploadPNG ();

			File.Delete(Application.dataPath + "/../sem1.txt");
			File.Delete(Application.dataPath + "/../unitySWSem.txt");
			}

			yield return new WaitForSeconds(0.016F);

			//GameObject thePlayer = GameObject.Find("Player");
			//PlayerController playerScript = thePlayer.GetComponent<PlayerController>();
        		
			
		}
	}

	

	IEnumerator UploadPNG() {
		// We should only read the screen buffer after rendering is complete
		yield return new WaitForEndOfFrame();

		// Create a texture the size of the screen, RGB24 format
		int width = Screen.width;
		int height = Screen.height;
		Texture2D tex = new Texture2D(width, height, TextureFormat.RGB24, false);

		// Read screen contents into the texture
		tex.ReadPixels(new Rect(0, 0, width, height), 0, 0);
		tex.Apply();

		// Encode texture into PNG ---> outputs bytes array
		byte[] bytes = tex.EncodeToJPG();
		Object.Destroy(tex);

		// For testing purposes, also write to a file in the project folder
		File.WriteAllBytes(Application.dataPath + "/../SavedScreen.jpg", bytes);
		Debug.Log ("Screen Saved");
		
		//----read Action----
		string text = File.ReadAllText(Application.dataPath + "/../Atari2/action.txt");
		int action = 5;
		int.TryParse(text, out action);
		
		//Random rnd = new Random();
		//action = Random.Range(1, 5);

		//-----set Actions in PlayerController----
		if (action == 1){
		PlayerController.instance.moveHorizontal = -1;
		PlayerController.instance.moveVertical = 0;
		}
		else if (action == 2){
		PlayerController.instance.moveHorizontal = 1;
		PlayerController.instance.moveVertical = 0;
		}
		else if (action == 3){
		PlayerController.instance.moveHorizontal = 0;
		PlayerController.instance.moveVertical = 1;
		}
		else if (action == 4){
		PlayerController.instance.moveHorizontal = 0;
		PlayerController.instance.moveVertical = -1;
		}
		else if (action == 5){
		PlayerController.instance.moveHorizontal = 0;
		PlayerController.instance.moveVertical = 0;
		}		
		
		int score = PlayerController.instance.scorePlayer;		
		int win = PlayerController.instance.won;

		File.WriteAllText(Application.dataPath + "/../score.txt", score.ToString());
		File.WriteAllText(Application.dataPath + "/../win.txt", win.ToString());

		string textstep = File.ReadAllText(Application.dataPath + "/../Atari2/stepnumber.txt");
		int.TryParse(textstep, out stepnumber);

		
		string textgame = File.ReadAllText(Application.dataPath + "/../Atari2/startgame.txt");
		int.TryParse(textgame, out gamestate);
		
		if (gamestate == 1){
		Application.LoadLevel ("MiniGame");
		}
		Debug.Log(action);
		Debug.Log(win);
		Debug.Log(score);
		Debug.Log(stepnumber);
			



	}

}
