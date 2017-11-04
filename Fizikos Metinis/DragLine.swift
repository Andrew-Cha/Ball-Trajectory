//
//  DragLine.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/3/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import SpriteKit

class DragLine: SKShapeNode {
	var dashedLine = SKShapeNode()
	var gameScene: GameScene!
	var initialPosition: CGPoint?
	
	init(in gameScene: GameScene) {
		super.init()
		self.gameScene = gameScene
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func dragStarted(at position: CGPoint) {
		initialPosition = position
	}
	
	func positionChanged(to currentPosition: CGPoint) {
		dashedLine.removeFromParent()
		let currentDragPath = UIBezierPath()
		currentDragPath.move(to: initialPosition!)
		currentDragPath.addLine(to: currentPosition)
		let dashed = currentDragPath.cgPath.copy(dashingWithPhase: 10, lengths: [5])
		dashedLine = SKShapeNode(path: dashed)
		gameScene.addChild(dashedLine)
		
	}
	
	func stopped() {
		dashedLine.removeFromParent()
		initialPosition = nil
	}
}
