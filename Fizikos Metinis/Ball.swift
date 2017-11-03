//
//  Ball.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKSpriteNode, BallPosResetButtonDelegate {
	static let texture = SKTexture(imageNamed: "ball.png")
	let bodyRadius: CGFloat
	weak var gameScene: GameScene!
	var angleForceDelegate: AngleAndForceLabelProtocol?
	
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
	
	var totalDragDistance = CGVector(dx: 0, dy: 0)
	var initialPosition = CGPoint(x: 0, y: 0)
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
			angleForceDelegate?.createAngleForceLabelsCreate()
	}
	
	var currentLocation = CGPoint(x: 0, y: 0)
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			currentLocation = touch.location(in: gameScene)
			gameScene.draggingLine.positionChanged(to: currentLocation)
			totalDragDistance = CGVector(dx: (initialPosition.x - endingPosition.x), dy: (initialPosition.y - endingPosition.y))
			let height = CGPoint(x: 0, y: currentLocation.y)
			let cosValue = hypot(height.x, height.y) / hypot(currentLocation.x, currentLocation.y)
			let angle = (acos(cosValue) * 180 / CGFloat.pi)
			angleForceDelegate?.angleChanged(to: angle)
		}
	}
	
	var endingPosition = CGPoint(x: 0, y: 0)
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			endingPosition = touch.location(in: gameScene)
			physicsBody?.isDynamic = true
			physicsBody?.applyImpulse(totalDragDistance)
			
			gameScene.draggingLine.stopped()
			angleForceDelegate?.angleForceLabelsRemove()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

protocol BallPosResetButtonDelegate {
	func resetPosition()
}

protocol AngleAndForceLabelProtocol {
	func createAngleForceLabelsCreate()
	func angleChanged(to angle: CGFloat)
	func forceChanged(to force: Double)
	func angleForceLabelsRemove()
}
