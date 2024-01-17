//
//  TurnOnFlashLight.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: This method turns on FLASHLIGHT

import UIKit

func turnOnFlashlight() {
    guard let device = AVCaptureDevice.default(for: .video), device.hasTorch else { return }
    if device.isTorchAvailable {
        try? device.lockForConfiguration()
        if device.torchMode == AVCaptureDevice.TorchMode.off {
            device.torchMode = AVCaptureDevice.TorchMode.on
            qrView.flashlightImg.tintColor = .yellow
        } else {
            device.torchMode = AVCaptureDevice.TorchMode.off
            qrView.flashlightImg.tintColor = UIColor(named: "btnTitleColor")
        }
        device.unlockForConfiguration()
    }
}
