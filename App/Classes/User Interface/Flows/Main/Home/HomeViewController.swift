//
//  HomeViewController.swift
//  PopcornApp
//
//  Created by Atti's Macbbok pro on 21/03/2020.
//

import UIKit
import RxSwift
import RxCocoa

private enum ReuseIdentifier {
    static let header = "headerReuseIdentifier"
}

class HomeViewController: BaseViewController {

    private let logoImageView = UIImageView.autoLayout()
    private let searchField = UITextField.autoLayout()
    private let searchImageView = UIImageView.autoLayout()
    private let searchStackView = UIStackView()
    private let line = UIView.autoLayout()
    private let trendingTitleLabel = UILabel.autoLayout()
    private var trendingCollectionView: UICollectionView!
    private var searchFielsCenterYconstraint :NSLayoutConstraint?
    
    private lazy var suggestionTableView: UITableView = {
        let table = UITableView.autoLayout()
        table.delegate = self
        table.dataSource = self
        table.register(cellType: UITableViewCell.self)
        table.tableFooterView = UIView()
        return table
    }()
    
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        initLayout()
        signUpForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animate: Bool) {
        super.viewWillAppear(animate)
        searchField.text = nil
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    deinit {
        ///remove all observers from the view controller
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI
    
    /// setup, place and customize the UI components
    private func initUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true

        // image is from android desing and are too big
        logoImageView.image = Asset.Images.appLogoSmall.image.resizeImage(size: CGSize(width: 75, height: 100))
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        searchStackView.axis = .horizontal
        searchStackView.distribution = .fillProportionally
        searchStackView.alignment = .center
        searchStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchStackView)
        
        let string = L10n.findTheMovie
        let placeholder = NSMutableAttributedString(string: string)
        placeholder.addAttributes([.font: Font.regular(size: .extraLarge), .foregroundColor: UIColor.gray], range: NSRange(location: 0, length: string.count))
        placeholder.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(string.range(of: "Find")!, in: string))
        searchField.attributedPlaceholder = placeholder
        searchField.delegate = self
        searchField.font = Font.bold(size: .extraLarge)
        searchField.returnKeyType = .search
        searchField.setContentHuggingPriority(.required, for: .vertical)
        searchStackView.addArrangedSubview(searchField)
        
        searchImageView.image = Asset.Images.search.image.resizeImage(size: CGSize(width: 30, height: 30))
        searchImageView.contentMode = .scaleAspectFit
        searchStackView.addArrangedSubview(searchImageView)
        
        line.backgroundColor = .black
        searchField.addSubview(line)
        
        trendingTitleLabel.text = L10n.trendingMovies
        trendingTitleLabel.font = Font.regular(size: .mediumLarge)
        view.addSubview(trendingTitleLabel)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = TrendingCell.size
        layout.minimumInteritemSpacing = .padding
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: .padding2x, bottom: 0, right: .padding2x)
        
        trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        trendingCollectionView.register(cellType: TrendingCell.self)
        trendingCollectionView.backgroundColor = .white
        view.addSubview(trendingCollectionView)
    }
    
    /// setup constraints for the layout
    func initLayout() {
        searchFielsCenterYconstraint = searchStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: searchField.leadingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: searchField.topAnchor, constant: -.padding2x),
            
            searchStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .padding2x),
            
            searchStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.padding2x),
            searchFielsCenterYconstraint!,
            searchImageView.heightAnchor.constraint(equalTo: searchField.heightAnchor, constant: -.padding),
            
            line.leadingAnchor.constraint(equalTo: searchStackView.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: searchStackView.trailingAnchor),
            line.bottomAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: .border),
            
            trendingCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -.padding2x),
            trendingCollectionView.heightAnchor.constraint(equalToConstant: TrendingCell.size.height),
            
            trendingTitleLabel.leadingAnchor.constraint(equalTo: trendingCollectionView.leadingAnchor, constant: .padding2x),
            trendingTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trendingCollectionView.trailingAnchor, constant: -.padding2x),
            trendingTitleLabel.bottomAnchor.constraint(equalTo: trendingCollectionView.topAnchor, constant: -.padding2x)
            
        ])
    }
    
    private func showSuggestionTable() {
        view.addSubview(suggestionTableView)
        suggestionTableView.reloadData()
        
        NSLayoutConstraint.activate([
            suggestionTableView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor, constant: .padding2x),
            suggestionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            suggestionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            suggestionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }

    // MARK: - Logic
    
    /// if cell models list is changed then reload should be called
    private func initBinding() {
        viewModel.cellModels.bind { [weak self] _ in
            self?.trendingCollectionView.reloadData()
        }.disposed(by: disposeBag)
    }
}

/// handle keyboard notification, so if the the suggestion table content don't go under the keyboard
extension HomeViewController {
    
    private func signUpForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let (height, duration) = keyboardParameters(userInfo: userInfo)
        
        UIView.animate(withDuration: duration) { [weak self] in
            self?.suggestionTableView.contentInset.bottom = height
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        
        let (_, duration) = keyboardParameters(userInfo: userInfo)
        UIView.animate(withDuration: duration) { [weak self] in
            self?.suggestionTableView.contentInset.bottom = self?.view.safeAreaInsets.bottom ?? 0
        }
    }
    
    private func keyboardParameters(userInfo: [AnyHashable: Any]) -> (CGFloat, TimeInterval) {
        let height: CGFloat = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.size.height ?? 0
        let duration = TimeInterval((userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0)
        return (height, duration)
    }
}

// MARK: - UICollectionView Delegate / Datasource

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cellModels.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let model = viewModel.cellModels.value[safe: indexPath.row] {
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TrendingCell.self)
            cell.viewModel = model
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItem(at: indexPath.row)
    }
}

// MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        searchFielsCenterYconstraint?.constant = -(logoImageView.frame.minY - view.safeAreaInsets.top)
        UIView.animate(withDuration: AnimationDuration.normal, animations: {
            self.view.layoutIfNeeded()
        }, completion: { [weak self] _ in
            self?.viewModel.updateSuggestions()
            self?.showSuggestionTable()
        })
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        suggestionTableView.removeFromSuperview()
        
        searchFielsCenterYconstraint?.constant = 0
        UIView.animate(withDuration: AnimationDuration.normal) {
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // start search only if the input field is not empty
        if let text = textField.text, !text.isEmpty {
            viewModel.search(text: text)
        }
        return true
    }
}

// MARK: - UITableView DataSource / Delegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.suggestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: UITableViewCell.self)
        cell.textLabel?.font = Font.regular(size: .medium)
        cell.textLabel?.text = viewModel.suggestions[safe: indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        searchField.resignFirstResponder()
        
        if let text = viewModel.suggestions[safe: indexPath.row] {
            viewModel.search(text: text)
        }
    }
    
}
