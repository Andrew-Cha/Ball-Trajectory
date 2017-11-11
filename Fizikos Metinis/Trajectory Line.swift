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
	var dashedLine: SKShapeNode?
	var gameScene: GameScene!
	var initialPosition: CGPoint?
	let gravity: CGFloat = 9.8
	let pixelsToMeters: CGFloat = 50
	var storedDots: [SKSpriteNode] = []
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
	
	func initialTrajectoryPositionReceived(at point: CGPoint) {
		
	}
	
	func velocityAndAngleChanged(to offset: CGVector) {
		trajectoryLineRemove()
		//var newAngle = angle >= 0 ? angle : 360 + angle
		
		let maxTime = (offset.dy * 2) / gravity
		//let maxFlyDistance = velocity * cos(angle) * maxTime //to calculate landing point, nuo ten vel trajektorija piest is naujo
		for iteration in 1...100 {
			let currentTime = maxTime * CGFloat(iteration) / 100.0
			print("the current velocity in trajectory line is \(offset)o")
			let xAxis = offset.dx * currentTime
			//ball rises
			//if iteration <= 50 {
				let yAxisLeftSide = offset.dy * currentTime - gravity * currentTime  * currentTime / 2
				let newDot = SKSpriteNode(imageNamed: "ball.png")
				newDot.position = CGPoint(x: xAxis, y: yAxisLeftSide)
				gameScene.addChild(newDot)
				storedDots.append(newDot)
		//	} else {
				//ball falls
			//	let yAxisRightSide = (gravity * (currentTime / 2) * (currentTime / 2)) / 2
			//	let newDot = SKSpriteNode(imageNamed: "ball.png")
			//	newDot.position = CGPoint(x: xAxis, y: yAxisRightSide)
			//	gameScene.addChild(newDot)
			//	storedDots.append(newDot)
		//	}
		}
	}
	
	func trajectoryLineRemove() {
		for dot in storedDots {
			dot.removeFromParent()
			storedDots = []
		}
	}
}
