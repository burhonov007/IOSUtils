//
//  CameraAlert.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: ALERT which request access to the camera and REDIRECT to SETTINGS

import UIKit

func accessCameraAlert() {
    let alertController = UIAlertController(title: "Доступ к камере", message: "Для QR оплаты необходимо включить доступ к камере в найстройках вашего IPhone-а", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel))
    alertController.addAction(UIAlertAction(title: "Настройки", style: .default, handler: { _ in
        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
        }
    }))
    present(alertController, animated: true)
}
