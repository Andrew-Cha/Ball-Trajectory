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
		zPosition = 1
		physicsBody = SKPhysicsBody(circleOfRadius: bodyRadius)
		physicsBody?.allowsRotation = true
		physicsBody?.mass = 1
		physicsBody?.linearDamping = 0
		physicsBody?.angularDamping = 1
		physicsBody?.friction = 1
		//physicsBody?.restitution = 0.8
		physicsBody?.isDynamic = false
		
		gameScene.addChild(self)
	}
	
	func resetPosition() {
		physicsBody?.isDynamic = false
		position = CGPoint(x: 0, y: 0)
		isUserInteractionEnabled = true
		gameScene.trajectoryLine.remove()
	}
	
	var initialLocation: CGPoint?
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			isUserInteractionEnabled = false
			initialLocation = touch.location(in: gameScene)
			angleForceDelegate?.createAngleForceLabels()
			gameScene.trajectoryLine.displayDots()
		}
	}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let currentLocation = touch.location(in: gameScene)
			if let initialLocation = initialLocation {
				gameScene.draggingLine.positionChanged(to: currentLocation)
				let offset = (initialLocation - currentLocation) * impulseScale
				let angle = offset.angle * 180 / .pi
				gameScene.trajectoryLine.update(forOffset: offset.asVector)
				angleForceDelegate?.angleForceAndPositionChanged(angle: angle, force: offset.length, position: currentLocation)
			}
		}
	}
	
	let impulseScale: CGFloat = 4.0
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		for touch in touches {
			let currentLocation = touch.location(in: gameScene)
			physicsBody?.isDynamic = true
			if let initialLocation = initialLocation {
				let offset = (initialLocation - currentLocation) * impulseScale
				physicsBody?.applyImpulse(offset.asVector * physicsBody!.mass)
				gameScene.trajectoryLine.update(forOffset: offset.asVector)
				gameScene.draggingLine.stopped()
				angleForceDelegate?.angleForceLabelsRemove()
				self.initialLocation = nil
			}
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
