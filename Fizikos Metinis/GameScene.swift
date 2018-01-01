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
	var bottomBorder: BottomBorder!
	var cam: SKCameraNode!
	var draggingLine: DragLine!
	var trajectoryLine: TrajectoryLine!
	var hoop: SKNode?
	var isGame = false
	var viewController: GameViewController!
	
	override func didMove(to view: SKView) {
		if isGame {
			loadGame()
			 self.physicsWorld.contactDelegate = self
		} else {
			loadSimulation()
		}
	}
	
	override func update(_ currentTime: TimeInterval) {
		if !isGame {
			cam.position = player.position
		}
		
		if isGame {
			if player.position.y < 30 {
				player.resetPosition()
			}
		}
	}
	
	func loadGame() {
		let ballPoint = CGPoint(x: 100, y: 224)
		player = Ball(in: self, resetPoint: ballPoint)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self, initialPosition: ballPoint)
		trajectoryLine = TrajectoryLine(in: self, ballPoint: ballPoint)
		hoop = Basketball(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
		cam.setScale(2)
		cam.position = CGPoint(x: 0, y: 200)
		trajectoryLine.createDotsToStore()
		player.throwStatsDisplayDelegate = viewController
		viewController.ballButtonDelegate = player
		viewController.trajectoryButtonDelegate = trajectoryLine
	}
	
	func loadSimulation() {
		let ballPoint = CGPoint(x: 0, y: 24)
		player = Ball(in: self, resetPoint: ballPoint)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self, initialPosition: ballPoint)
		trajectoryLine = TrajectoryLine(in: self, ballPoint: ballPoint)
		cam = SKCameraNode()
		scene?.camera = cam
		cam.setScale(2)
		trajectoryLine.createDotsToStore()
		player.throwStatsDisplayDelegate = viewController
		viewController.ballButtonDelegate = player
		viewController.trajectoryButtonDelegate = trajectoryLine
	}
	
	func didBegin(_ contact: SKPhysicsContact) {
		if contact.bodyA.contactTestBitMask == contact.bodyB.contactTestBitMask {
			viewController.addScore()
		}
	}
}
