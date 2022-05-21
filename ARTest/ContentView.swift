//
//  ContentView.swift
//  ARTest
//
//  Created by cm on 2022/4/14.
//

import SwiftUI

struct ContentView : View {
    @StateObject var arViewModel = ARViewModel()
    @State var addCube = false
    var body: some View{
        ZStack(alignment: .bottom){
            ARViewContainer(addCube: $addCube)
            VStack{
                Text("Welcome to the AR world!")
                    .foregroundColor(.blue)
                    .font(.title)
                Button(action: {
                    addCube = true
                }, label: {
                    Text("Put a Cube")
                }).buttonStyle(.bordered)
                    .padding()
            }
            
        }
        .environmentObject(arViewModel)
    }
        
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
