//
//  GIFDTO.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import UIKit

public struct GifDTO {
    public var title: String?
    public var id: String?
    public var url: String?
    
    public init(_ gif: GIFItem) {
        self.id = gif.data?.first?.id
        self.url = gif.data?.first?.images?.original?.url
    }
    
    public init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
