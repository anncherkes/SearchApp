//
//  SearchDataBaseManager.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import Foundation
import RealmSwift

public protocol SearchDataBaseManagerProtocol {
    func saveData(_ item: GifDTO)
    func getGifts() -> [GifDTO]
}

public class SearchDataBaseManager: SearchDataBaseManagerProtocol {
    
    public init() {}
    
    private let realm = try! Realm()
    
    public func saveData(_ item: GifDTO) {
        
        let gifObject = GifObject()
        
        if let title = item.title {
            gifObject.title = title
        }
        
        if let url = item.url {
            gifObject.urlString = url
        }
        
        DispatchQueue.main.async {
            try! self.realm.write {
                self.realm.add(gifObject)
            }
        }
    }
    
    public func getGifts() -> [GifDTO] {
        
        let gifObjects = realm.objects(GifObject.self)
        var gifItems = [GifDTO]()
        
        for gifObject in gifObjects {
            gifItems.append(GifDTO(title: gifObject.title, url: gifObject.urlString))
        }
        
        return gifItems
    }
}
