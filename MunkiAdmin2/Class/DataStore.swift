//
//  DataStore.swift
//  MunkiAdmin2
//
//  Created by Küng, Steve on 04.05.2024.
//

import Foundation

class DataStore {
    static let shared = DataStore()
    
    var manifestName: String = ""
    var Manifests: [String] = []
    var Packages: [String] = []
    var Catalogs: [String] = []
}
