//
//  CollectionHeaderView.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 22/03/2020.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
        
    let textLabel = UILabel.autoLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel.textColor = .white
        textLabel.font = Font.light(size: .extraLarge)
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .leftInset),
            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -.padding2x),
            textLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor,constant: .padding2x ),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -.padding2x)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
