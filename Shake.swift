import SpriteKit
import SwiftUI
import CoreMotion


class GameSceneShake: SKScene{
    var lastUpDate = TimeInterval()
    var timeShake = TimeInterval()
    var isVaccineShowed = false
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    private let liquidWave = SKSpriteNode(imageNamed: "liquidBlueWave")
    private let liquid = SKSpriteNode(imageNamed: "liquidBlue")
    private let erlenmeyer = SKSpriteNode(imageNamed: "erlenmeyer")
    private let erlenmeyerMask = SKSpriteNode(imageNamed: "erlenmeyerMask")
    private var background = SKSpriteNode(imageNamed: "backgroundBlue")
    private var vaccine = SKSpriteNode(imageNamed: "vaccine")
    private var vial = SKSpriteNode(imageNamed: "vial")
    private let congratis = SKSpriteNode(imageNamed: "congratulations")
    var isShake = false
    private var buttonShowed = false
    
    override func didMove(to view: SKView) {
        let crop = SKCropNode()
        
        crop.maskNode = erlenmeyerMask
        crop.addChild(liquid)
        crop.addChild(liquidWave)
        liquidWave.alpha = 0
        addChild(crop)
        crop.position = CGPoint(x: frame.midX, y: frame.midY * 1.1)
        crop.setScale(0.5)
        
        setupBackground()
        
        erlenmeyer.position = CGPoint(x: frame.midX, y: frame.midY * 1.1)
        erlenmeyer.setScale(0.5)
        addChild(erlenmeyer)
        liquid.position = CGPoint(x: 0, y: -erlenmeyerMask.size.height * 0.5 + liquid.size.height * 0.5)
        liquidWave.position = CGPoint(x: -erlenmeyerMask.size.width * 0.5 + liquidWave.size.width * 0.5, y: -erlenmeyerMask.size.height * 0.5 + liquidWave.size.height * 0.5)
        vaccine.position = CGPoint(x: frame.midX, y:frame.midY)
        vaccine.setScale(0.6)
        vial.position = CGPoint(x: frame.midX, y:frame.midY)
        vial.setScale(0.5)
        congratis.position = CGPoint(x: frame.midX, y:frame.midY)
        congratis.setScale(0.5)
        let moveLeft = SKAction.moveBy(x: -liquidWave.size.width * 0.5, y: 0, duration: 0.2)
        let moveRight = SKAction.moveBy(x: liquidWave.size.width * 0.5, y: 0, duration: 0)
        let sequence = SKAction.sequence([moveLeft,moveRight])
        let repeatSequence = SKAction.repeatForever(sequence)
        liquidWave.run(repeatSequence)
        
        
        
        motionManager.accelerometerUpdateInterval = 0.3
        motionManager.startAccelerometerUpdates(to: self.queue) { [self] (data, error) in
            guard let myData = data else {
                print("Error: \(error!)")
                return
            }
            if  myData.acceleration.x > 0.4 || myData.acceleration.x < -0.4 {
                
                if isShake == false{
                    startShake()
                }
                
            }else{
                if isShake == true{
                    stopShake()
                }
            }
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        if lastUpDate == 0 {
            lastUpDate = currentTime
            return
        }
        
        var deltaTime =  currentTime - lastUpDate
        lastUpDate = currentTime
        deltaTime = min(deltaTime, 0.1)
        
        if isShake == true {
            timeShake += deltaTime
            if timeShake > 1 {
                if isVaccineShowed == false {
                    isVaccineShowed = true
                    showVaccine()
                }
            }
            
            
        }
    }
    
    //    func sequenceLiquidWave(){
    //
    //    }
    //
    func startShake(){
        if isVaccineShowed{
            return
        }
        isShake = true
        liquid.run(SKAction.wait(forDuration: 2))
        liquidWave.run(SKAction.fadeIn(withDuration: 0.5))
        liquid.run(SKAction.fadeOut(withDuration: 0.2))
    }
    
    
    func stopShake(){
        if isVaccineShowed{
            return
        }
        isShake = false
        liquid.run(SKAction.wait(forDuration: 2))
        liquidWave.run(SKAction.fadeOut(withDuration: 0.5))
        liquid.run(SKAction.fadeIn(withDuration: 0.5))
    }
    
    func showVaccine(){
        buttonShowed = true
        liquid.removeAllActions()
        liquidWave.removeAllActions()
        erlenmeyer.removeAllActions()
        erlenmeyerMask.removeAllActions()
        liquid.run(SKAction.fadeOut(withDuration: 0.5))
        liquidWave.run(SKAction.fadeOut(withDuration: 0.5))
        erlenmeyer.run(SKAction.fadeOut(withDuration: 0.5))
        erlenmeyerMask.run(SKAction.fadeOut(withDuration: 0.5))
        addChild(vaccine)
        addChild(vial)
        addChild(congratis)
        vaccine.alpha = 0
        vial.alpha = 0
        congratis.alpha = 0
        congratis.position = CGPoint(x: frame.midX * 1.2, y:frame.midY * 0.4)
        vial.position = CGPoint(x: frame.midX * 1.2, y:frame.midY * 0.4)
        vaccine.position = CGPoint(x: frame.midX * 0.8, y:frame.midY * 1.2)
        vaccine.run(SKAction.fadeIn(withDuration: 0.5))
        vial.run(SKAction.fadeIn(withDuration: 0.5))
        congratis.run(SKAction.fadeIn(withDuration: 0.5))
        NotificationCenter.default.post(name: .init(rawValue: "vaccine"), object: nil)
    }
    
    
    
    func setupBackground(){
        background.zPosition = -1
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: self.size.width, height: self.size.height)
        addChild(background)
    }
}


struct Shake: View {
    @State
    private var isShowingBlur = true
    @State
    private var isNavigationLinkActive = false
    
    @State
    private var isShowingButton = false
    
    var scene: SKScene {
        let scene = GameSceneShake()
        scene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        scene.scaleMode = .fill
        return scene
    }
    
    
    var body: some View {
        ZStack{
            
            SpriteView(scene: scene)
                .ignoresSafeArea()
            if isShowingBlur {
                ZStack{
                    Image("instru3")
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
                        NavigationLink(destination: Thanks()){
                            Image("nextButton")
                                .padding(.trailing, 40)
                                .padding(.bottom, 40)
                        }
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .init(rawValue: "vaccine"))) { _ in
            isShowingButton = true
        }
    }
}

//struct Shake_Previews: PreviewProvider{
//    static var previews: some View{
//        Shake()
//    }
//}
//
//
