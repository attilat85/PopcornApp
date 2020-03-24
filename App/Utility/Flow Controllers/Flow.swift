//
//  Flow.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 04/10/2018.
//  Copyright © 2018 Halcyon Mobile. All rights reserved.
//

import UIKit

protocol Flow: class {
    associatedtype Scene: UIViewController
    func start() -> Scene
}

extension Flow {

    func openApplicationSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
