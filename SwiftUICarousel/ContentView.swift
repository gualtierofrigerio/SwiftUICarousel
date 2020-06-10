//
//  ContentView.swift
//  SwiftUICarousel
//
//  Created by Gualtiero Frigerio on 31/05/2020.
//  Copyright © 2020 Gualtiero Frigerio. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let images = ["https://homepages.cae.wisc.edu/~ece533/images/boat.png",
                  "https://homepages.cae.wisc.edu/~ece533/images/fruits.png",
                  "https://homepages.cae.wisc.edu/~ece533/images/cat.png"
    ]
    var body: some View {
        CarouselViewGesture(images: images)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
