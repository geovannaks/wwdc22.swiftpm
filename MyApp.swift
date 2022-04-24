import SwiftUI

@main
struct MyApp: App {
    var music = Music(name: "bumbumtamta", format: ".mp3")
    
    
    var body: some Scene {
        WindowGroup {
            VStack{
                NavigationView {
                   // Mix()
            StartView()
                    //ContentView()
                   // Shake()
                }
                .navigationViewStyle(.stack)
                 //Thanks()
//                StartView()
                //History()
                
                //Shake()
            }
            .onAppear {
               // music.play()
                music.setVolume(volume: 0.1)
            }
            
        }
    }
}
