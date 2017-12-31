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
		
		setupHoop(at: CGPoint(x: -300, y: 150))
	}
	
	func setupHoop(at position: CGPoint) {
		let leftHoopEdge = SKSpriteNode()
		leftHoopEdge.size = CGSize(width: 10, height: 10)
		leftHoopEdge.color = UIColor.orange
		
		let rightHoopEdge = SKSpriteNode()
		rightHoopEdge.size = CGSize(width: 10, height: 10)
		rightHoopEdge.color = UIColor.orange
	
		leftHoopEdge.position = CGPoint(x: position.x, y: position.y)
		rightHoopEdge.position = CGPoint(x: position.x + 80, y: position.y)
		
		leftHoopEdge.physicsBody = SKPhysicsBody(rectangleOf: leftHoopEdge.size)
		rightHoopEdge.physicsBody = SKPhysicsBody(rectangleOf: rightHoopEdge.size)

		leftHoopEdge.physicsBody?.isDynamic = false
		rightHoopEdge.physicsBody?.isDynamic = false
		
		gameScene.addChild(leftHoopEdge)
		gameScene.addChild(rightHoopEdge)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

