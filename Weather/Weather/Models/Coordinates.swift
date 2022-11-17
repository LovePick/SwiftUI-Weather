//
//  Coordinates.swift
//  Weather
//
//  Created by Supapon Pucknavin on 16/11/2565 BE.
//

import Foundation
enum Coordinates {
    // MARK: - Coordinates
    struct Coordinate: Codable, Hashable {
        let name: String
        let localNames: [String: String]?
        let lat, lon: Double
        let country, state: String

        enum CodingKeys: String, CodingKey {
            case name
            case localNames = "local_names"
            case lat, lon, country, state
        }
    }

    typealias Coordinates = [Coordinate]
}
