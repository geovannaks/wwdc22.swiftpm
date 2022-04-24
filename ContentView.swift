import SwiftUI

class GameSceneVirus{
    
}


struct ContentView: View {


    @State private var cont = 0
    @State private var scale = 1.0
    @State private var imageName = "virus"
    
    
    @State
    private var isShowingBlur = true
    
    var imagesNames = ["virus", "virus2", "virus3", "virusWhite" ]
    
    
    var body: some View {
        ZStack{
            
            Image("backgroundBlue")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
                Image(imageName)
                    .scaleEffect(scale)
                    .onTapGesture(count: 1) {
                        if cont < 3 {
                            self.scale -= 0.2
                            self.cont += 1
                        }
                        else {
                            imageName = "virusWhite"
                        }
                        if cont > 4{
                            return
                        }
                        imageName = imagesNames[cont]
                    
//                if isShowingBlur {
//                    ZStack{
//                        Rectangle()
//                            .foregroundColor(.white)
//                            .blur(radius: 40)
//                            .opacity(0.3)
//                            .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 2 )
//                            .onTapGesture {
//                                isShowingBlur = false
//                            }
//                        //Image("virusWhite")
////                            .resizable()
//                          //  .scaledToFit()
//                    }.background(
//                        VStack{
//                            Text("Tap here")
//                                .foregroundColor(.red)
//                                .font(.system(size: 30, weight: .bold, design: .rounded))
//                        })
//
//                }
            }
            NavigationLink(destination: Mix()){
                Image("nextButton")
                    .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2 )
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
}
