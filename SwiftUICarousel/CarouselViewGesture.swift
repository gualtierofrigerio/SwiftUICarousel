//
//  CarouselViewGesture.swift
//  SwiftUICarousel
//
//  Created by Gualtiero Frigerio on 08/06/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct CarouselViewGesture: View {
    var images:[String]
    
    var body: some View {
        GeometryReader { outerView in
            HStack {
                ForEach(self.images, id:\.self) { image in
                    ImageView(withURL: image)
                        .frame(width: outerView.size.width)
                }
            }
            .frame(width: outerView.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * outerView.size.width)
            .offset(x:CGFloat(self.translation))
            .animation(.interactiveSpring())
        }
        .gesture(dragGesture)
    }
    
    // MARK: - Private
    
    @State private var currentIndex: Int = 0
    @GestureState private var translation: CGFloat = 0
    
    private var dragGesture: some Gesture {
        DragGesture().updating(self.$translation) { value, state, _ in
            state = value.translation.width
        }.onEnded { value in
            self.updateCurrentIndex(translationWidth: value.translation.width)
        }
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

struct CarouselViewGesture_Previews: PreviewProvider {
    static var previews: some View {
        CarouselViewGesture(images:[])
    }
}
