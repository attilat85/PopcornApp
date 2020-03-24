//
//  LoadingCell.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 22/03/2020.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    
    private var loadingIndicator = UIActivityIndicatorView(style: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .clear
        
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding2x),
            loadingIndicator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -.padding2x)
        ])
        
        loadingIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        loadingIndicator.startAnimating()
    }
}
