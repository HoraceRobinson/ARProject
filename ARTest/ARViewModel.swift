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
//        arView.initARWorldConfig()
        arView.enableTapGesture()
        arView.addCoaching()
    }
}

//extension ARView{
//    func initARWorldConfig(){
//        let config = ARWorldTrackingConfiguration()
//        config.isAutoFocusEnabled = true
//        self.session.run(config)
//
//    }
//}
extension ARView{
    func enableTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recongnizer: )))
        self.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(recongnizer: UITapGestureRecognizer){
        let loc = recongnizer.location(in: self)
        let result = self.raycast(from: loc, allowing: .estimatedPlane, alignment: .any)
        if let first = result.first{
            let pos = simd_make_float3(first.worldTransform.columns.3)
            placeObj(at: pos)
        }
    }
    
    func placeObj(at position: SIMD3<Float>){
        let model = try! ModelEntity.loadModel(named: "lychee")
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
