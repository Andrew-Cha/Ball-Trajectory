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
	let divisionMultiplier: CGFloat = 12.2586
	let dotTexture = SKTexture(imageNamed: "whiteDot.png")
	var storedDots: [SKSpriteNode] = []
	let dotCount: CGFloat = 200
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
	
	func createDotsToStore() {
		for _ in 1...Int(dotCount) {
			let newDot = SKSpriteNode(texture: dotTexture)
			storedDots.append(newDot)
		}
	}
	
	func velocityAndAngleChanged(to offset: CGVector) {
		trajectoryLineRemove()
		let offset = offset / divisionMultiplier
		let maxTime = abs(offset.dy * 2) / gravity
		//let maxFlyDistance = velocity * cos(angle) * maxTime //to calculate landing point
		for iteration in 1...Int(dotCount) {
			let currentTime = maxTime * CGFloat(iteration) / dotCount
			let x = offset.dx * currentTime
			let y = offset.dy * currentTime - gravity * currentTime * currentTime / 2
			for dot in storedDots {
				dot.position = CGPoint(x: x, y: y)
				gameScene.addChild(dot)
			}
		}
	}
	
	func trajectoryLineRemove() {
		for dot in storedDots {
			dot.removeFromParent()
		}
	}
}
