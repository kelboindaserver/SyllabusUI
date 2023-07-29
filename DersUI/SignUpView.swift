//
//  SignUpView.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 25.07.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

struct SignUpView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var errMsg = ""
    @State private var showAlert = false
    @State private var dersView = false
    @State private var name = ""
    @State private var surname = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordAgain = ""
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.279, saturation: 1.0, brightness: 1.0, opacity: 0.635))
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.356, saturation: 0.964, brightness: 0.792, opacity: 0.602))
                .offset(x: 300)
            VStack{
               Text("SIGN UP")
                    .font(.largeTitle)
                    .fontWeight(.black)
                    .padding(.top , 50)
                TextField("Email", text: $email)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.gray, lineWidth: 2)
                    )
                    .padding([.horizontal],30)
                    .padding(.top,30)
                SecureField("Password", text: $password)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.gray, lineWidth: 2)
                    )
                    .padding([.horizontal],30)
                    .padding(.top,20)
                SecureField("Password Again", text: $passwordAgain)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(.gray, lineWidth: 2)
                    )
                    .padding([.horizontal],30)
                    .padding(.top,20)
                Spacer()
                    Button("Sign Up") {
                        if password == passwordAgain{
                            Auth.auth().createUser(withEmail: email, password: password){ result,error in
                                if error != nil{
                                    errMsg = error?.localizedDescription ?? "Error"
                                    showAlert = true
                                }else{
                                    let db = Firestore.firestore()
                                    db.collection(email).document("Days")
                                    print(email)
                                    dersView = true
                                }
                            }
                        }else{
                            errMsg = "Passwords don't match ! "
                            showAlert = true
                        }
                       
                    }.alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text(errMsg),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .foregroundColor(.black)
                    .padding()
                    
                    .frame(width: 110,height: 50)
                    .background(
                        Color(hue: 0.508, saturation: 1.0, brightness: 0.834, opacity: 0.55)
                    )
                    .cornerRadius(25)
                    .buttonStyle(.automatic)
                    .padding(.bottom,190)
               
                }
               
        }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        .fontWeight(.bold)
                        Text("Back to Sign In")
                            .fontWeight(.bold)
                    }
            })
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            .fullScreenCover(isPresented: $dersView, content: {
                Tabbar() // Present the Tabbar view when showTabbar is true
            })
       
}

    struct SignUpView_Previews: PreviewProvider {
        static var previews: some View {
            SignUpView()
        }
        
    }
}
