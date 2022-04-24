
import Foundation
import SpriteKit
import SwiftUI



class GameScene: SKScene {
    private let liquid = SKSpriteNode(imageNamed: "liquidBlue")
    private let erlenmeyer = SKSpriteNode(imageNamed: "erlenmeyer")
    private let erlenmeyerMask = SKSpriteNode(imageNamed: "erlenmeyerMask")
    private let becker1 = SKSpriteNode(imageNamed: "becker1")
    private let becker2 = SKSpriteNode(imageNamed: "becker2")
    private let becker3 = SKSpriteNode(imageNamed: "becker3")
    private let becker4 = SKSpriteNode(imageNamed: "becker4")
    private let becker5 = SKSpriteNode(imageNamed: "becker5")
    private let becker6 = SKSpriteNode(imageNamed: "becker6")
    private var selected: SKSpriteNode?
    private var returnPosition: CGPoint!
    private var background = SKSpriteNode(imageNamed: "backgroundBlue")
    private var jar1 = SKSpriteNode(imageNamed: "jar1")
    private var jar2 = SKSpriteNode(imageNamed: "jar2")
    private var jar3 = SKSpriteNode(imageNamed: "jar3")
    private var jar4 = SKSpriteNode(imageNamed: "jar4")
    private var jar5 = SKSpriteNode(imageNamed: "jar5")
    private var jar6 = SKSpriteNode(imageNamed: "jar6")
    
    func setupJar1(){
        jar1.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)

        addChild(jar1)
    }
    func setupJar2(){
        jar2.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)
        addChild(jar2)
    }

    func setupJar3(){
        jar3.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)
        addChild(jar3)
    }

    func setupJar4(){
        jar4.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)
        addChild(jar4)
    }

    func setupJar5(){
        jar5.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)
        addChild(jar5)
    }

    func setupJar6(){
        jar6.position = CGPoint(x: frame.midX, y: frame.midY  * 1.7)
        addChild(jar6)
    }
     
    
    
    override func didMove(to view: SKView) {
        let crop = SKCropNode()
        crop.maskNode = erlenmeyerMask
        crop.position = CGPoint(x: frame.midX, y: frame.midY * 1.1 )
        crop.setScale(0.7)
        crop.addChild(liquid)
        addChild(crop)
        
        
        
        setupLiquid()
        setupBackground()
        setupErlenmeryer()
        setupBecker1()
        setupBecker2()
        setupBecker3()
        setupBecker4()
        setupBecker5()
        setupBecker6()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            if becker1.contains(position){
                returnPosition = becker1.position
                selected = becker1
                setupJar1()
                jar1.run(SKAction.fadeIn(withDuration: 0.1))
             
            } else if becker2.contains(position){
                returnPosition = becker2.position
                selected = becker2
                setupJar2()
                
                jar2.run(SKAction.fadeIn(withDuration: 0.1))
                
              
            }else if becker3.contains(position){
                returnPosition = becker3.position
                selected = becker3
                setupJar3()
                
                jar3.run(SKAction.fadeIn(withDuration: 0.1))
                
             
            }else if becker4.contains(position){
                returnPosition = becker4.position
                selected = becker4
                setupJar4()
                jar4.run(SKAction.fadeIn(withDuration: 0.1))
              
            }else if becker5.contains(position){
                returnPosition = becker5.position
                selected = becker5
                setupJar5()
                jar5.run(SKAction.fadeIn(withDuration: 0.1))
                
       
            }else if becker6.contains(position){
                returnPosition = becker6.position
                selected = becker6
                setupJar6()
                jar6.run(SKAction.fadeIn(withDuration: 0.1))
//                jar2.run(SKAction.fadeOut(withDuration: 0.1))
//                jar3.run(SKAction.fadeOut(withDuration: 0.1))
//                jar4.run(SKAction.fadeOut(withDuration: 0.1))
//                jar5.run(SKAction.fadeOut(withDuration: 0.1))
//                jar6.run(SKAction.fadeOut(withDuration: 0.1))
//
            } else if atPoint(position) != becker1 || atPoint(position) != becker2 || atPoint(position) != becker3 || atPoint(position) != becker4 || atPoint(position) != becker5 || atPoint(position) != becker6 {
                jar1.run(SKAction.fadeOut(withDuration: 0.1))
                jar2.run(SKAction.fadeOut(withDuration: 0.1))
                jar3.run(SKAction.fadeOut(withDuration: 0.1))
                jar4.run(SKAction.fadeOut(withDuration: 0.1))
                jar5.run(SKAction.fadeOut(withDuration: 0.1))
                jar6.run(SKAction.fadeOut(withDuration: 0.1))
            }
            
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
                    print("\(liquid.position)")
                    print("\(touch.tapCount)")
                    
                }else{
                    selected?.run(SKAction.move(to: returnPosition, duration: 0.5))
                }
            }
            selected = nil
                
            
        }
    }
    
    func setupLiquid(){
        liquid.position = CGPoint(x: 0, y: -(erlenmeyerMask.size.height * 0.5 + liquid.size.height * 0.5))
    }
    func setupErlenmeryer(){
        erlenmeyer.position = CGPoint(x: frame.midX, y: frame.midY  * 1.1)
        erlenmeyer.setScale(0.7)
        addChild(erlenmeyer)
    }
    
    func setupBackground(){
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(background)
    }
    
    
    func setupBecker1(){
        becker1.position = CGPoint(x: frame.maxX * 0.25, y: frame.maxY * 0.1)
        becker1.setScale(0.55)
        addChild(becker1)
    }
    
    func setupBecker2(){
        becker2.position = CGPoint(x: frame.maxX * 0.5, y: frame.maxY * 0.1)
        becker2.setScale(0.55)
        addChild(becker2)
        
    }
    
    func setupBecker3(){
        becker3.position = CGPoint(x: frame.maxX * 0.75, y: frame.maxY * 0.1)
        becker3.setScale(0.55)
        addChild(becker3)
    }
    
    func setupBecker4(){
        becker4.position = CGPoint(x: frame.maxX * 0.25, y: frame.maxY * 0.25)
        becker4.setScale(0.55)
        addChild(becker4)
    }
    
    func setupBecker5(){
        becker5.position = CGPoint(x: frame.maxX * 0.5, y: frame.maxY * 0.25)
        becker5.setScale(0.55)
        addChild(becker5)
    }
    
    func setupBecker6(){
        becker6.position = CGPoint(x: frame.maxX * 0.75, y: frame.maxY * 0.25)
        becker6.setScale(0.55)
        addChild(becker6)
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
    
    var body: some View {
        ZStack{
            
            
            SpriteView(scene: scene)
                .ignoresSafeArea()
               // .onReceive(NotificationCenter.default.publisher(for: .init(rawValue: "redAction"))) { _ in
                    //isNavigationLinkActive = true
                    
                }
            if isShowingBlur {
                ZStack{
                    Image("instruction2")
                    
                        .onTapGesture {
                            isShowingBlur = false
                        }
                }
                //            ZStack{
                //                Rectangle()
                //                    .foregroundColor(.white)
                //                    .blur(radius: 40)
                //                    .opacity(0.8)
                //                    .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2 )
                //                    .onTapGesture {
                //                        isShowingBlur = false
                //                    }
                //Image("virusWhite")
                //                            .resizable()
                //  .scaledToFit()
                // }
                .background()
                
            }
            
            
//            NavigationLink(destination: Shake(), isActive: $isNavigationLinkActive) {
//                EmptyView(){
//                Text("vai pro proximo")
//            }
//        }
        //.navigationBarHidden(true)
        //.navigationBarBackButtonHidden(true)
    }
    }


struct Mix_Previews: PreviewProvider{
    static var previews: some View {
        Mix()
    }
}

