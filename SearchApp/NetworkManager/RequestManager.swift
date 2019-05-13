//
//  RequestManager.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON

public protocol Request {
    func request<T:Decodable>(url: String, method: Method, parameters: [URLQueryItem], completion: @escaping (T?, NSError?) -> Swift.Void)
}

public class DefaultRequest: Request {
    
    public init() {}
    
    public func request<T:Decodable>(url: String, method: Method, parameters: [URLQueryItem], completion: @escaping (T?, NSError?) -> Swift.Void) {
        
        guard let finalUrl = buidUrl(url, parameters: parameters) else {
            completion(nil, NSError.init(domain: NetworkServiceError.badUrl.rawValue, code: 0, userInfo: nil))
            return
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error.debugDescription)")
                completion(nil, error as NSError?)
                return
            }
            
            let json = JSON(data)

            guard let newData = try? json.rawData() else {
                completion(nil, NSError.init(domain: NetworkServiceError.networkDomain.rawValue, code: 0, userInfo: nil))
                return
            }
            
            let decoder = JSONDecoder()

            guard let items = try? decoder.decode(T.self , from: newData) else {
                completion(nil, NSError(domain: "Can't parse data for entity \(T.self)", code: 0))
                return
            }
            
            completion(items, nil)
            
        }
        task.resume()
    }
    
    private func buidUrl(_ url: String, parameters: [URLQueryItem]) -> URL? {
        
        guard let urlRequest = URL(string: url) else {
            return nil
        }
        
        var urlComponents = URLComponents(string: urlRequest.absoluteString)
        urlComponents?.queryItems = parameters
        guard let finalUrl = urlComponents?.url else { return urlRequest }
        return finalUrl
    }
    
}

