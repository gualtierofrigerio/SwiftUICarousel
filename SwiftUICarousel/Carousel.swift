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

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(images:[])
    }
}
