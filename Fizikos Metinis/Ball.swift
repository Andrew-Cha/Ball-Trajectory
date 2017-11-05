//
//  Ball.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode, BallPosResetButton {
	static let texture = SKTexture(imageNamed: "ball.png")
	let bodyRadius: CGFloat
	weak var gameScene: GameScene!
	var angleForceDelegate: AngleAndForceLabel?
	
	init(in gameScene: GameScene) {
		self.gameScene = gameScene
		self.bodyRadius = Ball.texture.size().width / 2
		
		super.init(texture: Ball.texture, color: .clear, size: Ball.texture.size())
		isUserInteractionEnabled = true
		name = "player"
		position = position
		physicsBody = SKPhysicsBody(circleOfRadius: bodyRadius)
		physicsBody?.allowsRotation = true
		physicsBody?.mass = 0.2
		physicsBody?.restitution = 0.8
		physicsBody?.isDynamic = false
		
		gameScene.addChild(self)
	}
	
	func resetPosition() {
		physicsBody?.isDynamic = false
		position = CGPoint(x: 0, y: 0)
		isUserInteractionEnabled = true
	}
	
	var initialLocation: CGPoint?
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			isUserInteractionEnabled = false
			gameScene.camFollowingPlayer = false
			initialLocation = touch.location(in: gameScene)
			angleForceDelegate?.createAngleForceLabels()
			if let initialLocation = initialLocation {
				gameScene.draggingLine.dragStarted(at: initialLocation)
			}
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let currentLocation = touch.location(in: gameScene)
			position = currentLocation
			if let initialLocation = initialLocation {
				gameScene.draggingLine.positionChanged(to: currentLocation)
				let offset = initialLocation - currentLocation
				let angle = offset.angle * 180 / .pi
				angleForceDelegate?.angleForceAndPositionChanged(angle: angle, force: offset.length, position: currentLocation)
			}
		}
	}
	
	let impulseScale: CGFloat = 50
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let currentLocation = touch.location(in: gameScene)
			physicsBody?.isDynamic = true
			if let initialLocation = initialLocation {
				let offset = (initialLocation - currentLocation) * impulseScale
				physicsBody?.applyForce(offset.asVector)
				if position.x > 0 {
					gameScene.endingBallPositionIsPositive = true
				} else {
					gameScene.endingBallPositionIsPositive = false
				}
			}
			gameScene.draggingLine.stopped()
			angleForceDelegate?.angleForceLabelsRemove()
			initialLocation = nil
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

protocol BallPosResetButton {
	func resetPosition()
}

protocol AngleAndForceLabel {
	func createAngleForceLabels()
	func angleForceAndPositionChanged(angle: CGFloat, force: CGFloat, position: CGPoint)
	func angleForceLabelsRemove()
}
