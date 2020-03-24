//
//  UIViewController+Error.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 05/08/2019.
//  Copyright © 2019 Halcyon Mobile. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert(for error: Error) {
        let alert = UIAlertController(title: L10n.ooups, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "", style: .default))
        present(alert, animated: true)
    }
}
