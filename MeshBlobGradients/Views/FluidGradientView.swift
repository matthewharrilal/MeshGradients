//
//  FluidGradientView.swift
//  MeshBlobGradients
//
//  Created by Space Wizard on 8/27/24.
//

import UIKit

class FluidGradientView: UIView {
    private var blobs: [UIColor] = []
    private var highlights: [UIColor] = []
    private var speed: CGFloat = 1.0
    private var blur: CGFloat = 0.75
    
    var baseLayer: CALayer!
    var highlightLayer: CALayer!
    private var blurEffectView: UIVisualEffectView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        applyBlurEffect()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        applyBlurEffect()
    }
    
    private func setupLayers() {
        baseLayer = ResizableLayer()
        highlightLayer = ResizableLayer()

        // Applying a blending mode to the highlightLayer
        if let compositingFilter = CIFilter(name: "CIOverlayBlendMode") {
            highlightLayer.compositingFilter = compositingFilter
        }
        
        layer.addSublayer(baseLayer)
        layer.addSublayer(highlightLayer)
    }
    
    private func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 18
        
        // Add a subtle tint color
        let tintView = UIView(frame: blurEffectView.bounds)
        tintView.backgroundColor = UIColor.white.withAlphaComponent(0.4) // Adjust alpha to your preference
        tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        blurEffectView.contentView.addSubview(tintView)
        addSubview(blurEffectView)
    }
    
    func create(_ colors: [UIColor], layer: CALayer) {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
        for color in colors {
            let blob = BlobLayer(color: color)
            blob.frame = bounds
            layer.addSublayer(blob)
        }
    }
    
    func update(speed: CGFloat) {
        self.speed = speed
        animate()
    }
    
    private func animate() {
        // Animate base layer
        baseLayer.sublayers?.forEach { ($0 as? BlobLayer)?.animate(speed: speed) }
        highlightLayer.sublayers?.forEach { ($0 as? BlobLayer)?.animate(speed: speed) }
        
//        // Animate highlight layer with its own timing
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 / (speed * 1.5)) { [weak self] in
//            self?.highlightLayer.sublayers?.forEach { ($0 as? BlobLayer)?.animate(speed: self?.speed ?? 1.0 * 1.5) }
//        }
        
        // Reanimate base layer
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 / speed) { [weak self] in
            self?.animate()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        baseLayer.frame = bounds
        highlightLayer.frame = bounds
        blurEffectView.frame = bounds
    }
}
