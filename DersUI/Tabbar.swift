//
//  Tabbar.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 26.07.2023.
//

import SwiftUI

struct Tabbar: View {
    
    var body: some View {
        ZStack{
            TabView{
                DersProgramiView().tabItem {
                    Image(systemName: "note")
                    Text("Syllabus")}.tag(1)
                SinavProgrami().tabItem {
                    Image(systemName: "doc.text")
                    Text("Exam Schedule")}.tag(2)
                SettingsView().tabItem {
                    Image(systemName: "gear")
                    Text("Settings")}.tag(3)
            }.navigationBarBackButtonHidden(true)
                .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                    appearance.backgroundColor = UIColor(Color.black.opacity(0.1))
                    UITabBar.appearance().standardAppearance = appearance
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            
            
            
        }
    }
    
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar()
    }
}
