//
//  ViewController.swift
//  Player
//
//  Created by Donavin Watson on 4/10/20.
//  Copyright © 2020 Don Watsy. All rights reserved.
//

import UIKit
import AVFoundation

var lightOn: Bool = true
var audioPlayer: AVAudioPlayer = AVAudioPlayer() 
var currentTime = audioPlayer.currentTime 
let PlayerPadView = UIView()
let nightYellow = #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1)
let nightText = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)


//Creates random UIColors
func random() -> UIColor {
	return UIColor(red: .random(in: 0...1),
				   green: .random(in: 0...1),
				   blue: .random(in: 0...1),
				   alpha: 1.0)
}

class ViewController: UIViewController {

	@IBOutlet weak var backgroundView: UIView!
	
	@IBOutlet weak var PlayerGUI: UILabel!
	
	@IBOutlet weak var bgView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		// Do any additional setup after loading the view.
		
		
		let path: String = Bundle.main.path(forResource: "musette", ofType: "mp3")! 
		print("path = \(path)") 
		
		do {
			audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)) 
		} catch {
			print(error)
		}
		audioPlayer.enableRate = true
		audioPlayer.prepareToPlay()
		audioPlayer.numberOfLoops = 0   //Plays once (-1 for infinite loop)
		audioPlayer.volume = 0.5 
		audioPlayer.play() 
	}
	
	@IBAction func swipeGesture(_ sender: UISwipeGestureRecognizer) {
		switch sender.direction {
			case .right:
				PlayerGUI.text = "Play Fast" 
				audioPlayer.rate = 2
			case .left:
				PlayerGUI.text = "Play Slow" 
				audioPlayer.rate = 0.5 
			case .up:
				PlayerGUI.text = "Let there be Light!" 
				lightOn = true 
			    updateUI()
			case .down:
				PlayerGUI.text = "Let there be Night!" 
				lightOn = false 
			    updateUI()
			default:
				PlayerGUI.text = "" 
			
		}
		    bgView.backgroundColor = random()
	}
	
	func updateUI() {
		if lightOn {
			view.backgroundColor = .white
			PlayerGUI.backgroundColor = .yellow
			PlayerGUI.textColor = .purple
		}	else {
			view.backgroundColor = .black
			PlayerGUI.backgroundColor = nightYellow
			PlayerGUI.textColor = nightText
		}
		    setNeedsStatusBarAppearanceUpdate() 
	}
	
	@IBAction func LongPressStop(_ sender: UILongPressGestureRecognizer) {
		audioPlayer.stop() 
		PlayerGUI.text = "Tap To Continue Music"
	}
	@IBAction func TapToPlay(_ sender: UITapGestureRecognizer) {
		audioPlayer.play() 
		PlayerGUI.text = "Long Press To Stop"
	}
	@IBAction func valueChanged(_ sender: UISlider) {
		audioPlayer.volume = sender.value 
		
	}
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
        return lightOn ? .darkContent : .lightContent 
    }

	
	
}

