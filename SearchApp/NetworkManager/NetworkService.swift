//
//  NetworkService.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public enum NetworkServiceError: String {
    case networkDomain = "NetworkErrorDomain"
    case badUrl = "badUrl"
    case gifNotFound = "gifNotFound"
}

public enum Method: String {
    case post = "POST"
    case get = "GET"
}

public class NetworkService {
    public let requestManager: Request
    public init(requestManager: Request = DefaultRequest()) {
        self.requestManager = requestManager
    }
}
