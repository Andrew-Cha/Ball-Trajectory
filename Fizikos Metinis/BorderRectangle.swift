//
//  BorderRectangle.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/1/17.
//  Copyright © 2017 Andrius. All rights reserved.
//
import Foundation
import SpriteKit

class BottomBorder: SKSpriteNode {
	static let texture = SKTexture()
	weak var gameScene: GameScene!
	
	init(in gameScene: GameScene) {
		self.gameScene = gameScene
		
		super.init(texture: BottomBorder.texture, color: .clear, size: CGSize(width: 9005000, height: 5))
		physicsBody = SKPhysicsBody(rectangleOf: size)
		physicsBody?.isDynamic = false
		position = CGPoint(x: 0, y: -375)
		gameScene.addChild(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
