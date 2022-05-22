//
//  ContentView.swift
//  ARTest
//
//  Created by cm on 2022/4/14.
//

import SwiftUI

struct ContentView : View {
    @StateObject var arViewModel = ARViewModel()
    @State var addFruit = false
    @State var modelName = "apple"
    var nameList = ["apple", "blueberry", "lychee", "peach", "banana", "coconut", "grape", "bowl"]
    var body: some View{
        ZStack(alignment: .bottom){
            ARViewContainer(addFruit: $addFruit, modelName: $modelName)
            VStack{
                Text("Choose a fruit to put!")
                    .fontWeight(.heavy)
                    .font(.title)
                    .foregroundColor(.white.opacity(0.8))
                HStack{
                    ForEach(nameList, id: \.self){name in
                        Button(action: {
                            addFruit = true
                            modelName = name
                        }, label: {
                            Text("\(name)")
                        })
                            .buttonStyle(.bordered)
                            .padding()
                    }
                }
                .background(.black.opacity(0.5))
                .cornerRadius(8)
            }
            
        }
        .environmentObject(arViewModel)
    }
        
}

