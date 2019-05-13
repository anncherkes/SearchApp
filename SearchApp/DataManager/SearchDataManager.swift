//
//  SearchDataManager.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol SearchDataManagerProtocol {
    func searchWith(value: String, completionHandler: @escaping (GifDTO?, NSError?) -> Void)
}

public class SearchDataManager: NSObject, SearchDataManagerProtocol {

    private var network: SearchNetworkManagerProtocol
    
    public init(network: SearchNetworkManagerProtocol = SearchNetworkManager()) {
        self.network = network
    }
    
    public func searchWith(value: String, completionHandler: @escaping (GifDTO?, NSError?) -> Void) {
        network.search(value: value) { [weak self] (item, error) in
            
            guard let `self` = self else { return }
            
            if let gifItem = item {
                let gifDTOItem = self.mutated(gifItem)
                
                if gifDTOItem.url == nil || gifDTOItem.id == nil  {
                    completionHandler(nil, NSError.init(domain: NetworkServiceError.gifNotFound.rawValue, code: 0, userInfo: nil) )
                } else {
                    completionHandler(gifDTOItem, nil)
                }
                
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
    private func mutated(_ item: GIFItem) -> GifDTO {
        return GifDTO(item)
    }
}
