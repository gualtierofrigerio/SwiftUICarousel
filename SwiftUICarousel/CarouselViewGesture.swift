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
                    ForEach(self.images, id:\.self) { image in
                        GFImageView(imageUrl: URL(string: image), placeHolderImage: nil)
                            .frame(width: outerView.size.width)
                    }
                }
                .frame(width: outerView.size.width, alignment: .leading)
                .offset(x: -CGFloat(self.currentIndex) * outerView.size.width)
                .offset(x:CGFloat(self.translation))
                .animation(.interactiveSpring())
                if showDots {
                    dots
                }
            }
        }
        .gesture(dragGesture)
    }
    
    // MARK: - Private
    
    @State private var currentIndex: Int = 0
    @GestureState private var translation: CGFloat = 0
    
    private var dots: some View {
        HStack {
            ForEach(0..<images.count) { index in
                index == currentIndex ? Image(systemName: "circle.fill") : Image(systemName: "circle")
            }
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture().updating(self.$translation) { value, state, _ in
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
    }
}

struct CarouselViewGesture_Previews: PreviewProvider {
    static var previews: some View {
        CarouselViewGesture(images:[])
    }
}
