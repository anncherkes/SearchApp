//
//  SearchWireframe.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol SearchWireframeProtocol: BaseWireframe {
    
}

public class SearchWireframe: SearchWireframeProtocol {

    public var navigationController: UINavigationController!
    
    public func build() -> UIViewController {
        
        let viewController = createSearchViewController()
        let presenter = SearchPresenter()
        let interactor = SearchInteractor()
        
        viewController.presenter = presenter
        
        presenter.wireframe = self
        presenter.interactor = interactor
        presenter.view = viewController
        
        return viewController
    }
    
    private func createSearchViewController() -> SearchViewController {
        return SearchViewController()
    }
}
