//
//  Scene.swift
//  IOSUtils
//
//  Created by The WORLD on 17.01.2024.
//

// MARK: Load Theme from USERDEFAULTS and Open VC
/// USE THIS METHOD IN SCENEDELEGATE

import UIKit

func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)
    window?.windowScene = windowScene
    if loadedTheme == UserDef.Theme.light.rawValue {
        window?.overrideUserInterfaceStyle = .light
    } else if loadedTheme == UserDef.Theme.dark.rawValue {
        window?.overrideUserInterfaceStyle = .dark
    } else {
        window?.overrideUserInterfaceStyle = .unspecified
    }
    
    window?.rootViewController = UIViewController()
    window?.makeKeyAndVisible()
}
