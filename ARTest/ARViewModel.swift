//
//  ARViewModel.swift
//  ARTest
//
//  Created by cm on 2022/5/21.
//

import SwiftUI
import RealityKit
import ARKit

class ARViewModel : ObservableObject{
    var arView : ARView
    init(){
        arView = ARView()
    }
}
