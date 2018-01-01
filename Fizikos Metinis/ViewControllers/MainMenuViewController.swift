//
//  MainMenuViewController.swift
//  Fizikos Metinis
//
//  Created by Andrius on 1/1/18.
//  Copyright © 2018 Andrius. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "gameStarted" {
			if let destination = segue.destination as? GameViewController {
				destination.isGame = true
			}
		}
	}
}
