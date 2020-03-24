//
//  TrendingCollectionViewCell.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import UIKit
import Kingfisher

class TrendingCell: UICollectionViewCell {
    
    static let size = CGSize(width: 150, height:225)
    
    var viewModel: TrendingCellViewModel? {
        didSet {
            imageView?.kf.setImage(with: viewModel?.url)
        }
    }
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView  = UIImageView()
        imageView?.contentMode = .scaleAspectFill
        imageView?.snap(into: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
