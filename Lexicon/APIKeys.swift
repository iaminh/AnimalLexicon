//
//  APIKeys.swift
//  NextLife
//
//  Created by Minh on 5/30/16.
//  Copyright © 2016 ZENTITY a.s. All rights reserved.
//

import Foundation


struct APIKeys {
    static let BaseAddress = "http://opendata.praha.eu/api/action/datastore_search"
}

extension String {
    func withId(id: String) -> String {
        return self + "/\(id)"
    }
}
