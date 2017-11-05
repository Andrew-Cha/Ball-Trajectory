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
	}
	
	var initialPosition: CGPoint?
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			gameScene.camFollowingPlayer = false
			initialPosition = touch.location(in: gameScene)
			angleForceDelegate?.createAngleForceLabels()
			if let initialPosition = initialPosition {
				gameScene.draggingLine.dragStarted(at: initialPosition)
				let someAction = SKAction.falloff(to: 10, duration: 10)
				run(someAction)
			}
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let currentLocation = touch.location(in: gameScene)
			position = currentLocation
			if let initialPosition = initialPosition {
				gameScene.draggingLine.positionChanged(to: currentLocation)
				
				let totalDragDistance = (initialPosition - currentLocation) * 4
				let angle = currentLocation.angle * 180 / .pi
				angleForceDelegate?.angleForceAndPositionChanged(angle: angle, force: totalDragDistance.length, position: currentLocation)
			}
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let currentLocation = touch.location(in: gameScene)
			physicsBody?.isDynamic = true
			if let initialPosition = initialPosition {
				let totalDragDistance = (initialPosition - currentLocation) * 4
				physicsBody?.applyForce(totalDragDistance.asVector)
				gameScene.camFollowingPlayer = true
			}
			gameScene.draggingLine.stopped()
			angleForceDelegate?.angleForceLabelsRemove()
			initialPosition = nil
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
