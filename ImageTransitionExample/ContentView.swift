//
//  ContentView.swift
//  ImageTransitionExample
//
//  Created by Russell Gordon on 2021-03-09.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Stored Properties
    
    // The list of images to show
    @State private var images = ["Piper-Kitchen", "Piper-Backyard", "Piper-Lap"]
    
    // Initialize a timer that will fire to fade the image out in 3 seconds
    let changeAndFadeIn = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    // The opacity of the image
    @State private var currentOpacity = 1.0
    
    var body: some View {
        Image(images.first!)
            .resizable()
            .scaledToFit()
            .opacity(currentOpacity)
            .animation(Animation.easeOut(duration: 3.0))
            .onReceive(changeAndFadeIn) { input in
                
                // Fade the image out
                currentOpacity = 0.0
                
                // Stop the timer from continuing to fire
                changeAndFadeIn.upstream.connect().cancel()
                
            }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
