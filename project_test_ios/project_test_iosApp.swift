//
//  project_test_iosApp.swift
//  project_test_ios
//
//  Created by RATOVO PESIN Axel Judd on 03/11/2025.
//

import SwiftUI

@main
struct ProjectTestIOSApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    NavigationLink("Counter Game") {
                        ContentView()
                    }
                    NavigationLink("Profile") {
                        ProfileView()
                    }
                }
                .navigationTitle("Home")
            }
        }
    }
}
