//
//  ARViewExtension.swift
//  ARTest
//
//  Created by cm on 2022/4/30.
//

import Foundation
import SwiftUI
import RealityKit
import ARKit

extension ARView{
    func setupWorldConfig(){
        let config = ARWorldTrackingConfiguration()
        config.isAutoFocusEnabled = false
        config.environmentTexturing = .automatic
        config.isLightEstimationEnabled = true
        self.session.run(config)
    }
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
        let text = MeshResource.generateText(fruitModel)
        let material = SimpleMaterial(color: .white, isMetallic: false)
        let textModel = ModelEntity(mesh: text, materials: [material])
        let anchor = AnchorEntity(world: position)
        
        anchor.addChild(textModel)
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
