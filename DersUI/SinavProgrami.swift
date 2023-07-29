//
//  SinavProgrami.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 26.07.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
struct SinavProgrami: View {
    @State private var resArr = [String]()
    @State private var dateArr = [String]()
    @State private var documentId = [String]()
    @State private var dersEkle = false
    @State private var email = Auth.auth().currentUser?.email
    let db = Firestore.firestore()
    func getResArr(completion: @escaping ([String], [String],[String]) -> Void) {
        var arr = [String]()
        var saatArr = [String]()
        var documentIDs = [String]()
        
        db.collection(email!).document("Sinav").collection("Sinav").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                arr.removeAll()
                saatArr.removeAll()
                for document in querySnapshot!.documents {
                    for (key, value) in document.data() {
                        if let valueString = value as? String {
                            arr.append(key)
                            saatArr.append(valueString)
                            documentIDs.append(document.documentID)
                        }
                    }
                }
                completion(arr, saatArr, documentIDs)
            }
        }
    }
    var body: some View {
        NavigationView {
            
       
        ZStack{
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.474, saturation: 0.624, brightness: 0.962, opacity: 0.726))
                .offset(x: -270)
            RoundedRectangle(cornerRadius: 25)
                .blur(radius: 250)
                .foregroundColor(Color(hue: 0.356, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                .offset(x: 300)
            VStack(alignment: .leading){
                NavigationLink(destination: SinavEkleView()) {
                    Image(systemName: "plus.app.fill")
                        .resizable()
                        .frame(width: 25,height: 25)
                    Text("Add Lesson")
                        .fontWeight(.bold)
                    
                }.padding(.leading,20)
                
                
                
                List(resArr.indices, id: \.self) { res in
                    
                    HStack{
                        Text(resArr[res]).padding()
                        Spacer()
                        Text(dateArr[res]).padding()
                    }.swipeActions{
                        Button {
                            db.collection(email!).document("Sinav").collection("Sinav").document(documentId[res]).delete()
                        } label: {
                            Label("Delete", systemImage: "trash")
                                .foregroundColor(.white)
                                .padding(10)
                                .background(Color.red)
                                .cornerRadius(8)
                        }.tint(.red)
                    }
                    
                }.scrollContentBackground(.hidden)
                    .listStyle(InsetGroupedListStyle())
                    .navigationTitle("Exam Schedule")
            }
            
        }
        }.onAppear{
            getResArr { arr, saatArr, docID in
                resArr = arr
                dateArr = saatArr
                documentId = docID
            }
        }
        
    }
}

struct SinavProgrami_Previews: PreviewProvider {
    static var previews: some View {
        SinavProgrami()
    }
}
