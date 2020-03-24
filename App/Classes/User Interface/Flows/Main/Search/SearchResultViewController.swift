//
//  SearchViewController.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import UIKit
import RxSwift

private enum Section: Int {
    case movies, loading
}

private enum ReuseIdentifier {
    static let header = "reuseIdentifier.header"
    static let empty = "reuseIdentifier.empty"
}

class SearchResultViewController: BaseViewController {
    
    private let viewModel: SearchResultViewModel
    private let disposeBag = DisposeBag()
    private var searchController: UISearchController!
    private let searchField = UITextField()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = .padding2x
        layout.sectionInset = UIEdgeInsets(top: .padding2x, left: .leftInset, bottom: .padding2x, right: .padding2x)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var loadingIndicator: UIActivityIndicatorView?
    
    // MARK: - Lifecycle
    
    init(viewModel: SearchResultViewModel) {
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
        initBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchField.becomeFirstResponder()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - UI
    
    private func initUI() {
        view.backgroundColor = Asset.Colors.blue.color
        
        let darkBlueView = UIView.autoLayout()
        darkBlueView.backgroundColor = Asset.Colors.darkBlue.color
        view.addSubview(darkBlueView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(cellType: SearchResultCell.self)
        collectionView.register(cellType: LoadingCell.self)
        collectionView.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.empty)
        collectionView.snap(into: view)
        
        NSLayoutConstraint.activate([
            darkBlueView.topAnchor.constraint(equalTo: view.topAnchor),
            darkBlueView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            darkBlueView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            darkBlueView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.33)
        ])
        
        showLoadingIndicator(true)
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        if show {
            if loadingIndicator == nil {
                loadingIndicator = UIActivityIndicatorView(style: .whiteLarge)
                loadingIndicator?.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(loadingIndicator!)
                
                NSLayoutConstraint.activate([
                    loadingIndicator!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    loadingIndicator!.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                    
                ])
            }
            loadingIndicator?.startAnimating()
        } else {
            loadingIndicator?.removeFromSuperview()
            loadingIndicator = nil
        }
    }
    
    // MARK: - Action
    
    override func backButtonSelected() {
        viewModel.backButtonSelected()
    }
    
    // MARK: - Logic
    
    private func initBinding() {
        
        viewModel.cellModels.bind { [weak self] _ in
            self?.showLoadingIndicator(false)
            self?.collectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}

// MARK: - UICollectionView Delegate / Datasource

extension SearchResultViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.hasLoadMore ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        section == Section.movies.rawValue ? viewModel.cellModels.value.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        indexPath.section == Section.movies.rawValue ? CGSize(width: collectionView.frame.size.width - .leftInset - .padding2x, height: 120) : CGSize(width: collectionView.frame.size.width, height:50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Section.movies.rawValue {
            if let model = viewModel.cellModels.value[safe: indexPath.row] {
                print(indexPath, " - ", model.title)
                let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: SearchResultCell.self)
                cell.viewModel = model
                return cell
            }
        } else {
            return collectionView.dequeueReusableCell(for: indexPath, cellType: LoadingCell.self)
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.section == Section.loading.rawValue {
            viewModel.loadMore()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        section == Section.movies.rawValue  && !viewModel.cellModels.value.isEmpty ? CGSize(width: collectionView.frame.width, height: 70) : .zero
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == Section.movies.rawValue,
            kind == UICollectionView.elementKindSectionHeader,
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseIdentifier.header, for: indexPath) as? CollectionHeaderView {
            header.textLabel.text = viewModel.query
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ReuseIdentifier.empty, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: AnimationDuration.normal, delay: 0, options: .allowUserInteraction, animations: {
            cell?.contentView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        })
    }
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        UIView.animate(withDuration: AnimationDuration.normal, delay: 0, options: .allowUserInteraction, animations: {
            cell?.contentView.backgroundColor = .white
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath.row)
    }
    
}
