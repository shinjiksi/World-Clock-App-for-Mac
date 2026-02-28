// WorldClockApp.swift
// Main app entry point

import SwiftUI

@main
struct WorldClockApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}
