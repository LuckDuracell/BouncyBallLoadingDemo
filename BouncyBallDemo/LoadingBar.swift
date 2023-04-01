//
//  LoadingBar.swift
//  BouncyBallDemo
//
//  Created by Luke Drushell on 3/31/23.
//

import SwiftUI

struct LoadingBar: View {
    
    @Binding var loadProgress: CGFloat
    
    var body: some View {
        VStack {
            Text("LOADING...")
                .font(.system(.title2, design: .monospaced, weight: .heavy))
            ProgressView(value: loadProgress)
                .padding(.horizontal)
            Spacer()
        } .padding(.top, 50)
    }
}

struct LoadingBar_Previews: PreviewProvider {
    static var previews: some View {
        LoadingBar(loadProgress: .constant(0.5))
    }
}
