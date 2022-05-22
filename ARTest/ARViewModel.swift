//
//  ARViewModel.swift
//  ARTest
//
//  Created by cm on 2022/5/21.
//

import SwiftUI
import RealityKit
import ARKit

var fruitModel = "apple"

class ARViewModel : ObservableObject{
    var arView : ARView
    var rec : UITapGestureRecognizer
    init(){
        arView = ARView()
        rec = arView.enableTapGesture()
        arView.addCoaching()
        arView.setupWorldConfig()
    }
    
    func putFruit(){
        rec = arView.enableTapGesture()
    }
    
    func remove(){
        arView.disableTapGesture(tap: rec)
    }
}
