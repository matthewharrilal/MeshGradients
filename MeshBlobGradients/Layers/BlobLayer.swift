//
//  BlobLayer.swift
//  MeshBlobGradients
//
//  Created by Space Wizard on 8/27/24.
//

import UIKit

class BlobLayer: CAGradientLayer {
    init(color: UIColor) {
        super.init()
        
        self.type = .radial
        
        set(color: color)
        
        let position = newPosition()
        self.startPoint = position
        
        let radius = newRadius()
        self.endPoint = position.displace(by: radius)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    func newPosition() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0.0...1.0),
                       y: CGFloat.random(in: 0.0...1.0)).capped()
    }
    
    func newRadius() -> CGPoint {
        let size = CGFloat.random(in: 0.15...0.70)
        let viewRatio = frame.width/frame.height
        let safeRatio = max(viewRatio.isNaN ? 1 : viewRatio, 1)
        let ratio = safeRatio * CGFloat.random(in: 0.25...1.75)
        return CGPoint(x: size, y: size * ratio)
    }
    
    func animate(speed: CGFloat) {
        guard speed > 0 else { return }
        
        removeAllAnimations()
        let currentLayer = presentation() ?? self
        
        let position = newPosition()
        let radius = newRadius()
        
        let positionAnimation = CABasicAnimation(keyPath: "startPoint")
        positionAnimation.fromValue = currentLayer.startPoint
        positionAnimation.toValue = position
        positionAnimation.duration = CFTimeInterval(1.0 / speed)
        positionAnimation.isRemovedOnCompletion = false
        positionAnimation.fillMode = .forwards
        
        let endPointAnimation = CABasicAnimation(keyPath: "endPoint")
        endPointAnimation.fromValue = currentLayer.endPoint
        endPointAnimation.toValue = position.displace(by: radius)
        endPointAnimation.duration = CFTimeInterval(1.0 / speed)
        endPointAnimation.isRemovedOnCompletion = false
        endPointAnimation.fillMode = .forwards
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        let opacityValue = Float.random(in: 0.5...1)
        opacityAnimation.fromValue = self.opacity
        opacityAnimation.toValue = opacityValue
        opacityAnimation.duration = CFTimeInterval(1.0 / speed)
        opacityAnimation.isRemovedOnCompletion = false
        opacityAnimation.fillMode = .forwards
        
        self.startPoint = position
        self.endPoint = position.displace(by: radius)
        self.opacity = opacityValue
        
        add(positionAnimation, forKey: "startPointAnimation")
        add(endPointAnimation, forKey: "endPointAnimation")
        add(opacityAnimation, forKey: "opacityAnimation")
    }
    
    func set(color: UIColor) {
        self.colors = [color.cgColor,
                       color.cgColor,
                       color.withAlphaComponent(0.0).cgColor]
        self.locations = [0.0, 0.9, 1.0]
    }
}

extension CGPoint {
    func displace(by point: CGPoint = .init(x: 0.0, y: 0.0)) -> CGPoint {
        return CGPoint(x: self.x + point.x,
                       y: self.y + point.y)
    }
    
    func capped() -> CGPoint {
        return CGPoint(x: max(min(x, 1), 0),
                       y: max(min(y, 1), 0))
    }
}
