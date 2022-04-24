

import Foundation
import SwiftUI

struct StartView: View {
    let background = Image("backgroundBlue")
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                background
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                VStack {
                    Image("ivaxx")
                    NavigationLink(destination: History()){
                        Image("tapToStart")
                    }
                }.background(background)
            }
        }
        .navigationViewStyle(.stack)
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

