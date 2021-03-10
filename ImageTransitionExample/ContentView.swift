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
    @State private var images = ["Piper-Backyard", "Piper-Kitchen", "Piper-In-Lap"]

    // The last image that we showed
    @State private var lastImage = -1
    
    // The current image to show
    @State private var currentImage = 0
    
    // Initialize a timer that will fire to fade the image out
    @State private var fadeOut = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    // Initialize a timer that will fire to change the image and make it fade in
    @State private var changeAndFadeIn = Timer.publish(every: 6, on: .main, in: .common).autoconnect()

    // The opacity of the image
    @State private var currentOpacity = 1.0
    
    var body: some View {
        
        Image(images[currentImage])
            .resizable()
            .scaledToFit()
            .opacity(currentOpacity)
            .onReceive(changeAndFadeIn) { input in
                
                withAnimation(Animation.easeIn(duration: 3.0)) {
                    
                    // Change the image and fade in
                    // Make sure we don't go past the end of the array
                    if currentImage < images.count - 1 {
                        currentImage += 1
                    } else {
                        currentImage = 0
                    }
                    
                    // Fade the image in
                    print("fading in, last image is \(lastImage) and current image is \(currentImage)")
                    currentOpacity = 1.0

                }
                                
            }
            .onReceive(fadeOut) { input in
                
                withAnimation(Animation.easeOut(duration: 3.0)) {
                    
                    // This timer fires twice as often as the other one
                    // However, we only want to fade the image out when it been shown for three seconds
                    // How to do this?
                    // We can look for when the current image is NOT the same as the prior image
                    // When this is true, the image has already been shown
                    if currentImage != lastImage {
                        
                        // Fade the image out
                        print("fading out, last image is \(lastImage) and current image is \(currentImage)")
                        currentOpacity = 0.0
                        
                        // Update what image was just shown
                        lastImage = currentImage

                    }

                }
                                
            }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
