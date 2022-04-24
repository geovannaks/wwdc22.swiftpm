import Foundation
import SpriteKit
import SwiftUI
import CoreMotion
import UIKit

class GameScene1: SKScene {
    private let motionManager = CMMotionManager()
    private let imageNode = SKSpriteNode(imageNamed: "corona")
    
    
    override func didMove(to view: SKView) {
        print("didMove")
        motionManager.startAccelerometerUpdates()
        
        self.scaleMode = .aspectFit
    
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        
        imageNode.position = CGPoint(x: frame.midX, y: frame.midY)
        imageNode.size = CGSize(width: 100, height: 120)
        self.addChild(imageNode)
        
        imageNode.physicsBody = SKPhysicsBody(circleOfRadius: imageNode.size.width / 2)
        imageNode.physicsBody?.allowsRotation = true
        imageNode.physicsBody?.restitution = 0.5
        //imageNode.physicsBody?.affectedByGravity = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        if let accelerometerData = motionManager.accelerometerData {
            physicsWorld.gravity = CGVector(dx: accelerometerData.acceleration.x * 100, dy: accelerometerData.acceleration.y * 100)
        }
    }
}


struct Accelerometer: View {
    var scene: SKScene {
        let scene = GameScene1()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .aspectFit
        return scene
        
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
        
    }
    
}


struct Accelerometer_Previews: PreviewProvider{
    static var previews: some View{
        Accelerometer()
    }
}
