//
//  SettingsView.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 27.07.2023.
//

import SwiftUI
import FirebaseAuth
struct SettingsView: View {
    @State private var signView = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(.blue)
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.356, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                .offset(x: 300)
            VStack{
                Button("SIGN OUT") {
                    do{
                        try Auth.auth().signOut()
                        signView = true
                    }catch{
                        print("error")
                    }
                    
                }.foregroundColor(.black)
                    .padding()
                    .background(.red)
                    .cornerRadius(15)
            }
        }.fullScreenCover(isPresented: $signView, content: {
            ContentView()
        })
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
