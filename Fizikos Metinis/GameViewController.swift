//
//  GameViewController.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController, AngleAndForceLabel {
	var ballButtonDelegate: BallPosResetButton?
	var angleLabel: UILabel!
	var forceLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let scene = GKScene(fileNamed: "GameScene") {
			
			// Get the SKScene from the loaded GKScene
			if let sceneNode = scene.rootNode as! GameScene? {
				
				// Set the scale mode to scale to fit the window
				sceneNode.scaleMode = .aspectFill
				
				// Present the scene
				if let view = self.view as! SKView? {
					view.presentScene(sceneNode)
					
					ballButtonDelegate = sceneNode.player
					sceneNode.player.angleForceDelegate = self
					
					view.showsFPS = true
					view.showsNodeCount = true
				}
			}
		}
	}
	
	@IBAction func ballButtonPressed() {
		ballButtonDelegate?.resetPosition()
	}
	
	func createAngleForceLabels() {
		angleLabel = UILabel(frame: CGRect(x: 0, y: 60, width: 20, height: 10))
		forceLabel = UILabel(frame: CGRect(x: 0, y: 84, width: 20, height: 10))
		view.addSubview(angleLabel)
		view.addSubview(forceLabel)
		print(angleLabel)
		print(forceLabel)
	}
	
	func angleForceChanged(angle: CGFloat, force: Double) {
		angleLabel.text = ("\(angle) Degrees")
		forceLabel.text = ("\(force) Newtons")
	}
	
	func angleForceLabelsRemove() {
		angleLabel.removeFromSuperview()
		forceLabel.removeFromSuperview()
		print(angleLabel)
		print(forceLabel)
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
