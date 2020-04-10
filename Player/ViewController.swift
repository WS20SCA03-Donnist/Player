//
//  ViewController.swift
//  Player
//
//  Created by Donavin Watson on 4/10/20.
//  Copyright © 2020 Don Watsy. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer: AVAudioPlayer = AVAudioPlayer();
var currentTime = audioPlayer.currentTime;


//Creates random UIColors
func random() -> UIColor {
	return UIColor(red: .random(in: 0...1),
				   green: .random(in: 0...1),
				   blue: .random(in: 0...1),
				   alpha: 1.0)
}

class ViewController: UIViewController {

	@IBOutlet weak var backgroundView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		// Do any additional setup after loading the view.
		let path: String = Bundle.main.path(forResource: "musette", ofType: "mp3")!;
		print("path = \(path)");
		
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path));
		} catch {
			print(error)
		}
		
		audioPlayer.numberOfLoops = 0;  //Plays once (-1 for infinite loop)
		audioPlayer.volume = 0.5;
		audioPlayer.play();
	}
	@IBAction func SwipeRight(_ sender: UISwipeGestureRecognizer) {
		if sender.direction == .right {
		print("Swipped Right")
		audioPlayer.play(atTime: currentTime + 30.0)
		backgroundView.backgroundColor = random()
		}
	}
	@IBAction func SwipeLeft(_ sender: UISwipeGestureRecognizer) {
		if sender.direction == .left {
		print("Swipped Left")
		audioPlayer.play(atTime: currentTime - 30.0)
		backgroundView.backgroundColor = random()
	    }
	}
	@IBAction func LongPressStop(_ sender: UILongPressGestureRecognizer) {
		audioPlayer.stop();
	}
	@IBAction func TapToPlay(_ sender: UITapGestureRecognizer) {
		audioPlayer.play();
	}
	@IBAction func valueChanged(_ sender: UISlider) {
		audioPlayer.volume = sender.value;
		
	}
	
	

	
	
}

