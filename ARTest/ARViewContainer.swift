//
//  ARViewContainer.swift
//  ARTest
//
//  Created by cm on 2022/4/14.
//

import RealityKit
import SwiftUI
import ARKit
import Combine

struct ARViewContainer: UIViewRepresentable{
    @EnvironmentObject var arViewModel : ARViewModel
    @Binding var addCube : Bool
    @Binding var modelName : String
    
    func makeUIView(context : Context) -> ARView{
        let view = arViewModel.arView
        let config = ARWorldTrackingConfiguration()
        config.isAutoFocusEnabled = false
        config.planeDetection = [.horizontal, .vertical]
        view.session.run(config)
        return view
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        if(addCube){
            let boxMesh = MeshResource.generateBox(size: 0.1)
            let model = try! ModelEntity.loadModel(named: modelName)
            model.scale = [0.5, 0.5, 0.5]
            
//            var transform = ball.transform
//            transform.scale = SIMD3<Float>(repeating: 1.0)
            
            let material = SimpleMaterial(color: .orange, isMetallic: false)
            _ = ModelEntity(mesh: boxMesh, materials: [material])
            let anchorEntity = AnchorEntity(plane: .any)
            anchorEntity.addChild(model)
//            ball.move(to: transform, relativeTo: ball.parent, duration: 1, timingFunction: .easeOut)
            arViewModel.arView.scene.addAnchor(anchorEntity)
            DispatchQueue.main.async {
                addCube = false
            }
        }
    }
}
