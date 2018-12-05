//
//  Category.swift
//  todoey
//
//  Created by Basavaraj Soppannavar on 12/4/18.
//  Copyright © 2018 Lakshmi B S. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
