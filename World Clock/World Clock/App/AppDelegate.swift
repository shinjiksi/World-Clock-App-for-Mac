// AppDelegate.swift
// Manages the menu bar and app lifecycle

import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem?
    var popover: NSPopover?
    var timer: Timer?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        // Create status bar item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        if let button = statusItem?.button {
            button.action = #selector(togglePopover)
            button.target = self
        }
        
        // Create popover
        popover = NSPopover()
        popover?.contentSize = NSSize(width: 450, height: 550)
        popover?.behavior = .transient
        popover?.contentViewController = NSHostingController(rootView: MainView())
        
        // Listen for menu bar update notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateMenuBarTitle),
            name: NSNotification.Name("UpdateMenuBar"),
            object: nil
        )
        
        // Update menu bar title immediately
        updateMenuBarTitle()
        
        // Start timer to update every second for instant feedback
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateMenuBarTitle()
        }
    }
    
    @objc func togglePopover() {
        if let button = statusItem?.button {
            if popover?.isShown == true {
                popover?.performClose(nil)
            } else {
                popover?.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
            }
        }
    }
    
    @objc func updateMenuBarTitle() {
        guard let button = statusItem?.button else { return }
        
        let selectedCities = CityManager.shared.getSelectedCities()
        
        // Show icon only when no cities are selected
        if selectedCities.isEmpty {
            button.image = NSImage(systemSymbolName: "globe", accessibilityDescription: "World Clock")
            button.title = ""
        } else {
            // Hide icon when cities are selected
            button.image = nil
            let timeStrings = selectedCities.map { city in
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone(identifier: city.timezone)
                formatter.dateFormat = "HH:mm"
                let time = formatter.string(from: Date())
                return "\(city.flag) \(city.shortName) \(time)"
            }
            button.title = " " + timeStrings.joined(separator: "  ")
        }
    }
}
