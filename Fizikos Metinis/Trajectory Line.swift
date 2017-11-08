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
	
	let currentDragPath = UIBezierPath()
	func initialTrajectoryPositionReceived(at point: CGPoint) {
		currentDragPath.move(to: point)
	}
	
	func velocityAndAngleChanged(angle: CGFloat, velocity: CGFloat) {
		//var newAngle = angle >= 0 ? angle : 360 + angle
		//i need degrees, sub 90 or at 90.
		/*
		if newAngle > 90 {
			newAngle = newAngle - 90
		}
		
		if newAngle > 90 {
			newAngle = newAngle - 90
		}
		
		if newAngle > 90 {
			newAngle = newAngle - 90
		}
		print("Sumazintas iki 90 laipsniu ar maziau: \(newAngle)")
		*/
		let newAngle = angle
		let maxTime = (velocity * sin(newAngle) * 2) / gravity
		//let maxFlyDistance = velocity * cos(angle) * maxTime //to calculate landing point, nuo ten vel trajektorija piest is naujo
		for iteration in 1...100 {
			let currentTime = maxTime / CGFloat(iteration)
			
			let xAxis = velocity * cos(angle) * currentTime
			//ball rises
			if iteration <= 50 {
				let yAxisLeftSide = (velocity * sin(angle) * (currentTime / 2)) - ((gravity * (currentTime / 2) * (currentTime / 2)) / 2 )
				let newDot = SKSpriteNode(imageNamed: "ball.png")
				newDot.position = CGPoint(x: xAxis, y: yAxisLeftSide)
				gameScene.addChild(newDot)
				storedDots.append(newDot)
			} else {
				//ball falls
				let yAxisRightSide = (gravity * (currentTime / 2) * (currentTime / 2)) / 2
				let newDot = SKSpriteNode(imageNamed: "ball.png")
				newDot.position = CGPoint(x: xAxis, y: yAxisRightSide)
				gameScene.addChild(newDot)
				storedDots.append(newDot)
			}
		}
	}
	
	func velocityLineRemove() {
		for dot in storedDots {
			dot.removeFromParent()
			storedDots = []
		}
	}
}
