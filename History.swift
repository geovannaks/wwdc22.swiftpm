
import Foundation
import SwiftUI
import SpriteKit




class GameSceneIntrodution: SKScene{
    private var background = SKSpriteNode(imageNamed: "backgroundBlue")
    private var nextButton = SKSpriteNode(imageNamed: "nextButton")
    private var dra = SKSpriteNode(imageNamed: "dra")
    private var draHand = SKSpriteNode(imageNamed: "dra2")
    var textScreen: SKSpriteNode!
    var currentIndex = 1
    
    
    
    override func didMove(to view: SKView) {
        nameText()
        setupNextButton()
        setupBackground()
        setupDra()
    }
    
    
    func setupNextButton(){
        nextButton.position = CGPoint(x:  self.size.width * 0.8 , y: self.size.width * 0.2)
        addChild(nextButton)
        
    }
    
    func setupBackground(){
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(background)
    }
    
    func setupDra(){
        dra.zPosition = 2
        dra.position = CGPoint(x: frame.midX / 2, y: frame.midY * 0.3)
        dra.setScale(0.8)
        addChild(dra)
    }
    
    func setupDraHand(){
        draHand.zPosition = 2
        draHand.position = CGPoint(x: frame.midX / 2, y: frame.midY * 0.3)
        draHand.setScale(0.8)
        addChild(draHand)
    }
    
    func nameText(){
        let name = "text" + String(currentIndex)
        textScreen = SKSpriteNode(imageNamed: name)
        textScreen.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7 )
        addChild(textScreen)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location) == nextButton {
                if currentIndex < 8 {
                    currentIndex += 1
                    nameText()
                }
                if currentIndex == 6 {
                    dra.run(SKAction.fadeOut(withDuration: 0.1))
                    setupDraHand()
                    draHand.run(SKAction.fadeIn(withDuration: 0.2))
                }
                if currentIndex == 8 {
                    
                    NotificationCenter.default.post(name: .init(rawValue: "redAction"), object: nil)
                    textScreen.removeFromParent()
                    
                }
                
            }
        }
        
    }
    
}



struct History: View {
    private var scene: GameSceneIntrodution = {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = GameSceneIntrodution()
        
        scene.size = CGSize(width: screenWidth, height: screenHeight)
        scene.scaleMode = .fill
        scene.backgroundColor = .white
        return scene
    }()
    
    @State
    private var isNavigationLinkActive = false
    
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
                .onReceive(NotificationCenter.default.publisher(for: .init(rawValue: "redAction"))) { _ in
                    isNavigationLinkActive = true
                }
            VStack {
                NavigationLink(destination: ContentView(), isActive: $isNavigationLinkActive) {
                    EmptyView()
                }.navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
            }
            
        }
        
        
    }
}

struct History_Previews: PreviewProvider{
    static var previews: some View{
        History()
    }
}


