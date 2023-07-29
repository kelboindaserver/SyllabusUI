//
//  DersProgramiView.swift
//  DersUI
//
//  Created by Sadan Efe Oz on 26.07.2023.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

struct DersProgramiView: View{
    @State private var monArr = [String]()
    @State private var monHArr = [String]()
    @State private var monDoc = [String]()
    @State private var tueArr = [String]()
    @State private var tueHArr = [String]()
    @State private var tueDoc = [String]()
    @State private var wedArr = [String]()
    @State private var wedHArr = [String]()
    @State private var wedDoc = [String]()
    @State private var thuArr = [String]()
    @State private var thuHArr = [String]()
    @State private var thuDoc = [String]()
    @State private var friArr = [String]()
    @State private var friHArr = [String]()
    @State private var friDoc = [String]()
    @State private var email = Auth.auth().currentUser?.email
    let db = Firestore.firestore()
    func getResArr(day: String, completion: @escaping ([String], [String],[String]) -> Void) {
        var arr = [String]()
        var saatArr = [String]()
        var documentIDs = [String]()
        
        db.collection(email!).document("Days").collection(day).addSnapshotListener { (querySnapshot, error) in
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
                    .foregroundColor(Color(hue: 0.725, saturation: 1.0, brightness: 1.0))
                    .offset(x: -270)
                RoundedRectangle(cornerRadius: 25)
                    .blur(radius: 250)
                    .foregroundColor(Color(hue: 0.604, saturation: 1.0, brightness: 1.0, opacity: 0.602))
                    .offset(x: 300)
                VStack(alignment: .leading){
                    NavigationLink(destination: DersEkleView()) {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .frame(width: 25,height: 25)
                        Text("Add Lesson")
                            .fontWeight(.bold)
                        
                    }.padding(.leading,20)
                    List {
                        Section(header: Text("MONDAY")
                            .fontWeight(.bold)
                            .font(.system(size: 22))) {
                                ForEach(monArr.indices, id: \.self) { res in
                                    HStack {
                                        Text(monArr[res])
                                            .padding()
                                        Spacer()
                                        Text(monHArr[res])
                                            .padding()
                                    }.swipeActions{
                                        Button {
                                            db.collection(email!).document("Days").collection("Monday").document(monDoc[res]).delete()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.red)
                                                .cornerRadius(8)
                                        }.tint(.red)
                                    }
                                    
                                }
                            }
                        Section(header: Text("TUESDAY")
                            .fontWeight(.bold)
                            .font(.system(size: 22))) {
                                ForEach(tueArr.indices, id: \.self) { res in
                                    HStack {
                                        Text(tueArr[res])
                                            .padding()
                                        Spacer()
                                        Text(tueHArr[res])
                                            .padding()
                                    }.swipeActions{
                                        Button {
                                            db.collection(email!).document("Days").collection("Tuesday").document(tueDoc[res]).delete()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.red)
                                                .cornerRadius(8)
                                        }.tint(.red)
                                    }
                                    
                                }
                            }
                        Section(header: Text("WEDNESDAY")
                            .fontWeight(.bold)
                            .font(.system(size: 22))) {
                                ForEach(wedArr.indices, id: \.self) { res in
                                    HStack {
                                        Text(wedArr[res])
                                            .padding()
                                        Spacer()
                                        Text(wedHArr[res])
                                            .padding()
                                    }.swipeActions{
                                        Button {
                                            db.collection(email!).document("Days").collection("Wednesday").document(wedDoc[res]).delete()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.red)
                                                .cornerRadius(8)
                                        }.tint(.red)
                                    }
                                    
                                }
                            }
                        Section(header: Text("THURSDAY")
                            .fontWeight(.bold)
                            .font(.system(size: 22))) {
                                ForEach(thuArr.indices, id: \.self) { res in
                                    HStack {
                                        Text(thuArr[res])
                                            .padding()
                                        Spacer()
                                        Text(thuHArr[res])
                                            .padding()
                                    }.swipeActions{
                                        Button {
                                            db.collection(email!).document("Days").collection("Thursday").document(thuDoc[res]).delete()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.red)
                                                .cornerRadius(8)
                                        }.tint(.red)
                                    }
                                    
                                }
                            }
                        Section(header: Text("FRIDAY")
                            .fontWeight(.bold)
                            .font(.system(size: 22))) {
                                ForEach(friArr.indices, id: \.self) { res in
                                    HStack {
                                        Text(friArr[res])
                                            .padding()
                                        Spacer()
                                        Text(friHArr[res])
                                            .padding()
                                    }.swipeActions{
                                        Button {
                                            db.collection(email!).document("Days").collection("Friday").document(friDoc[res]).delete()
                                        } label: {
                                            Label("Delete", systemImage: "trash")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Color.red)
                                                .cornerRadius(8)
                                        }.tint(.red)
                                    }
                                    
                                }
                            }
                        
                    }.scrollContentBackground(.hidden)
                        .listStyle(InsetGroupedListStyle())
                        .navigationTitle("Syllabus")
                    
                    
                    
                }
                
            }
        }.onAppear{
            getResArr(day: "Monday") { [self] arr, saatArr,docId  in
                monArr = arr
                monHArr = saatArr
                monDoc = docId
            }
            getResArr(day: "Tuesday") { [self] arr, saatArr,docId in
                tueArr = arr
                tueHArr = saatArr
                tueDoc = docId
            }
            getResArr(day: "Wednesday") { [self] arr, saatArr,docId in
                wedArr = arr
                wedHArr = saatArr
                wedDoc = docId
            }
            getResArr(day: "Thursday") { [self] arr, saatArr,docId in
                thuArr = arr
                thuHArr = saatArr
                thuDoc = docId
            }
            getResArr(day: "Friday") { [self] arr, saatArr,docId in
                friArr = arr
                friHArr = saatArr
                friDoc = docId
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}


struct DersProgramiView_Previews: PreviewProvider {
    static var previews: some View {
        DersProgramiView()
    }
}
