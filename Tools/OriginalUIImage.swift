//
//  OriginalUIImage.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Get UIImage with ORIGINAL rendering mode

import UIKit

class OriginalUIImage: UIImage {

    convenience init?(named name: String) {
        guard let image = UIImage(named: name), nil != image.cgImage else { return nil }
        self.init(cgImage: image.cgImage!)
    }

    override func withRenderingMode(_ renderingMode: UIImage.RenderingMode) -> UIImage { return self }
}

// MARK: USAGE

/// marker.glyphImage = OriginalUIImage(named: "bank")
