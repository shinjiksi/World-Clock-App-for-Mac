// City.swift
// Data model for a city with timezone information

import Foundation

struct City: Identifiable, Codable, Equatable {
    let id = UUID()
    let name: String
    let shortName: String
    let timezone: String
    let flag: String
    let region: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case name, shortName, timezone, flag, region, isSelected
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.id == rhs.id
    }
}
