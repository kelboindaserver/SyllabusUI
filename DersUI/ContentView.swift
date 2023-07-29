//
//  ContentView.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 25.07.2023.
//

import SwiftUI
import FirebaseAuth


struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @FocusState private var passBool : Bool
    @FocusState private var emailBool : Bool
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var dersView = false
    
    
    var body: some View {
        NavigationView{
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
                    VStack {
                        Text("SyllabusUI")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.top , 50)
                        TextField("Email", text: $email) {
                        }.focused($emailBool)
                            .textContentType(.emailAddress)
                            .autocapitalization(.none)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(emailBool ? .blue:.gray, lineWidth: 2)
                            )
                            .padding([.top,.trailing,.leading] , 30)
                            .font(.system(.headline, design: .rounded,weight: .bold))
                        
                        
                        
                        SecureField("Password", text: $password)
                            .focused($passBool)
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14)
                                    .stroke(passBool ? .blue:.gray, lineWidth: 2)
                            )
                            .padding([.trailing,.leading] , 30)
                            .padding(.top,20)
                            .font(.system(.headline, design: .rounded,weight: .bold))
                        
                    }
                    .padding()
                    HStack{
                        Button("LOG IN") {
                            
                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                if let error = error {
                                    errorMessage = error.localizedDescription
                                    showAlert = true
                                } else {
                                    dersView = true
                                    print("success")
                                    
                                    
                                }
                            }
                            
                            
                        }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("Error"),
                                message: Text(errorMessage),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        .foregroundColor(.black)
                        .padding()
                        
                        .frame(width: 110,height: 50)
                        .background(
                            Color(hue: 0.302, saturation: 0.343, brightness: 0.96, opacity: 0.55)
                        )
                        .cornerRadius(25)
                        .buttonStyle(.automatic)
                        
                        
                        
                        
                    }
                    .padding([.horizontal] , 30)
                    Spacer()
                    NavigationLink(destination: SignUpView()){
                        Text("Don't have an account yet? \n Sign up")
                        
                    }
                    .padding(.bottom,30)
                }
                
            }
        }.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .fullScreenCover(isPresented: $dersView, content: {
            Tabbar() // Present the Tabbar view when showTabbar is true
        })
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func signIn(email:String,password:String,dersView : Binding<Bool>,completion: @escaping (Error) -> Void) {
    Auth.auth().signIn(withEmail: email, password: password) { result, error in
        if let error = error {
            
            completion(error)
        } else {
            
        }
    }
}
