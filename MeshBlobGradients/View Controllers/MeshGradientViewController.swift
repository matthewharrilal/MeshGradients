//
//  MeshGradientViewController.swift
//  MeshBlobGradients
//
//  Created by Space Wizard on 8/27/24.
//

import UIKit
import CoreMotion


class MeshGradientViewController: UIViewController {

    private var gradientView: FluidGradientView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientView()
        startAnimatingBlobs()
    }

    private func setupGradientView() {
        gradientView = FluidGradientView(frame: .zero)
        gradientView.layer.cornerRadius = 16
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.clipsToBounds = true
        gradientView.layer.masksToBounds = true

        view.addSubview(gradientView)
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            gradientView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            gradientView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            gradientView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            gradientView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
    }

    private func startAnimatingBlobs() {
        // Base layer with darker, muted colors
        let baseColorPool: [UIColor] = [
            UIColor(hex: "#2C3E50"),  // Dark blue-gray
            UIColor(hex: "#34495E"),  // Muted dark blue
            UIColor(hex: "#7F8C8D"),  // Desaturated gray-blue
            UIColor(hex: "#95A5A6"),  // Soft gray
            UIColor(hex: "#1F2C3D")   // Very dark blue-gray
        ]
        
        // Highlight layer with brighter, vibrant colors
        // Highlight layer with new vibrant colors
        let highlightColorPool: [UIColor] = [
            UIColor(hex: "#00FF7F"),  // Spring green
            UIColor(hex: "#FF1493"),  // Deep pink
            UIColor(hex: "#00BFFF"),  // Deep sky blue
            UIColor(hex: "#FF4500"),  // Orange red
            UIColor(hex: "#32CD32")   // Lime green
        ]
        
        gradientView.create(highlightColorPool.shuffled(), layer: gradientView.baseLayer)
        gradientView.create(highlightColorPool.shuffled(), layer: gradientView.highlightLayer)
        gradientView.update(speed: 0.2)
    }
}
