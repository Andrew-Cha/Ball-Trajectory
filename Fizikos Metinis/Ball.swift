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
	
	var totalDragDistance: CGVector?
	var initialPosition: CGPoint?
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			initialPosition = touch.location(in: gameScene)
			angleForceDelegate?.createAngleForceLabels()
			if let initialPosition = initialPosition {
				gameScene.draggingLine.dragStarted(at: initialPosition)
				print("Touch Start Works")
			}
		}
	}
	
	var currentLocation: CGPoint?
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			currentLocation = touch.location(in: gameScene)
			if let initialPosition = initialPosition, let currentLocation = currentLocation {
				print("Touch moved works")
				gameScene.draggingLine.positionChanged(to: currentLocation)
				
				totalDragDistance = CGVector(dx: (initialPosition.x - currentLocation.x), dy: (initialPosition.y - currentLocation.y))
				let height = CGPoint(x: 0, y: currentLocation.y)
				let cosValue = hypot(height.x, height.y) / hypot(currentLocation.x, currentLocation.y)
				let angle = (acos(cosValue) * 180 / CGFloat.pi)
				angleForceDelegate?.angleForceAndPositionChanged(angle: angle, force: 420, position: currentLocation)
			}
		}
	}
	
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for _ in touches {
			print("Touch ended works")
			physicsBody?.isDynamic = true
			if let initialPosition  = initialPosition, let totalDragDistance = totalDragDistance {
				physicsBody?.applyForce(totalDragDistance, at: initialPosition)
			}
			gameScene.draggingLine.stopped()
			angleForceDelegate?.angleForceLabelsRemove()
			initialPosition = nil
			currentLocation = nil
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
	func angleForceAndPositionChanged(angle: CGFloat, force: Double, position: CGPoint)
	func angleForceLabelsRemove()
}
