
import SwiftUI
import SpriteKit
class GameSceneThanks: SKScene{
    private var background = SKSpriteNode(imageNamed: "backgroundBlue")
    private var nextButton = SKSpriteNode(imageNamed: "nextButton")
    private var dra = SKSpriteNode(imageNamed: "dra")
    private var draHand = SKSpriteNode(imageNamed: "dra2")
    
    private var vaccine = SKSpriteNode(imageNamed: "vaccine")
    private var vial = SKSpriteNode(imageNamed: "vial")
    var textScreen: SKSpriteNode!
    var currentIndex = 1
    
    override func didMove(to view: SKView) {
        nameText()
        setupNextButton()
        setupBackground()
        setupDra()
    }
    
    func setupVaccine(){
        vaccine.position = CGPoint(x: frame.midX, y:frame.midY * 0.8)
        vaccine.setScale(0.5)
        addChild(vaccine)
    }
    func setupVial(){
        vial.position = CGPoint(x: frame.midX * 1.2, y:frame.midY * 0.4)
        vial.setScale(0.3)
        addChild(vial)
    }
    
    func setupNextButton(){
        nextButton.position = CGPoint(x:  self.size.width * 0.8 , y: self.size.width * 0.2 )
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
        let name = "finaltext" + String(currentIndex)
        textScreen = SKSpriteNode(imageNamed: name)
        textScreen.position = CGPoint(x: self.size.width / 2, y: self.size.height * 0.7 )
        addChild(textScreen)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location) == nextButton {
                if currentIndex < 7 {
                    currentIndex += 1
                    nameText()
                }
                if currentIndex == 4 {
                    dra.run(SKAction.fadeOut(withDuration: 0.1))
                    setupDraHand()
                    draHand.run(SKAction.fadeIn(withDuration:   0.2))
                    
                    setupVial()
                    setupVaccine()
                    vaccine.run(SKAction.fadeIn(withDuration: 0.5))
                    vial.run(SKAction.fadeIn(withDuration: 0.5))
                }
                if currentIndex == 5{
                    nextButton.removeFromParent()
                    
                }
                if currentIndex == 6 {
                    
                    NotificationCenter.default.post(name: .init(rawValue: "redAction"), object: nil)
                    textScreen.removeFromParent()
                    
                    
                }
            }
        }
        
    }
    
}



struct Thanks: View {
    private var scene: GameSceneThanks = {
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let scene = GameSceneThanks()
        
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

//struct Thanks_Previews: PreviewProvider{
//    static var previews: some View{
//        Thanks()
//    }
//}
