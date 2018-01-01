//
//  Trajectory Line.swift
//  Fizikos Metinis
//
//  Created by Andrius on 11/6/17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import Foundation
import SpriteKit

class TrajectoryLine: SKShapeNode, TrajectoryButton {
	var dashedLine: SKShapeNode?
	weak var gameScene: GameScene!
	let gravity: CGFloat = 9.8
	let divisionMultiplier: CGFloat = 12.275
	let dotTexture = SKTexture(imageNamed: "whiteDot.png")
	var storedDots: [SKSpriteNode] = []
	let dotCount = 200
	var shown = true
	var ballPoint: CGPoint!
	
	init(in gameScene: GameScene, ballPoint: CGPoint) {
		self.ballPoint = ballPoint
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
		if shown {
			for dot in storedDots {
				addChild(dot)
				dot.position = .zero
			}
		}
	}
	
	func update(forOffset: CGVector) {
		if shown {
			let offset = forOffset / divisionMultiplier
			let maxTime = abs(offset.dy * 2) / gravity
			//let maxFlyDistance = velocity * cos(angle) * maxTime //to calculate landing point
			for iteration in 1...dotCount {
				let currentTime = maxTime * CGFloat(iteration) / CGFloat(dotCount)
				let x = offset.dx * currentTime + ballPoint.x
				let y = offset.dy * currentTime - gravity * currentTime * currentTime / 2 + ballPoint.y
				let dot = storedDots[iteration - 1]
				dot.position = CGPoint(x: x, y: y)
			}
		}
	}
	
	func show() {
		if shown {
			shown = false
			remove()
		} else {
			shown = true
		}
	}
	
	func remove() {
		removeAllChildren()
	}
}

protocol TrajectoryButton: class {
	func show()
}
