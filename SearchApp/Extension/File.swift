//
//  File.swift
//  SearchApp
//
//  Created by Anna Cherkes on 5/12/19.
//  Copyright © 2019 AnnaCherkes. All rights reserved.
//

import Foundation
import UIKit

public extension Collection {
     subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

