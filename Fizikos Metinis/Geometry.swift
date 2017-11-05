//
//  Geometry.swift
//  Starver
//
//  Created by Julian Dunskus on 02.10.17.
//  Copyright © 2017 Andrius. All rights reserved.
//

import CoreGraphics

protocol Vector2 {
	var x: CGFloat { get set }
	var y: CGFloat { get set }
	
	init(x: CGFloat, y: CGFloat)
	
	var asVector: CGVector { get }
	var asPoint: CGPoint { get }
	var asSize: CGSize { get }
	
	var length: CGFloat { get }
	var angle: CGFloat { get }
	
	func clamped(to length: CGFloat) -> Self
	
	static func += <V: Vector2>(lhs: inout Self, rhs: V)
	static func -= <V: Vector2>(lhs: inout Self, rhs: V)
	static func *= (vec: inout Self, scale: CGFloat)
	static func /= (vec: inout Self, scale: CGFloat)
	
	static prefix func - (vec: Self) -> Self
	
	static func + <V: Vector2>(lhs: Self, rhs: V) -> Self
	static func - <V: Vector2>(lhs: Self, rhs: V) -> Self
	static func * (vec: Self, scale: CGFloat) -> Self
	static func * (scale: CGFloat, vec: Self) -> Self
	static func / (vec: Self, scale: CGFloat) -> Self
}

extension Vector2 {
	var asVector: CGVector {
		return CGVector(dx: x, dy: y)
	}
	
	var asPoint: CGPoint {
		return CGPoint(x: x, y: y)
	}
	
	var asSize: CGSize {
		return CGSize(width: x, height: y)
	}
	
	var length: CGFloat {
		return hypot(x, y)
	}
	
	var angle: CGFloat {
		return atan2(y, x)
	}
	
	func clamped(to length: CGFloat) -> Self {
		let len = self.length
		
		if len > length {
			return self * (length / len)
		}
		return self
	}
	
	static func += <V: Vector2>(lhs: inout Self, rhs: V) {
		lhs.x += rhs.x
		lhs.y += rhs.y
	}
	
	static func -= <V: Vector2>(lhs: inout Self, rhs: V) {
		lhs.x -= rhs.x
		lhs.y -= rhs.y
	}
	
	static func *= (vec: inout Self, scale: CGFloat) {
		vec.x *= scale
		vec.y *= scale
	}
	
	static func /= (vec: inout Self, scale: CGFloat) {
		vec.x /= scale
		vec.y /= scale
	}
	
	static func + <V: Vector2>(lhs: Self, rhs: V) -> Self {
		return Self(x: lhs.x + rhs.x,
		            y: lhs.y + rhs.y)
	}
	
	static func - <V: Vector2>(lhs: Self, rhs: V) -> Self {
		return Self(x: lhs.x - rhs.x,
		            y: lhs.y - rhs.y)
	}
	
	static func * (vec: Self, scale: CGFloat) -> Self {
		return Self(x: vec.x * scale,
		            y: vec.y * scale)
	}
	
	static func * (scale: CGFloat, vec: Self) -> Self {
		return Self(x: vec.x * scale,
		            y: vec.y * scale)
	}
	
	static func / (vec: Self, scale: CGFloat) -> Self {
		return Self(x: vec.x / scale,
		            y: vec.y / scale)
	}
	
	static prefix func - (vec: Self) -> Self {
		return Self(x: -vec.x,
		            y: -vec.y)
	}
}

extension CGPoint: Vector2 {}

extension CGVector: Vector2 {
	var x: CGFloat {
		get { return dx }
		set { dx = newValue }
	}
	
	var y: CGFloat {
		get { return dy }
		set { dy = newValue }
	}
	
	init(x: CGFloat, y: CGFloat) {
		dx = x
		dy = y
	}
}

extension CGSize: Vector2 {
	var x: CGFloat {
		get { return width }
		set { width = newValue }
	}
	
	var y: CGFloat {
		get { return height }
		set { height = newValue }
	}
	
	init(x: CGFloat, y: CGFloat) {
		width = x
		height = y
	}
}
