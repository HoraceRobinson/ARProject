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
    }
    
    func putFruit(){
        rec = arView.enableTapGesture()
    }
    
    func remove(){
        arView.disableTapGesture(tap: rec)
    }
}


extension ARView{
    func enableTapGesture() -> UITapGestureRecognizer{
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recongnizer: )))
        self.addGestureRecognizer(tap)
        return tap
    }
    
    func disableTapGesture(tap: UITapGestureRecognizer){
        self.removeGestureRecognizer(tap)
    }
    
    @objc func handleTap(recongnizer: UITapGestureRecognizer){
        let loc = recongnizer.location(in: self)
        let result = self.raycast(from: loc, allowing: .estimatedPlane, alignment: .any)
        let model = try! ModelEntity.loadModel(named: fruitModel)
        if let first = result.first{
            let pos = simd_make_float3(first.worldTransform.columns.3)
            placeObj(at: pos, model: model)
        }
    }
    
    func placeObj(at position: SIMD3<Float>, model : ModelEntity){
        model.generateCollisionShapes(recursive: true)
        self.installGestures([.all], for: model)
        let anchor = AnchorEntity(world: position)
        anchor.addChild(model)
        self.scene.addAnchor(anchor)
    }
}

extension ARView: ARCoachingOverlayViewDelegate{
    func addCoaching(){
        let coachingOverlay = ARCoachingOverlayView()
        coachingOverlay.delegate = self
        coachingOverlay.session = self.session
        coachingOverlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        coachingOverlay.translatesAutoresizingMaskIntoConstraints = true
        coachingOverlay.goal = .anyPlane
        self.addSubview(coachingOverlay)
    }
}
