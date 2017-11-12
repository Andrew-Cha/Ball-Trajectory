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
	let gravity: CGFloat = 9.8
	let divisionMultiplier: CGFloat = 12.275
	let dotTexture = SKTexture(imageNamed: "whiteDot.png")
	var storedDots: [SKSpriteNode] = []
	let dotCount = 200
	//s(max) = velocity * cos(angle) * timeMax
	//s = velocity * cos(angle) * time
	//h = velocity * sin(angle) * time - (gravity*time^2) / 2
	//timeMax = (velocity * sin(angle) / gravity) * 2 because this is half of the time, this time is the maxTime to rise to the peak
	//100 points or for loops to make so the line looks nice
	
	init(in gameScene: GameScene) {
		super.init()
		self.gameScene = gameScene
		gameScene.addChild(self)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func createDotsToStore() {
		for _ in 1...Int(dotCount) {
			let newDot = SKSpriteNode(texture: dotTexture)
			storedDots.append(newDot)
		}
	}
	
	func displayDots() {
		for dot in storedDots {
			addChild(dot)
			dot.position = .zero
		}
	}
	
	func update(forOffset: CGVector) {
		let offset = forOffset / divisionMultiplier
		let maxTime = abs(offset.dy * 2) / gravity
		//let maxFlyDistance = velocity * cos(angle) * maxTime //to calculate landing point
		for iteration in 1...dotCount {
			let currentTime = maxTime * CGFloat(iteration) / CGFloat(dotCount)
			let x = offset.dx * currentTime
			let y = offset.dy * currentTime - gravity * currentTime * currentTime / 2
			let dot = storedDots[iteration - 1]
			dot.position = CGPoint(x: x, y: y)
		}
	}
	
	func remove() {
		removeAllChildren()
	}
}
