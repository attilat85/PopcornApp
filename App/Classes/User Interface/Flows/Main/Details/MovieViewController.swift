//
//  MovieViewController.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 23/03/2020.
//

import UIKit
import Kingfisher

class MovieViewController: BaseViewController {
    
    private let viewModel: MovieViewModel
    
    private var titleLabel = UILabel.autoLayout()
    private var yearLabel = UILabel.autoLayout()
    private var posterImage = UIImageView.autoLayout()
    private var descriptionContainer = UIView.autoLayout()
    private var scrollView = UIScrollView.autoLayout()
    
    // MARK: - Lifecycle
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavigationBar()
        initUI()
        initLayout()
    }
    
    // MARK: - Action
    
    private func initUI() {
        view.backgroundColor = Asset.Colors.blue.color
        // add content to scrollview id the description if the content is longer than the screen
        view.addSubview(scrollView)
        
        titleLabel.text = viewModel.title
        titleLabel.font = Font.regular(size: .extraLarge)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        scrollView.addSubview(titleLabel)
        
        yearLabel.text = viewModel.year
        yearLabel.font = Font.light(size: .extraLarge)
        yearLabel.textColor = .white
        scrollView.addSubview(yearLabel)
        
        posterImage.contentMode = .scaleAspectFit
        scrollView.addSubview(posterImage)
        posterImage.kf.setImage(with: viewModel.imageUrl, placeholder: Asset.Images.noImage.image)
        
        descriptionContainer.backgroundColor = .white
        scrollView.addSubview(descriptionContainer)
        
        initDescriptionContainer()
    }
    
    private func initLayout() {
        var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding4-[titleLabel][yearLabel]-padding4-[posterImage]-padding4-[description]",
                                                                               options: [.alignAllLeading, .alignAllTrailing],
                                                                               metrics: ["padding": CGFloat.padding,"padding4": CGFloat.padding4x],
                                                                               views: ["titleLabel": titleLabel, "yearLabel": yearLabel, "posterImage": posterImage, "description": descriptionContainer])
        constraints += [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding4x),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            descriptionContainer.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func initDescriptionContainer() {
        let rateView = RateView.autoLayout()
        rateView.viewModel = viewModel.rateViewModel
        descriptionContainer.addSubview(rateView)
        
        let detailLabel = UILabel.autoLayout()
        detailLabel.text = viewModel.genres
        detailLabel.font = Font.light(size: .small)
        detailLabel.numberOfLines = 0
        detailLabel.textColor = .gray
        detailLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionContainer.addSubview(detailLabel)
        
        let lineView = UIView.autoLayout()
        lineView.backgroundColor = .lightGray
        descriptionContainer.addSubview(lineView)
        
        let descriptionLabel = UILabel.autoLayout()
        descriptionLabel.text = viewModel.description
        descriptionLabel.font = Font.regular(size: .medium)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionContainer.addSubview(descriptionLabel)
        
        var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraints(withVisualFormat: "V:|-padding2-[rateView]-padding2-[detailLabel]-padding-[lineView(lineHeight)]-padding2-[description]-padding2-|",
                                                                               metrics: ["padding": CGFloat.padding,"padding2": CGFloat.padding2x, "lineHeight": CGFloat.border],
                                                                               views: ["rateView": rateView, "detailLabel": detailLabel, "lineView": lineView, "description": descriptionLabel])
        constraints += [
            rateView.leadingAnchor.constraint(greaterThanOrEqualTo: descriptionContainer.leadingAnchor, constant: .padding2x),
            rateView.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -.padding2x),
            
            detailLabel.leadingAnchor.constraint(greaterThanOrEqualTo: descriptionContainer.leadingAnchor, constant: .padding2x),
            detailLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -.padding2x),
            
            lineView.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionContainer.leadingAnchor, constant: .padding2x),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionContainer.trailingAnchor, constant: -.padding2x)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Action
    
    override func backButtonSelected() {
        viewModel.backButtonSelected()
    }
    
}
