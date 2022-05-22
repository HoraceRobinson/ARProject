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
    @Binding var addFruit : Bool
    @Binding var modelName : String
    
    func makeUIView(context : Context) -> ARView{
        let view = arViewModel.arView
        let config = ARWorldTrackingConfiguration()
        config.isAutoFocusEnabled = false
        config.planeDetection = [.horizontal, .vertical]
        let pos = simd_make_float3(0, 0, 0)
        let title = try! ModelEntity.loadModel(named: "title")
        view.placeObj(at: pos, model: title)
        view.session.run(config)
        return view
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        if(addFruit){
//            let model = try! ModelEntity.loadModel(named: modelName)
//            model.scale = [0.5, 0.5, 0.5]
//
//            model.generateCollisionShapes(recursive: true)
//            arViewModel.arView.installGestures([.all], for: model)
//            let anchorEntity = AnchorEntity(plane: .any)
//            anchorEntity.addChild(model)
////            ball.move(to: transform, relativeTo: ball.parent, duration: 1, timingFunction: .easeOut)
//            arViewModel.arView.scene.addAnchor(anchorEntity)
            fruitModel = modelName
            arViewModel.putFruit()
            DispatchQueue.main.async {
                addFruit = false
                arViewModel.remove()
            }
        }
    }
}
