//
//  FlowDelegate.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//
import UIKit

protocol FlowDelegate: AnyObject {
    func presentAlert(with title: String?, message: String?, declineable: Bool, destructive: Bool, completion: ((UIAlertAction) -> Void)?)
    func presentAlert(with title: String?, message: String?, dismissed: (() -> Void)?)
    func showAlert(for error: Error)
    func didTapClose()
    func didTapBack()
}

extension NavigationFlow {
    
     /// Used for presenting an alert if there is already a nav controller presented in the hierarchy, if not, the default nav controller will make the presentation
    var navController: UINavigationController? {
        return navigationController?.presentedViewController as? UINavigationController ?? navigationController
    }
    
    func presentAlert(with title: String?, message: String?, dismissed: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .default) { _ in
            self.navController?.dismiss(animated: true, completion: dismissed)
        })
        navController?.present(alert, animated: true, completion: nil)
    }
    
    func presentAlert(with title: String?, message: String?, declineable: Bool = false, destructive: Bool = false, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if declineable {
            alert.addAction(UIAlertAction(title: L10n.yes, style: destructive ? .destructive : .default, handler: completion))
            alert.addAction(UIAlertAction(title: L10n.no, style: .default, handler: nil))
        } else {
            alert.addAction(UIAlertAction(title: L10n.ok, style: .default, handler: completion))
        }
        navController?.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(for error: Error) {
        let alert = UIAlertController(title: "Ooups", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: L10n.ok, style: .default))
        navController?.present(alert, animated: true)
    }
    
    func didTapClose() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
