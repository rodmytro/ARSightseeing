//
//  LocationFactory.swift
//  ARSightseeing
//
//  Created by Dmytro Romaniuk on 7/6/18.
//  Copyright © 2018 rodmytro. All rights reserved.
//

import Foundation

final class LocationFactory {
    
    static func build() -> [LocationObject] {
        guard let path =
            Bundle.main.path(forResource: "Locations", ofType: "json") else { return Array() }
        guard let data =
            try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return Array() }
        
        guard let locations =
            try? JSONDecoder().decode([LocationObject].self, from: data) else {
            return Array()
        }
        
        return locations
    }
    
}
