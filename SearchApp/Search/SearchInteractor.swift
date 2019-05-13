//
//  SearchInteractor.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol SearchInteractorProtocol {
    func searchWith(_ value: String, completionHandler: @escaping (GifDTO?, NSError?) -> Void)
    func setAllItems() -> [GifDTO]
    func save(_ item: GifDTO)
}

public class SearchInteractor: NSObject, SearchInteractorProtocol {
    
    private var dataManager: SearchDataManagerProtocol
    private var dataBaseManager: SearchDataBaseManagerProtocol
    
    public init(dataManager: SearchDataManagerProtocol = SearchDataManager(),
                dataBaseManager: SearchDataBaseManagerProtocol = SearchDataBaseManager()) {
        self.dataManager = dataManager
        self.dataBaseManager = dataBaseManager
    }
    
    public func searchWith(_ value: String, completionHandler: @escaping (GifDTO?, NSError?) -> Void) {
        dataManager.searchWith(value: value) { (item, error) in
            completionHandler(item, error)
        }
    }
    
    public func setAllItems() -> [GifDTO] {
        return dataBaseManager.getGifts().reversed()
    }
    
    public func save(_ item: GifDTO) {
        dataBaseManager.saveData(item)
    }
}
