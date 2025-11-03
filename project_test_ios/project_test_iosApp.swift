//
//  project_test_iosApp.swift
//  project_test_ios
//
//  Created by RATOVO PESIN Axel Judd on 03/11/2025.
//

import SwiftUI

@main
struct project_test_iosApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                NavigationLink("Counter game"){
                    ContentView()
                }
                NavigationLink("Profile"){
                    ProfileView()
                }.navigationTitle("Home")
                    .padding()
            }
        }
    }
}
