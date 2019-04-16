//
//  LocationObject.swift
//  ARSightseeing
//
//  Created by Dmytro Romaniuk on 7/6/18.
//  Copyright © 2018 rodmytro. All rights reserved.
//

import Foundation
import UIKit

private enum CodingKeys: String, CodingKey {
    case name = "name"
    case latitude = "latitude"
    case longitude = "longitude"
    case altitude = "altitude"
    case image = "image"
}

struct LocationObject {
    let name: String
    let imageName: String?
    let latitude: Double
    let longitude: Double
    let altitude: Double
    
    var image: UIImage? {
        guard let name = imageName else { return nil }
        return UIImage.init(named: name)
    }
}

extension LocationObject: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.imageName = try container.decode(String?.self, forKey: .image)
        self.latitude = try container.decode(Double.self, forKey: .latitude)
        self.longitude = try container.decode(Double.self, forKey: .longitude)
        self.altitude = try container.decode(Double.self, forKey: .altitude)
    }
}
