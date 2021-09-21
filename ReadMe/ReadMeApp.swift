//
//  ReadMeApp.swift
//  ReadMe
//
//  Created by Владислав Котик on 06/09/2021.
//

import SwiftUI

@main
struct ReadMeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Library())
        }
    }
}
