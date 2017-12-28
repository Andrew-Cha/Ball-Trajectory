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
	
	init(in gameScene: GameScene) {
		self.gameScene = gameScene
		super.init()
		
		setupHoop(at: CGPoint(x: -300, y: 0))
	}
	
	func setupHoop(at position: CGPoint) {
		let leftHoopEdge = SKSpriteNode()
		leftHoopEdge.size = CGSize(width: 10, height: 10)
		leftHoopEdge.color = UIColor.black
		
		let rightHoopEdge = SKSpriteNode()
		rightHoopEdge.size = CGSize(width: 10, height: 10)
		rightHoopEdge.color = UIColor.black
		
		let pole = SKSpriteNode()
		pole.size = CGSize(width: 15, height: 400)
		pole.color = UIColor.black
		
		pole.position = CGPoint(x: position.x - 6, y: position.y + (pole.size.height / 2))
		leftHoopEdge.position = CGPoint(x: position.x + 2, y: position.y + (pole.size.height / 4.25 * 3))
		rightHoopEdge.position = CGPoint(x: position.x + 80, y: position.y + (pole.size.height / 4.25 * 3))
		
		pole.physicsBody = SKPhysicsBody(rectangleOf: pole.size)
		leftHoopEdge.physicsBody = SKPhysicsBody(rectangleOf: leftHoopEdge.size)
		rightHoopEdge.physicsBody = SKPhysicsBody(rectangleOf: rightHoopEdge.size)
		
		pole.physicsBody?.isDynamic = false
		leftHoopEdge.physicsBody?.isDynamic = false
		rightHoopEdge.physicsBody?.isDynamic = false
		
		gameScene.addChild(pole)
		gameScene.addChild(leftHoopEdge)
		gameScene.addChild(rightHoopEdge)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

