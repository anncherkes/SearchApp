//
//  GifObject.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import Foundation
import RealmSwift

public class GifObject: Object {
    @objc dynamic var title = ""
    @objc dynamic var urlString = ""
}
