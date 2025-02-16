//
//  ContentView.swift
//  SwiftUI Navigation and Other Controls
//
//  Created by Kyle Kaufman on 2/6/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    var body: some View {
        VStack {
            if(isLoggedIn){
                MainScreen()
            }
            else {
                LoginScreen(isLoggedIn: $isLoggedIn)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

