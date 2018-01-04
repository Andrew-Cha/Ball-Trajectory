//
//  Hoop.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/18/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import SpriteKit

class Basketball: SKNode {
	weak var gameScene: GameScene!
	var leftHoopEdge = SKSpriteNode()
	var rightHoopEdge = SKSpriteNode()
	var pole = SKSpriteNode()
	var net = SKSpriteNode()
	var sensor = SKSpriteNode()
	let startingPosition: CGPoint
	var enabled = true
	
	init(in gameScene: GameScene, at position: CGPoint) {
		self.startingPosition = position
		self.gameScene = gameScene
		
		super.init()
		
		setupHoop(at: startingPosition)
		gameScene.addChild(self)
	}
	
	func setupHoop(at position: CGPoint) {
		pole.size = CGSize(width: 10, height: 300)
		pole.color = UIColor.orange
		
		leftHoopEdge.size = CGSize(width: 10, height: 10)
		leftHoopEdge.color = UIColor.orange
		
		rightHoopEdge.size = CGSize(width: 10, height: 10)
		rightHoopEdge.color = UIColor.orange
		
		leftHoopEdge.position = CGPoint(x: position.x, y: position.y)
		rightHoopEdge.position = CGPoint(x: position.x + 80, y: position.y)
		pole.position = CGPoint(x: position.x - 3, y: position.y - 71)
		
		leftHoopEdge.physicsBody = SKPhysicsBody(rectangleOf: leftHoopEdge.size)
		rightHoopEdge.physicsBody = SKPhysicsBody(rectangleOf: rightHoopEdge.size)
		pole.physicsBody = SKPhysicsBody(rectangleOf: pole.size)
		
		leftHoopEdge.physicsBody?.isDynamic = false
		rightHoopEdge.physicsBody?.isDynamic = false
		pole.physicsBody?.isDynamic = false
		
		addChild(pole)
		addChild(leftHoopEdge)
		addChild(rightHoopEdge)
		
		net.size = CGSize(width: 70, height: 10)
		net.position = CGPoint(x: position.x + 40, y: position.y)
		net.physicsBody = SKPhysicsBody(rectangleOf: net.size)
		net.physicsBody?.isDynamic = false
		net.physicsBody?.categoryBitMask = 0
		net.physicsBody?.collisionBitMask = 0
		net.color = UIColor.white
		net.zPosition = 1
		
		sensor.size = CGSize(width: 10, height: 1)
		sensor.position = CGPoint(x: position.x + 30, y: position.y - 20)
		sensor.physicsBody = SKPhysicsBody(rectangleOf: sensor.size)
		sensor.physicsBody?.isDynamic = false
		sensor.physicsBody?.categoryBitMask = 0
		sensor.physicsBody?.collisionBitMask = 0
		sensor.physicsBody?.contactTestBitMask = 1
		
		addChild(net)
		addChild(sensor)
	}
	
	func moveLeftRight(in seconds: Double) {
		if !hasActions() {
			let moveRight = SKAction.moveBy(x: 200, y: 0, duration: seconds)
			let moveLeft = SKAction.moveBy(x: -200, y: 0, duration: seconds)
			let moveBackAndForth = SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft]))
			
			run(moveBackAndForth)
		}
	}
	
	func moveDiagonally(in seconds: Double) {
		if !hasActions() {
			let moveTopLeft = SKAction.move(to: CGPoint(x: startingPosition.x + 300, y: startingPosition.y), duration: seconds)
			let moveBottomRight = SKAction.move(to: CGPoint(x: startingPosition.x + 450, y: 0), duration: seconds)
			let moveBackAndForth = SKAction.repeatForever(SKAction.sequence([moveTopLeft, moveBottomRight]))
			
			run(moveBackAndForth)
			
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

