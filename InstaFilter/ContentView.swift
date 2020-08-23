//
//  ContentView.swift
//  InstaFilter
//
//  Created by Joseph Faragalla on 2020-08-23.
//  Copyright © 2020 Joseph Farag Alla. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0 {
        didSet {
            print("the new blur amount is \(blurAmount)")
        }
    }
    
    var body: some View {
        //blur will now observe blur amount and will notice any changes and act accordingly
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )
        return VStack {
            Text("Hello, World!")
                .blur(radius: blurAmount)
            Slider(value: blur, in: 0 ... 20)
        }
        
    }
}

struct UsingActionSheet: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello World")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
        .actionSheet(isPresented: $showingActionSheet) { () -> ActionSheet in
            ActionSheet(title: Text("Change background"), message: Text("Select a new background color"), buttons: [
                .default(Text("Red"), action: {
                    self.backgroundColor = .red
                }),
                .default(Text("Green"), action: {
                    self.backgroundColor = .green
                }),
                .cancel()
                
            
            ])
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
