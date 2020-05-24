//
//  Answer.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/17/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import Foundation

struct Answer {
    var response: String
    var isRight: Bool
    
    init() {
        response = ""
        isRight = false
    }
}
