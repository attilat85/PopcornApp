//
//  BaseViewController.swift
//  iOS Starter Project
//
//  Created by Andrei Matea on 02/09/2019.
//

import UIKit

// NOTE: Subclass each view controller from this class

class BaseViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Public methods to be overriden
    
    func customizeNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        let image = Asset.Images.back.image.resizeImage(size: CGSize(width: 60, height: 60))
        let backButton = UIButton(frame: .zero)
        backButton.setImage(image.withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonSelected), for: .touchUpInside)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.imageView?.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let logoImage = Asset.Images.appLogoSmall.image.resizeImage(size: CGSize(width: 60, height: 60))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIImageView(image: logoImage))
    }
    
    @objc func backButtonSelected() {}
}
