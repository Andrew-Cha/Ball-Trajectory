//
//  GameScene.swift
//  Fizikos Metinis
//
//  Created by Andrius on 12/26/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
	var player: Ball!
	var bottomBorder: BottomBorder?
	var cam: SKCameraNode!
	var draggingLine: DragLine!
	var trajectoryLine: TrajectoryLine!
	var hoop: Basketball?
	var isGame = false
	var viewController: GameViewController!
	var currentScore = 0
	var scoreLabel: SKLabelNode?
	
	override func didMove(to view: SKView) {
		if isGame {
			loadGame()
			self.physicsWorld.contactDelegate = self
		} else {
			loadSimulation()
		}
		
		trajectoryLine.createDotsToStore()
		
		player.setScale(1.33)
		cam.setScale(2)
	}
	
	override func update(_ currentTime: TimeInterval) {
		if !isGame {
			cam.position = player.position
		}
		
		if isGame {
			if player.position.y < 50 {
				player.resetPosition()
			}
		}
	}
	
	func loadGame() {
		let ballPoint = CGPoint(x: 150, y: 224)
		let hoopPoint = CGPoint(x: -320, y: 224)
		player = Ball(in: self, resetPoint: ballPoint)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self, initialPosition: ballPoint)
		trajectoryLine = TrajectoryLine(in: self, ballPoint: ballPoint)
		hoop = Basketball(in: self, at: hoopPoint)
		
		cam = SKCameraNode()
		scene?.camera = cam
		cam.position = CGPoint(x: 100, y: 250)
		
		scoreLabel = SKLabelNode()
		scoreLabel?.fontName = "Arial"
		scoreLabel?.fontSize = 100
		scoreLabel?.fontColor = UIColor.black
		scoreLabel?.position = CGPoint(x: 100, y: 350)
		scoreLabel?.alpha = 0
		addChild(scoreLabel!)
	}
	
	func loadSimulation() {
		let ballPoint = CGPoint(x: 0, y: 33)
		player = Ball(in: self, resetPoint: ballPoint)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self, initialPosition: ballPoint)
		trajectoryLine = TrajectoryLine(in: self, ballPoint: ballPoint)
		
		cam = SKCameraNode()
		scene?.camera = cam
	}
	
	func showScore() {
		let fadeIn = SKAction.fadeAlpha(by: 1, duration: 0.25)
		let fadeOut = SKAction.fadeAlpha(to: 0, duration: 1)
		
		let showSequence = SKAction.sequence([fadeIn, fadeOut])
		scoreLabel?.run(showSequence)
	}
	
	func addScore(by score: Int) {
		currentScore += score
		scoreLabel?.text = "\(currentScore)"
	}
	
	func modifyScore() {
		if let hoop = hoop {
			hoop.enabled = false
			
			switch currentScore {
				
			case 0...4 :
				addScore(by: 1)
				scoreLabel?.text = "You could be doing something more productive"
				scoreLabel?.fontSize = 50
				
			case 4...9 :
				addScore(by: 1)
				hoop.moveLeftRight(in: 1.5)
				
			case 10:
				addScore(by: 1)
				hoop.removeAllActions()
				hoop.moveDiagonally(in: 1.5)
				
			case 9...19 :
				addScore(by: 1)
				
			case 19...:
				scoreLabel?.text = "You could be doing something more productive"
				scoreLabel?.fontSize = 50
				
			default:
				print("Macaroni code has started to taste bad!")
			}
		}
	}
	
	func didEnd(_ contact: SKPhysicsContact) {
		if contact.bodyA.contactTestBitMask == contact.bodyB.contactTestBitMask {
			guard hoop!.enabled else { return }
			modifyScore()
			showScore()
		}
	}
}
