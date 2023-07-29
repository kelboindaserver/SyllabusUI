//
//  DersEkleView.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 27.07.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct DersEkleView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dersAdi = ""
    @State private var baslangicDersSaat = Date()
    @State private var bitisDersSaat = Date()
    @FocusState private var dersBool : Bool
    @State private var showAlert = false
    @State private var selection = "Monday"
    let colors = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
    var baslangicTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: baslangicDersSaat)
    }
    var bitisTime: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: bitisDersSaat)
    }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.58, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.918, saturation: 0.977, brightness: 1.0, opacity: 0.622))
                .offset(x: 300)
            VStack(alignment: .center, spacing: 20){
                Text("Lesson Name")
                    .fontWeight(.bold)
                TextField("", text:$dersAdi ) {
                }.focused($dersBool)
                    .autocapitalization(.none)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(dersBool ? .blue:.gray, lineWidth: 2)
                    )
                    .padding(.horizontal , 30)
                    .font(.system(.headline, design: .rounded,weight: .bold))
                Picker("Day", selection: $selection){
                    ForEach(colors,id: \.self) {
                        Text($0)
                    }
                }
                HStack{
                    VStack{
                        Text("Start At: ")
                        DatePicker("", selection: $baslangicDersSaat,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    VStack{
                        Text("Finish At:")
                        DatePicker("", selection: $bitisDersSaat,displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    
                }.padding(.top,20)
                Spacer()
                    .frame(height: 100)
                
                Button("Add Lesson" ) {
                    
                    if dersAdi.isEmpty{
                        showAlert = true
                    }else{
                        let db = Firestore.firestore()
                        db.collection((Auth.auth().currentUser?.email)!).document("Days").collection(selection).addDocument(data: [dersAdi : baslangicTime + " - " + bitisTime])
                        presentationMode.wrappedValue.dismiss()
                    }
                } .foregroundColor(.black)
                    .padding()
                    .background(
                        Color(hue: 0.547, saturation: 0.667, brightness: 0.809)
                    )
                    .cornerRadius(25)
                    .buttonStyle(.automatic)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Error"),
                            message: Text("Lesson Name can not empty !"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
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
                Text("Back to Syllabus")
                    .fontWeight(.bold)
            }
        })
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
    
}


struct DersEkleView_Previews: PreviewProvider {
    static var previews: some View {
        DersEkleView()
    }
}
