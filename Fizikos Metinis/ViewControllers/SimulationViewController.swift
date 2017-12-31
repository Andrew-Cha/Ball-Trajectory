import UIKit
import SpriteKit

class GameViewController: UIViewController, ThrowStatsDisplay {
	var ballButtonDelegate: BallPosResetButton?
	var trajectoryButtonDelegate: TrajectoryButton?
	@IBOutlet weak var forceLabel: UILabel!
	@IBOutlet weak var trajectoryButton: UIButton!
	@IBOutlet weak var angleLabel: UILabel!
	@IBOutlet weak var statsButton: UIButton!
	@IBOutlet var gameView: SKView!
	weak var gameScene: GameScene!
	var statsShown = true
	var isGame = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		if let view = self.view as? SKView {
			guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else { //instantly initializes the GameScene
				fatalError("Could not load scene!")
			}
			
			scene.isGame = isGame
			view.presentScene(scene)
			
			gameScene = view.scene as? GameScene
			gameScene.throwStatsDelegate = self
			gameScene.viewController = self
			
			if !isGame {
				trajectoryButton.isHidden = true
				statsButton.isHidden = true
			}
			
			view.showsFPS = true
			view.showsNodeCount = true
		}
	}
	
	@IBAction func ballButtonPressed() {
		ballButtonDelegate?.resetPosition()
	}
	
	@IBAction func statsButtonPress(_ sender: Any) {
		if statsShown {
			statsShown = false
			angleLabel.isHidden = true
			forceLabel.isHidden = true
		} else {
			statsShown = true
		}
	}
	
	@IBAction func trajectoryButtonPress(_ sender: Any) {
		trajectoryButtonDelegate?.show()
	}
	
	@IBAction func gameStart(_ sender: Any) {
		isGame = true
	}
	
	func throwStatsCreate() {
		if statsShown {
			angleLabel.isHidden = false
			angleLabel.text = ""
			forceLabel.isHidden = false
			forceLabel.text = ""
		}
	}
	
	func throwStatsUpdate(angle: CGFloat, force: CGFloat, position: CGPoint) {
		if statsShown {
			//if the labels are outside of the view make them be below the finger not above
			let convertedPosition = gameView.convert(position, from: gameScene)
			angleLabel.center = CGPoint(x: convertedPosition.x, y: convertedPosition.y - 70)
			forceLabel.center = CGPoint(x: convertedPosition.x, y: convertedPosition.y - 90)
			let numberFormatter = NumberFormatter()
			numberFormatter.numberStyle = .decimal
			numberFormatter.maximumFractionDigits = 2
			let newAngle = angle >= 0 ? angle : 360 + angle
			angleLabel.text = "\(numberFormatter.string(from: newAngle as NSNumber)!)°"
			forceLabel.text = "\(numberFormatter.string(from: force as NSNumber)!) Ns"
		}
	}
	
	func throwStatsRemove() {
		if statsShown {
			angleLabel.isHidden = true
			forceLabel.isHidden = true
		}
	}
	
	override var shouldAutorotate: Bool {
		return true
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		if UIDevice.current.userInterfaceIdiom == .phone {
			return .allButUpsideDown
		} else {
			return .all
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Release any cached data, images, etc that aren't in use.
	}
	
	override var prefersStatusBarHidden: Bool {
		return true
	}
}
