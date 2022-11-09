//
//  SplashScreenView.swift
//  First App
//
//  Created by Vivek on 8/27/22.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
   
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image("Healthwiz White Logo")
                        .colorMultiply(.purple)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true;
                    }
                }
            }
        }
    }
   
//    var body: some View {
//        ZStack {
//            Color.purple.ignoresSafeArea()
//
//            Image("Healthwiz White Logo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//        }
//    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashScreenView()
        }
    }
}
