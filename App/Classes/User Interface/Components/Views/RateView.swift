//
//  RateView.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 23/03/2020.
//

import UIKit

class RateView: UIView {
    
    var viewModel: RateViewModel? {
        didSet {
            avgRateLabel.attributedText = viewModel?.avgRate
            rateCountsLabel.text = viewModel?.rateCount
        }
    }
    
    let rateStackView = UIStackView.autoLayout()
    let avgRateLabel = UILabel.autoLayout()
    let rateCountsLabel = UILabel.autoLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI() {
        rateStackView.axis = .horizontal
        rateStackView.alignment = .center
        rateStackView.distribution = .fillProportionally
        rateStackView.snap(into: self)
        
        let flexibleView = UIView()
        flexibleView.translatesAutoresizingMaskIntoConstraints = false
        flexibleView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        rateStackView.addArrangedSubview(flexibleView)
        
        let starImage = UIImageView.autoLayout()
        starImage.contentMode = .scaleAspectFit
        starImage.image = Asset.Images.yellowStar.image.resizeImage(size: CGSize(width: 20, height: 20))
        starImage.setContentHuggingPriority(.required, for: .horizontal)
        rateStackView.addArrangedSubview(starImage)
        
        let stackView = UIStackView.autoLayout()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        rateStackView.addArrangedSubview(stackView)
        
        avgRateLabel.font = Font.regular(size: .mediumSmall)
        stackView.addArrangedSubview(avgRateLabel)
        
        rateCountsLabel.font = Font.regular(size: .extraSmall)
        rateCountsLabel.textColor = .lightGray
        stackView.addArrangedSubview(rateCountsLabel)
    }
}
