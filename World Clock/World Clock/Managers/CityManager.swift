// CityManager.swift
// Manages the list of cities and user selections

import Foundation
import Combine

class CityManager: ObservableObject {
    static let shared = CityManager()
    
    @Published var cities: [City] = []
    
    private let userDefaultsKey = "selectedCities"
    
    private init() {
        // Load cities and selections
        loadCities()
        loadSelectedCities()
    }
    
    func loadCities() {
        cities = [
            // Japan
            City(name: "Tokyo", shortName: "Tok", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Osaka", shortName: "Osa", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Sapporo", shortName: "Sap", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            City(name: "Fukuoka", shortName: "Fuk", timezone: "Asia/Tokyo", flag: "🇯🇵", region: "Japan"),
            
            // United States
            City(name: "New York", shortName: "NY", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Los Angeles", shortName: "LA", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Chicago", shortName: "Chi", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Houston", shortName: "Hou", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Phoenix", shortName: "Phx", timezone: "America/Phoenix", flag: "🇺🇸", region: "United States"),
            City(name: "Philadelphia", shortName: "Phi", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "San Antonio", shortName: "SA", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "San Diego", shortName: "SD", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Dallas", shortName: "Dal", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "San Jose", shortName: "SJ", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Austin", shortName: "Aus", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Jacksonville", shortName: "Jax", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Fort Worth", shortName: "FW", timezone: "America/Chicago", flag: "🇺🇸", region: "United States"),
            City(name: "Columbus", shortName: "Col", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Charlotte", shortName: "Cha", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "San Francisco", shortName: "SF", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Indianapolis", shortName: "Ind", timezone: "America/Indiana/Indianapolis", flag: "🇺🇸", region: "United States"),
            City(name: "Seattle", shortName: "Sea", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Denver", shortName: "Den", timezone: "America/Denver", flag: "🇺🇸", region: "United States"),
            City(name: "Boston", shortName: "Bos", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Portland", shortName: "Por", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Las Vegas", shortName: "LV", timezone: "America/Los_Angeles", flag: "🇺🇸", region: "United States"),
            City(name: "Detroit", shortName: "Det", timezone: "America/Detroit", flag: "🇺🇸", region: "United States"),
            City(name: "Miami", shortName: "Mia", timezone: "America/New_York", flag: "🇺🇸", region: "United States"),
            City(name: "Boise", shortName: "Boi", timezone: "America/Boise", flag: "🇺🇸", region: "United States"),
            
            // Canada
            City(name: "Toronto", shortName: "Tor", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Vancouver", shortName: "Van", timezone: "America/Vancouver", flag: "🇨🇦", region: "Canada"),
            City(name: "Montreal", shortName: "Mtl", timezone: "America/Montreal", flag: "🇨🇦", region: "Canada"),
            City(name: "Calgary", shortName: "Cal", timezone: "America/Edmonton", flag: "🇨🇦", region: "Canada"),
            City(name: "Ottawa", shortName: "Ott", timezone: "America/Toronto", flag: "🇨🇦", region: "Canada"),
            City(name: "Edmonton", shortName: "Edm", timezone: "America/Edmonton", flag: "🇨🇦", region: "Canada"),
            
            // Philippines
            City(name: "Manila", shortName: "Man", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Cebu", shortName: "Ceb", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Davao", shortName: "Dav", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            City(name: "Quezon City", shortName: "QC", timezone: "Asia/Manila", flag: "🇵🇭", region: "Philippines"),
            
            // Mexico
            City(name: "Mexico City", shortName: "MEX", timezone: "America/Mexico_City", flag: "🇲🇽", region: "Mexico"),
            City(name: "Guadalajara", shortName: "GDL", timezone: "America/Mexico_City", flag: "🇲🇽", region: "Mexico"),
            City(name: "Monterrey", shortName: "MTY", timezone: "America/Monterrey", flag: "🇲🇽", region: "Mexico"),
            City(name: "Cancún", shortName: "CUN", timezone: "America/Cancun", flag: "🇲🇽", region: "Mexico"),
            
            // Major World Cities
            City(name: "London", shortName: "Lon", timezone: "Europe/London", flag: "🇬🇧", region: "World"),
            City(name: "Paris", shortName: "Par", timezone: "Europe/Paris", flag: "🇫🇷", region: "World"),
            City(name: "Berlin", shortName: "Ber", timezone: "Europe/Berlin", flag: "🇩🇪", region: "World"),
            City(name: "Dubai", shortName: "Dub", timezone: "Asia/Dubai", flag: "🇦🇪", region: "World"),
            City(name: "Singapore", shortName: "Sin", timezone: "Asia/Singapore", flag: "🇸🇬", region: "World"),
            City(name: "Hong Kong", shortName: "HK", timezone: "Asia/Hong_Kong", flag: "🇭🇰", region: "World"),
            City(name: "Sydney", shortName: "Syd", timezone: "Australia/Sydney", flag: "🇦🇺", region: "World"),
            City(name: "Mumbai", shortName: "Bom", timezone: "Asia/Kolkata", flag: "🇮🇳", region: "World"),
            City(name: "São Paulo", shortName: "SP", timezone: "America/Sao_Paulo", flag: "🇧🇷", region: "World"),
        ]
    }
    
    func toggleCity(_ city: City) {
        if let index = cities.firstIndex(where: { $0.id == city.id }) {
            let selectedCount = cities.filter { $0.isSelected }.count
            
            // Check if trying to select more than 5 cities
            if !cities[index].isSelected && selectedCount >= 5 {
                return
            }
            
            cities[index].isSelected.toggle()
            saveSelectedCities()
            
            // Notify AppDelegate to update menu bar
            NotificationCenter.default.post(name: NSNotification.Name("UpdateMenuBar"), object: nil)
        }
    }
    
    func getSelectedCities() -> [City] {
        return cities.filter { $0.isSelected }
    }
    
    func saveSelectedCities() {
        let selectedNames = cities.filter { $0.isSelected }.map { $0.name }
        UserDefaults.standard.set(selectedNames, forKey: userDefaultsKey)
    }
    
    func loadSelectedCities() {
        guard let selectedNames = UserDefaults.standard.array(forKey: userDefaultsKey) as? [String] else { return }
        
        for i in 0..<cities.count {
            if selectedNames.contains(cities[i].name) {
                cities[i].isSelected = true
            }
        }
    }
}
