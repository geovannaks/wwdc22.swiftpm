import SpriteKit
import SwiftUI



class GameSceneVirus: SKScene{
    private var background = SKSpriteNode(imageNamed: "backgroundBlue")
    
    
    override func didMove(to view: SKView) {
        setupBackground()
    }
    
    
    func setupBackground(){
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(background)
    }
}


struct ContentView: View {
    var scene: SKScene {
        let scene = GameSceneVirus()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }
    
    @State private var cont = 0
    @State private var scale = 1.0
    @State private var imageName = "virus"
    
    
    @State private var isShowingBlur = true
    
    @State private var isShowingButton = false
    
    
    /// fazer set scale
    /// contator de tap
    /// spritetexture
    var imagesNames = ["virus", "virus2", "virus3", "virusWhite" ]
    
    
    var body: some View {
        
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
            
            
            
            
            // ZStack{
            Image(imageName)
                .scaleEffect(scale)
                .onTapGesture(count: 1) {
                    guard !isShowingBlur else { return }
                    if cont < 3 {
                        self.scale -= 0.2
                        self.cont += 1
                    }
                    else {
                        imageName = "virusWhite"
                        isShowingButton = true
                    }
                    if cont > 4{
                        return
                    }
                    imageName = imagesNames[cont]
                }
            
            
            if isShowingButton {
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        NavigationLink(destination: Mix()){
                            Image("nextButton")
                                .padding(.trailing, 40)
                                .padding(.bottom, 40)
                        }
                    }
                }
            }
            if isShowingBlur {
                ZStack{
                    Image("instru2")
                        .scaleEffect(0.5)
                }
                .onTapGesture {
                    isShowingBlur = false
                }
            }
        }
    }
}
