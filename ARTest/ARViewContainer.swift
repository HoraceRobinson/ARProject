//
//  ARViewContainer.swift
//  ARTest
//
//  Created by cm on 2022/4/14.
//

import RealityKit
import SwiftUI
import ARKit

struct ARViewContainer: UIViewRepresentable{
    @EnvironmentObject var arViewModel : ARViewModel
    @Binding var addCube : Bool
    
    func makeUIView(context : Context) -> ARView{
        return arViewModel.arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        if(addCube){
            let boxMesh = MeshResource.generateBox(size: 0.1)
            let material = SimpleMaterial(color: .orange, isMetallic: false)
            let modelEntity = ModelEntity(mesh: boxMesh, materials: [material])
            let anchorEntity = AnchorEntity()
            
            anchorEntity.addChild(modelEntity)
            arViewModel.arView.scene.addAnchor(anchorEntity)
            DispatchQueue.main.sync {
                addCube = false
            }
        }
    }
}
