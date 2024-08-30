//
//  ResizableLayer.swift
//  MeshBlobGradients
//
//  Created by Space Wizard on 8/29/24.
//

import Foundation
import UIKit

/// An implementation of `CALayer` that resizes its sublayers
public class ResizableLayer: CALayer {
    override init() {
        super.init()
        sublayers = []
    }
    
    public override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSublayers() {
        super.layoutSublayers()
        sublayers?.forEach { layer in
            layer.frame = self.frame
        }
    }
}
