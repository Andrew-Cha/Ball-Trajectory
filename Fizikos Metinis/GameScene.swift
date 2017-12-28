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
	
	init(isGame: Bool) {
		super.init()
		
		if isGame {
			loadGame()
		} else {
			loadSimulation()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func didMove(to view: SKView) {
		
	}
	
	override func update(_ currentTime: TimeInterval) {
		if player.position.y >= -750 {
			cam.position = player.position
		} else {
			cam.position.x = player.position.x
		}
	}
	
	func loadGame() {
		player = Ball(in: self)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self)
		trajectoryLine = TrajectoryLine(in: self)
		hoop = Basketball(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
		trajectoryLine.createDotsToStore()
	}
	
	func loadSimulation() {
		player = Ball(in: self)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self)
		trajectoryLine = TrajectoryLine(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
		trajectoryLine.createDotsToStore()
	}
}
