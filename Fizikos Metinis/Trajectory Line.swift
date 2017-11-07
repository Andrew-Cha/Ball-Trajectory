//
//  Trajectory Line.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/6/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import SpriteKit

class TrajectoryLine: SKShapeNode {
	var dashedLine = SKShapeNode()
	var gameScene: GameScene!
	var initialPosition: CGPoint?
	
	//s(max) = velocity * cos(angle) * timeMax
	 //s = velocity * cos(angle) * time
	//h = velocity * sin(angle) * time - (gravity*time^2) / 2
   //timeMax = (velocity * sin(angle) / gravity) * 2 because this is half of the time, this time is the maxTime to rise to the peak
	 //100 points or for loops to make so the line looks nice
	
	init(in gameScene: GameScene) {
		super.init()
		self.gameScene = gameScene
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	let currentDragPath = UIBezierPath()
	func initialTrajectoryPositionReceived(at point: CGPoint) {
		currentDragPath.move(to: point)
	}
	
	func velocityAndAngleChanged(angle: CGFloat, velocity: CGFloat) {
		dashedLine.removeFromParent()
		let gravity = gameScene.physicsWorld.gravity
		let maxTime = (velocity * sin(angle) / gravity.dy) * 2
		let maxFlyDistance = velocity * cos(angle) * maxTime //to calculate landing point, nuo ten vel trajektorija piest is naujo
		for iteration in 1...10 {
			let currentTime = maxTime / CGFloat(iteration) * 2
			let flyDistanceAtCertainTimeYAxis = velocity * cos(angle) * currentTime
			let breakUp1 = velocity * sin(angle) * currentTime
			let breakUp2 = (gravity.dy * currentTime * currentTime) / 2
			let flyDistanceAtCertainTimeXAxis =  breakUp1 - breakUp2
			currentDragPath.addLine(to: CGPoint(x: flyDistanceAtCertainTimeXAxis, y: flyDistanceAtCertainTimeYAxis))
		}
		let dashed = currentDragPath.cgPath.copy(dashingWithPhase: 10, lengths: [5])
		dashedLine = SKShapeNode(path: dashed)
		gameScene.addChild(dashedLine)
	}
	
	func velocityLineRemove() {
		dashedLine.removeFromParent()
	}
}
