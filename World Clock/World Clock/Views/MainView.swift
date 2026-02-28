// MainView.swift
// Main popup window with city list and controls

import SwiftUI

struct MainView: View {
    @StateObject private var cityManager = CityManager.shared
    @State private var searchText = ""
    
    var filteredCities: [City] {
        if searchText.isEmpty {
            return cityManager.cities
        }
        return cityManager.cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var selectedCities: [City] {
        filteredCities.filter { $0.isSelected }
    }
    
    var unselectedCities: [City] {
        filteredCities.filter { !$0.isSelected }
    }
    
    var groupedUnselectedCities: [String: [City]] {
        Dictionary(grouping: unselectedCities) { $0.region }
    }
    
    let regionOrder = ["Japan", "United States", "Canada", "Philippines", "Mexico", "World"]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("🌍 World Clock")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Text("Quit")
                        .foregroundColor(.red)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(6)
                }
                .buttonStyle(.plain)
            }
            .padding()
            .background(Color(NSColor.controlBackgroundColor))
            
            // Search bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("Search cities...", text: $searchText)
                    .textFieldStyle(.plain)
                if !searchText.isEmpty {
                    Button(action: { searchText = "" }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(8)
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(8)
            .padding(.horizontal)
            .padding(.bottom, 10)
            .padding(.top, 10)
            
            // Selected count
            HStack {
                Text("Selected: \(cityManager.getSelectedCities().count)/5")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                if cityManager.getSelectedCities().count == 5 {
                    Text("Maximum reached")
                        .font(.caption)
                        .foregroundColor(.orange)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            
            Divider()
            
            // City list
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Selected Cities Section (at top)
                    if !selectedCities.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("Selected Cities")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                Spacer()
                                Text("\(selectedCities.count)")
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.blue)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                            
                            ForEach(selectedCities) { city in
                                CityRow(city: city, isSelected: true) {
                                    cityManager.toggleCity(city)
                                }
                            }
                        }
                        .padding(.bottom, 10)
                        
                        Divider()
                            .padding(.horizontal)
                    }
                    
                    // Available Cities by Region
                    Text("Available Cities")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top, selectedCities.isEmpty ? 0 : 10)
                    
                    ForEach(regionOrder, id: \.self) { region in
                        if let cities = groupedUnselectedCities[region], !cities.isEmpty {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(region)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.primary)
                                    .padding(.horizontal)
                                
                                ForEach(cities) { city in
                                    CityRow(city: city, isSelected: false) {
                                        cityManager.toggleCity(city)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
        .frame(width: 450, height: 550)
    }
}

struct CityRow: View {
    let city: City
    let isSelected: Bool
    let onToggle: () -> Void
    
    @State private var currentTime = ""
    @State private var timer: Timer?
    
    var body: some View {
        Button(action: onToggle) {
            HStack {
                Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                    .foregroundColor(isSelected ? .blue : .secondary)
                    .font(.system(size: 16))
                
                Text(city.flag)
                    .font(.system(size: 20))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(city.name)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                    Text(city.shortName)
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(currentTime)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.primary)
                    .monospacedDigit()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue.opacity(0.1) : Color.clear)
            .cornerRadius(6)
        }
        .buttonStyle(.plain)
        .onAppear {
            updateTime()
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                updateTime()
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func updateTime() {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: city.timezone)
        formatter.dateFormat = "HH:mm:ss"
        currentTime = formatter.string(from: Date())
    }
}
