//
//  GameViewController.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, AngleAndForceLabel {
	var ballButtonDelegate: BallPosResetButton?
	@IBOutlet weak var forceLabel: UILabel!
	@IBOutlet weak var angleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let view = self.view as? SKView {
			guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
				fatalError("Could not load scene!")
			}
			// Set the scale mode to scale to fit the window
			scene.scaleMode = .aspectFill
			view.presentScene(scene)
			
			ballButtonDelegate = scene.player
			scene.player.angleForceDelegate = self
			
			view.showsFPS = true
			view.showsNodeCount = true
		}
	}
	
	@IBAction func ballButtonPressed() {
		ballButtonDelegate?.resetPosition()
	}
	
	func createAngleForceLabels() {
		angleLabel.isHidden = false
		forceLabel.isHidden = false
		print(angleLabel)
		print(forceLabel)
	}
	
	func angleForceAndPositionChanged(angle: CGFloat, force: Double, position: CGPoint) {
		//if the labels are outside of the view make them be below the finger not above
		angleLabel.frame.origin = CGPoint(x: position.x + 20, y: position.y)
		angleLabel.frame.origin = CGPoint(x: position.x + 40, y: position.y)
		angleLabel.text = ("\(angle) Degrees")
		forceLabel.text = ("\(force) Newtons")
	}
	
	func angleForceLabelsRemove() {
		angleLabel.isHidden = false
		angleLabel.isHidden = false
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

