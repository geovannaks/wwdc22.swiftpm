import SwiftUI

@main
struct MyApp: App {
    var music = Music(name: "bumbumtamta", format: ".mp3")
    
    
    var body: some Scene {
        WindowGroup {
            VStack{
              // ContentView()
                //Thanks()
                //StartView()
                History()
                //Mix()
            }
            .onAppear {
               // music.play()
                music.setVolume(volume: 0.2)
            }
            
        }
    }
}
