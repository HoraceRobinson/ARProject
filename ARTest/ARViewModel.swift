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

extension ARView: ARCoachingOverlayViewDelegate{
    func addcoaching(){
        let coach = ARCoachingOverlayView()
        coach.delegate = self
        coach.session = self.session
        coach.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coach.translatesAutoresizingMaskIntoConstraints = true
        coach.goal = .anyPlane
        self.addSubview(coach)
    }
}
