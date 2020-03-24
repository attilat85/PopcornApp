//
//  SearchResultCell.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 22/03/2020.
//

import UIKit
import Kingfisher

class SearchResultCell: UICollectionViewCell {
    let posterImageView = UIImageView.autoLayout()
    
    let rateView = RateView.autoLayout()
    let textStackView = UIStackView.autoLayout()
    let titleLabel = UILabel.autoLayout()
    let yearLabel = UILabel.autoLayout()
    let footerLabel = UILabel.autoLayout()
    
    var viewModel: SearchResultCellViewModel? {
        didSet {
            update()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI
    
    private func initUI() {
        contentView.backgroundColor = .white
        contentView.clipsToBounds = true
        
        posterImageView.contentMode = .scaleAspectFill
        contentView.addSubview(posterImageView)
        
        contentView.addSubview(rateView)
        
        titleLabel.font = Font.regular(size: .mediumLarge)
        titleLabel.numberOfLines = 0
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        contentView.addSubview(titleLabel)
        
        yearLabel.font = Font.light(size: .mediumLarge)
        yearLabel.textColor = .gray
        yearLabel.setContentHuggingPriority(.required, for: .vertical)
        contentView.addSubview(yearLabel)
        
        footerLabel.font = Font.light(size: .extraSmall)
        footerLabel.numberOfLines = 0
        footerLabel.textColor = .gray
        footerLabel.setContentHuggingPriority(.required, for: .vertical)
        contentView.addSubview(footerLabel)
    }
    
    private func initLayout() {
        var constraints: [NSLayoutConstraint] = []
        constraints += [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 80),
            
            rateView.leadingAnchor.constraint(greaterThanOrEqualTo: posterImageView.trailingAnchor),
            rateView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: .padding),
            rateView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding2x),
            
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: rateView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: .padding2x),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -.padding2x)
            
        ]
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "V:[titleLabel][yearLabel][footerLabel]-8-|",
                                                      options: [.alignAllLeading, .alignAllTrailing], metrics: nil,
                                                      views: ["titleLabel": titleLabel, "yearLabel": yearLabel, "footerLabel": footerLabel])
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Logic

    // this method will be called every time the cell is reused and a new viewmodel is set to the cell
    private func update() {
        posterImageView.kf.setImage(with: viewModel?.imageUrl, placeholder: Asset.Images.noImage.image)
        rateView.viewModel = viewModel?.rateViewModel
        titleLabel.text = viewModel?.title
        yearLabel.text = viewModel?.year
        footerLabel.text = viewModel?.footer
    }
}
