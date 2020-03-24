//
//  MainFlow.swift
//  Project_RaverR
//
//  Created by Andrei Matea on 02/09/2019.
//

import UIKit

class MainComponent: Component<RootComponent> {
    
    lazy var searchService: SearchService = parent.parent.searchService
    lazy var homeService: HomeService = parent.parent.homeService
    
    override init(parent: RootComponent) {
        super.init(parent: parent)
    }
}

// This will be the main flow. Usually this starts after authentication.
class MainFlow: NavigationFlow {
    var navigationController: UINavigationController?
    
    func firstScene() -> UIViewController {
        let viewModel = HomeViewModelImpl(homeService: component.homeService)
        viewModel.flowDelegate = self
        return HomeViewController(viewModel: viewModel)
    }
    
    private let component: MainComponent
    
    init(component: MainComponent) {
        self.component = component
    }
}

// MARK: - Search / Home FlowDelegate

extension MainFlow: HomeFlowDelegate, SearchResultFlowDelegate {
    
    func search(text: String) {
        // here can be added a nicer animation with custom transition
        let viewModel = SearchResultViewModelImpl(query: text, searchService: component.searchService)
        viewModel.flowDelegate = self
        navigationController?.pushViewController(SearchResultViewController(viewModel: viewModel), animated: true)
    }
    
    func didSelect(movie: Movie) {
        let viewModel = MovieViewModelImpl(movie: movie)
        viewModel.flowDelegate = self
        navigationController?.pushViewController(MovieViewController(viewModel: viewModel), animated: true)
    }
}
