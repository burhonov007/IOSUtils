//
//  SetupCamera.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: This method setup CAMERA's SESSION

import UIKit

func setupCamera() {
    guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video),
          let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
    let output = AVCaptureMetadataOutput()
    qrView.session.addInput(input)
    qrView.session.addOutput(output)
    qrView.video = AVCaptureVideoPreviewLayer(session: qrView.session)
    if let windowFrame = UIApplication.shared.windows.first?.frame {
        qrView.video.frame = CGRect(x: 0, y: 0, width: windowFrame.width, height: windowFrame.height)
    }
    qrView.video.videoGravity = .resizeAspectFill
    qrView.cameraView.layer.addSublayer(qrView.video)
}
