
import Foundation
import SpriteKit
import SwiftUI

var musicPour = Music(name: "pouring", format: ".mp3")

class GameScene: SKScene {
    private let liquid = SKSpriteNode(imageNamed: "liquidBlue")
    private let erlenmeyer = SKSpriteNode(imageNamed: "erlenmeyer")
    private let erlenmeyerMask = SKSpriteNode(imageNamed: "erlenmeyerMask")
    
    private var selected: SKSpriteNode?
    private var selectedJar: SKSpriteNode?
    
    private var returnPosition: CGPoint!
    private var background = SKSpriteNode(imageNamed: "backgroundBlue")
    
    private var beckers: [SKSpriteNode] = []
    private var jars: [SKSpriteNode] = []
    
    
    override func didMove(to view: SKView) {
        let crop = SKCropNode()
        crop.maskNode = erlenmeyerMask
        crop.position = CGPoint(x: frame.midX, y: frame.midY * 1.1 )
        crop.setScale(0.5)
        crop.addChild(liquid)
        addChild(crop)
        
        Array(1...6)
            .map { String($0) }
            .forEach {
                let node = SKSpriteNode(imageNamed: "jar" + $0)
                node.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)
                node.alpha = 0
                node.setScale(0.5)
                addChild(node)
                jars.append(node)
            }
        
        beckers = [
            CGPoint(x: frame.maxX * 0.25, y: frame.maxY * 0.1),
            CGPoint(x: frame.maxX * 0.5, y: frame.maxY * 0.1),
            CGPoint(x: frame.maxX * 0.75, y: frame.maxY * 0.1),
            CGPoint(x: frame.maxX * 0.25, y: frame.maxY * 0.25),
            CGPoint(x: frame.maxX * 0.5, y: frame.maxY * 0.25),
            CGPoint(x: frame.maxX * 0.75, y: frame.maxY * 0.25),
        ]
            .enumerated()
            .map { (index, position) in
                let node = SKSpriteNode(imageNamed: "becker" + String(index + 1))
                node.setScale(0.55)
                node.position = position
                addChild(node)
                return node
            }
        
        setupLiquid()
        setupBackground()
        setupErlenmeryer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            selectedJar?.alpha = 0
            guard let selectedBeckerIndex = beckers.firstIndex(where: { $0.contains(position) && $0.parent != nil })
            else { return }
            
            let selectedBecker = beckers[selectedBeckerIndex]
            let jar = jars[selectedBeckerIndex]
            
            returnPosition = selectedBecker.position
            selected = selectedBecker
            selectedJar = jar
            selectedBecker.isHidden = false
            jar.run(SKAction.fadeIn(withDuration: 0.1))
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if selected != nil{
                selected?.position = position
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            
            if selected != nil  {
                if erlenmeyer.contains(position) && touch.tapCount < 1 {
                    selected?.removeFromParent()
                    liquid.run(SKAction.moveBy(x: 0, y: liquid.size.height / 6, duration: 1))
                    musicPour.playOnce()
                    musicPour.setVolume(volume: 0.7)
                    
                }else{
                    selected?.run(SKAction.move(to: returnPosition, duration: 0.5))
                }
                
            }
            selected = nil
            
            if beckers.allSatisfy { $0.parent == nil } {
                NotificationCenter.default.post(name: .init(rawValue: "acaboumix"), object: nil)
            }
            
        }
    }
    
    func setupLiquid(){
        liquid.position = CGPoint(x: 0, y: -(erlenmeyerMask.size.height * 0.5 + liquid.size.height * 0.5))
    }
    func setupErlenmeryer(){
        erlenmeyer.position = CGPoint(x: frame.midX, y: frame.midY  * 1.1)
        erlenmeyer.setScale(0.5)
        addChild(erlenmeyer)
    }
    
    func setupBackground(){
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(background)
    }
}




struct Mix: View {
    @State
    private var isShowingBlur = true
    //
    //    var scene: SKScene {
    //        let scene = GameScene()
    //        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    //        scene.scaleMode = .fill
    //        return scene
    //
    //    }
    @State
    private var scene: GameScene = {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = GameScene()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        //scene.backgroundColor = .white
        return scene
    }()
    
    
    //@State  var dragOffset = CGSize.zero
    @State
    private var isNavigationLinkActive = false
    
    @State
    private var isShowingButton = false
    
    var body: some View {
        ZStack{
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            if isShowingBlur {
                ZStack{
                    Image("instru2")
                        .scaleEffect(0.5)
                        .onTapGesture {
                            isShowingBlur = false
                        }
                }
            }
            
            if isShowingButton {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        NavigationLink(destination: Shake()){
                            Image("nextButton")
                                .padding(.trailing, 40)
                                .padding(.bottom, 40)
                        }
                        //}
                    }
                }
                
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .init(rawValue: "acaboumix"))) { _scene in
            isShowingButton = true
        }
    }
}

//struct Mix_Previews: PreviewProvider{
//    static var previews: some View {
//        Mix()
//    }
//}

