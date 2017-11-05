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
	var camFollowingPlayer = false
	var endingBallPositionIsPositive: Bool?
	
	override func sceneDidLoad() {
		player = Ball(in: self)
		bottomBorder = BottomBorder(in: self)
		draggingLine = DragLine(in: self)
		cam = SKCameraNode()
		scene?.camera = cam
	}
	
	override func update(_ currentTime: TimeInterval) {
		if camFollowingPlayer {
			if player.position.y >= -10 {
				cam.position = player.position
			} else {
				cam.position.x = player.position.x
			}
		} else {
			if let endingBallPositionIsPositive = endingBallPositionIsPositive {
				if endingBallPositionIsPositive {
					if player.position.x < 0 {
						camFollowingPlayer = true
						self.endingBallPositionIsPositive = nil
					}
				} else {
					if player.position.x > 0 {
						camFollowingPlayer = true
						self.endingBallPositionIsPositive = nil
					}
				}
			}
		}
	}
}
