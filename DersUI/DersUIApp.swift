//
//  DersUIApp.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 25.07.2023.
//

import SwiftUI
import Firebase

@main
struct DersUIApp: App {
    init() {
        FirebaseApp.configure()
        
    }
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                Tabbar()
            }else{
                ContentView()
            }
        }
    }
}
