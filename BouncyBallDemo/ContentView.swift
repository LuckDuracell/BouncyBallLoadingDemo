//
//  ContentView.swift
//  BouncyBallDemo
//
//  Created by Luke Drushell on 3/24/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var ballY: CGFloat = 50
    @State var ballUp: Bool = false
    @State var ballSpeed: CGFloat = 6
    
    
    @State var loadProgress: CGFloat = 0
    
    @State var timer = Timer.publish(every: 0.0025, on: .main, in: .common).autoconnect()
    
    func shadowScale() -> CGFloat {
        -0.6 + (ballY * -0.0005)
    }
    
    func ballResetSpeed() -> CGFloat {
        -2 * (1.01-loadProgress)
    }
    
    func updateY() {
        if ballUp {
            //ball is going up, negative speed
            ballSpeed += 0.004
            if ballSpeed >= 0 {
                ballUp = false
            }
        } else {
            ballSpeed += 0.005
            if ballY >= screen().height * 0.95 {
                ballUp = true
                if loadProgress < 1 {
                    withAnimation(.easeIn(duration: 10)) {
                        loadProgress += 0.04
                    }
                }
                ballSpeed = ballResetSpeed()
            }
        }
        ballY += ballSpeed
    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("LOADING...")
                    .font(.system(.title2, design: .monospaced, weight: .heavy))
                ProgressView(value: loadProgress)
                    .padding(.horizontal)
                Spacer()
            } .padding(.top, 50)
            Circle()
                .frame(width: 100, height: 100)
                .scaleEffect(x: 1, y: 0.15, anchor: .center)
                .scaleEffect(shadowScale(), anchor: .center)
                .opacity(0.6)
                .position(x: screen().width / 2, y: screen().height)
            LinearGradient(colors: [.white.opacity(0.2), .blue, .black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .background(.teal)
                .clipShape(Circle())
                .frame(width: 100, height: 100)
                .position(x: screen().width / 2, y: ballY)
        } .onReceive(timer, perform: { _ in
            updateY()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct screen {
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height * 0.9
}
