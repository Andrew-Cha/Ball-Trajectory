//
//  GameScene.swift
//  Fizikos Metinis
//
//  Created by Andrius on 12/26/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	var player: Ball!
	var bottomBorder: BottomBorder!
	var cam: SKCameraNode!
	var draggingLine: DragLine!
	var trajectoryLine: TrajectoryLine!
	var hoop: SKNode?
	var isGame = false
	var loaded = false
	var throwStatsDelegate: ThrowStatsDisplay!
	var viewController: GameViewController!
	
	override func didMove(to view: SKView) {
		//instantly called after loading 
	}
	
	override func update(_ currentTime: TimeInterval) {
		if !loaded {
			if isGame {
				loadGame()
			} else {
				loadSimulation()
			}
			loaded = true
		}
		
		if !isGame {
			cam.position = player.position
		}
	}
	
	func loadGame() {
		player = Ball(in: self, resetPoint: CGPoint(x: 200, y: 24))
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self)
		trajectoryLine = TrajectoryLine(in: self)
		hoop = Basketball(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
		cam.setScale(2)
		cam.position = CGPoint(x: 0, y: 200)
		trajectoryLine.createDotsToStore()
		player.throwStatsDisplayDelegate = throwStatsDelegate
		viewController.ballButtonDelegate = player
		viewController.trajectoryButtonDelegate = trajectoryLine
		
	}
	
	func loadSimulation() {
		player = Ball(in: self, resetPoint: CGPoint(x: 0, y: 24))
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self)
		trajectoryLine = TrajectoryLine(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
		cam.setScale(2)
		trajectoryLine.createDotsToStore()
		player.throwStatsDisplayDelegate = throwStatsDelegate
		viewController.ballButtonDelegate = player
		viewController.trajectoryButtonDelegate = trajectoryLine
	}
}
