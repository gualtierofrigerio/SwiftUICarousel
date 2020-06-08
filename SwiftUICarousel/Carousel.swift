//
//  Carousel.swift
//  SwiftUICarousel
//
//  Created by Gualtiero Frigerio on 07/06/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct Carousel: View {
    var images:[String]
    
    var body: some View {
        GeometryReader { outerView in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(self.images, id:\.self) { image in
                        ImageView(withURL: image)
                            .frame(width:outerView.size.width)
                    }
                }
            }
        }
    }
}

struct CarouselGesture: View {
    @State private var currentIndex: Int = 0
    @GestureState private var translation: CGFloat = 0
    
    var images:[String]
    
    var dragGesture: some Gesture {
        DragGesture().updating(self.$translation) { value, state, _ in
            state = value.translation.width
        }.onEnded { value in
            self.updateCurrentIndex(translationWidth: value.translation.width)
        }
    }
    
    var body: some View {
        GeometryReader { outerView in
            HStack {
                ForEach(self.images, id:\.self) { image in
                    ImageView(withURL: image)
                        .frame(width:outerView.size.width)
                }
            }
            .frame(width: outerView.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * outerView.size.width)
            .offset(x:CGFloat(self.translation))
        }
        .gesture(dragGesture)
    }
    
    private func updateCurrentIndex(translationWidth:CGFloat) {
        self.currentIndex = translationWidth < 0 ? self.currentIndex + 1 : self.currentIndex - 1
        if self.currentIndex < 0 {
            self.currentIndex = 0
        }
        if self.currentIndex >= self.images.count {
            self.currentIndex = self.images.count - 1
        }
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(images:[])
    }
}
