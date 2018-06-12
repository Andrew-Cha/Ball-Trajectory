//
//  GameViewController.swift
//  Fizikos Metinis
//
//  Created by Andrius on 1/1/18.
//  Copyright © 2018 Andrius. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
	@IBOutlet weak var forceLabel: UILabel!
	@IBOutlet weak var trajectoryButton: UIButton!
	@IBOutlet weak var angleLabel: UILabel!
	@IBOutlet weak var statsButton: UIButton!
	@IBOutlet var gameView: SKView!
	weak var gameScene: GameScene!
	var statsShown = true
	var isGame = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let view = self.view as? SKView {
			guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
				fatalError("Could not load scene!")
			}
			
			scene.viewController = self
			scene.isGame = isGame
			gameScene = scene
			
			if !isGame {
				trajectoryButton.isHidden = true
				statsButton.isHidden = true
			}
			
			view.showsFPS = true
			view.showsNodeCount = true
			view.presentScene(scene)
		}
	}
	
	@IBAction func ballButtonPressed() {
		gameScene.player.resetPosition()
	}
	
	@IBAction func statsButtonPress(_ sender: Any) {
		if statsShown {
			statsShown = false
			angleLabel.isHidden = true
			forceLabel.isHidden = true
		} else {
			statsShown = true
		}
	}
	
	@IBAction func trajectoryButtonPress(_ sender: Any) {
		gameScene.trajectoryLine.show()
	}
	
	func throwStatsCreate() {
		if statsShown {
			angleLabel.isHidden = false
			angleLabel.text = ""
			forceLabel.isHidden = false
			forceLabel.text = ""
		}
	}
	
	func throwStatsUpdate(angle: CGFloat, force: CGFloat, position: CGPoint) {
		if statsShown {
			//if the labels are outside of the view make them be below the finger not above
			let convertedPosition = gameView.convert(position, from: gameScene)
			angleLabel.center = CGPoint(x: convertedPosition.x, y: convertedPosition.y - 70)
			forceLabel.center = CGPoint(x: convertedPosition.x, y: convertedPosition.y - 90)
			let numberFormatter = NumberFormatter()
			numberFormatter.numberStyle = .decimal
			numberFormatter.maximumFractionDigits = 2
			let newAngle = angle >= 0 ? angle : 360 + angle
			angleLabel.text = "\(numberFormatter.string(from: newAngle as NSNumber)!)°"
			forceLabel.text = "\(numberFormatter.string(from: force as NSNumber)!) Ns"
		}
	}
	
	func throwStatsRemove() {
		if statsShown {
			angleLabel.isHidden = true
			forceLabel.isHidden = true
		}
	}
	
	override var shouldAutorotate: Bool {
		return true
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
}
