//
//  GameScene.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
	var player: Ball!
	var bottomBorder: BottomBorder!
	var cam: SKCameraNode!
	var draggingLine: DragLine!
	var trajectoryLine: TrajectoryLine!

	override func sceneDidLoad() {
		player = Ball(in: self)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self)
		trajectoryLine = TrajectoryLine(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
	}
	
	override func update(_ currentTime: TimeInterval) {
			if player.position.y >= -10 {
				cam.position = player.position
			} else {
				cam.position.x = player.position.x
		}
	}
}
