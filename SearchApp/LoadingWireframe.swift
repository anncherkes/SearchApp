//
//  LoadingWireframe.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol BaseWireframe {
    func build() -> UIViewController
    var navigationController: UINavigationController! { set get }
}

public class LoadingWireframe {
    public func installRootViewControllerIntoWindow(window: UIWindow) {        
        window.rootViewController = loadRepositories(window: window)
        window.makeKeyAndVisible()
    }
    
    private func loadRepositories(window: UIWindow) -> UIViewController {
        let wireframe: SearchWireframe = SearchWireframe()
        let navigationController = UINavigationController(rootViewController: wireframe.build())
        wireframe.navigationController = navigationController
        return navigationController
    }
}

