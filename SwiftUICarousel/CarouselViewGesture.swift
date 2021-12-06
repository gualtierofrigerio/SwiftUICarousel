//
//  CarouselViewGesture.swift
//  SwiftUICarousel
//
//  Created by Gualtiero Frigerio on 08/06/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import GFImageView
import SwiftUI

struct CarouselViewGesture: View {
    var images: [String]
    var showDots = true
    
    var body: some View {
        GeometryReader { outerView in
            VStack {
                HStack {
                    ForEach(activeImages, id:\.self) { image in
                        GFImageView(imageUrl: URL(string: image), placeHolderImage: nil)
                            .frame(width: outerView.size.width)
                    }
                }
                .frame(width: outerView.size.width, alignment: .leading)
                .offset(x: -CGFloat(currentIndex) * outerView.size.width)
                .offset(x: CGFloat(translation))
                .animation(.interactiveSpring())
                if showDots {
                    dots
                }
            }
        }
        .gesture(dragGesture)
        .onAppear {
            resetActiveImages()
        }
    }
    
    // MARK: - Private
    
    @State private var currentIndex: Int = 0
    @State private var activeImages: [String] = []
    @GestureState private var translation: CGFloat = 0
    
    private var dots: some View {
        HStack {
            ForEach(0..<images.count) { index in
                index == currentIndex ? Image(systemName: "circle.fill") : Image(systemName: "circle")
            }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture().updating($translation) { value, state, _ in
            state = value.translation.width
        }.onEnded { value in
            self.updateCurrentIndex(translationWidth: value.translation.width)
        }
    }
    
    private func updateCurrentIndex(translationWidth:CGFloat) {
        currentIndex = translationWidth < 0 ? currentIndex + 1 : currentIndex - 1
        if currentIndex < 0 {
            currentIndex = 0
        }
        if currentIndex >= images.count {
            currentIndex = images.count - 1
        }
        updateActiveImages()
    }
    
    private func resetActiveImages() {
        currentIndex = 0
        activeImages = []
        if images.count > 0 {
            activeImages.append(images[0])
        }
        updateActiveImages()
    }
    
    private func updateActiveImages() {
        for i in 1..<3 {
            if  (activeImages.count <= currentIndex + i) &&
                (images.count > currentIndex + i) {
                activeImages.append(images[currentIndex + i])
            }
        }
    }
}

struct CarouselViewGesture_Previews: PreviewProvider {
    static var previews: some View {
        CarouselViewGesture(images:[])
    }
}
