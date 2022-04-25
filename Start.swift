

import Foundation
import SwiftUI

struct StartView: View {
    let background = Image("backgroundBlue")
    @State private var blinking: Bool = false
    
    
    var body: some View {
        ZStack {
            background
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all)
            VStack {
                Image("ivaxx")
                
                VStack(alignment: .center, spacing: 20)  {
                    NavigationLink(destination: History()) {
                        Image("tapToStart")
                    }
                    Text("For the best experience use full screen")
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(.white)
                    //                        Image("best")
                    //                            .scaleEffect(0.5)
                }
                .padding(.bottom)
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
}

public extension View {
    func fullBackground(imageName: String) -> some View {
        return background(
            Image(imageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        )
    }
}

