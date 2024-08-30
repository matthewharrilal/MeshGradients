# MeshBlobGradients

MeshBlobGradients is the UIKit counterpart to [FluidGradient](https://github.com/Cindori/FluidGradient), designed to demonstrate a similar fluid, animated gradient effect using `CAGradientLayer`. Unlike its SwiftUI counterpart, this implementation is not easily customizable without modifying the internal codebase.

## Overview

This project leverages `CAGradientLayer` to create multiple sublayers within a view, each representing a blob of color. Core Animation is used to animate the position and opacity of these blobs, generating a dynamic, ever-changing gradient effect. The animations are driven by random points and speed variations, resulting in a visually engaging experience.



https://github.com/user-attachments/assets/690cf664-5561-43c5-8d4b-3c02ecdebe8a



## Key Features

- **UIKit-Based Implementation:** Entirely built using UIKit, providing a traditional approach to iOS UI development.
- **Multi-Sublayer Animations:** Each gradient is created by adding multiple sublayers to the view, each with independent animation properties.
- **Randomized Motion:** Positions, radii, and speeds of animations are randomized, creating a fluid, organic effect.

## Installation

Clone the repository and open the project in Xcode.

```bash
git clone https://github.com/yourusername/MeshBlobGradients.git
cd MeshBlobGradients
open MeshBlobGradients.xcodeproj
