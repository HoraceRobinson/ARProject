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
    @State var modelName = "apple"
    var nameList = ["apple", "blueberry", "lychee"]
    var body: some View{
        ZStack(alignment: .bottom){
            ARViewContainer(addCube: $addCube, modelName: $modelName)
            VStack{
                Text("Welcome to the AR world!")
                    .foregroundColor(.blue)
                    .font(.title)
                HStack{
                    ForEach(nameList, id: \.self){name in
                        Button(action: {
                            addCube = true
                            modelName = name
                        }, label: {
                            Text("\(name)")
                        })
                            .buttonStyle(.bordered)
                            .padding()
                    }
                }
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

