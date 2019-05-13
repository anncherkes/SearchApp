//
//  SearchNetworkManager.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public protocol SearchNetworkManagerProtocol {
    func search(value: String,completionHandler: @escaping (GIFItem?, NSError?) -> Void)
}

public class SearchNetworkManager: NetworkService, SearchNetworkManagerProtocol {
    
    public func search(value: String, completionHandler: @escaping (GIFItem?, NSError?) -> Void) {
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "api_key", value: API_KEY))
        queryItems.append(URLQueryItem(name: "q", value: value))
        queryItems.append(URLQueryItem(name: "limit", value: "1"))
        
        requestManager.request(url: BASE_URL, method: .get, parameters: queryItems) { (item, error) in
            completionHandler(item, error)
        }
    }
}
