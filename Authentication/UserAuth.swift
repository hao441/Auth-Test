//
//  UserAuth.swift
//  Authentication
//
//  Created by Hao on 6/12/2022.
//

import Combine
import Firebase
import FirebaseFirestore

class UserAuth: ObservableObject {
    @Published var isLoggedin = false     // published property to update view
    @Published var user: User?
    @Published var email = ""
    @Published var testValue: Int = 0
    @Published var userValues: [String: Any] = [:]
    
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        FirebaseApp.configure()
        registerAuthStateHandler()
        
        print("hi")
    }
    
    deinit {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func registerAuthStateHandler() {
        
        let db = Firestore.firestore()
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if let user = user {
                self.user = user
                self.isLoggedin = true
                self.email = user.email!
                
                let docRef = db.collection("users").document(user.uid)
                
                docRef.getDocument { (document, error) in
                    if let document = document, document.exists {
                        let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                        print("Document data: \(dataDescription)")
    
                        
                        for key in document.data()!.keys {
                            self.userValues[key] = document.data()![key]
                        }
                        print(self.userValues["testValue"]!)
                        self.testValue = self.userValues["testValue"] as! Int
                    } else {
                        print("Document does not exist")
                    }
                }
                
            } else {
                self.isLoggedin = false
            }
        }
    }

    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if (authResult != nil) {
                self.isLoggedin = true
            }
            print(error?.localizedDescription as Any)
        }
    }
    
    func signUp(email: String, password: String) {
        
        let db = Firestore.firestore()
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if (authResult != nil) {
                self.user = authResult?.user
                self.email = authResult?.user.email ?? ""
                self.isLoggedin = true
                
                db.collection("users").document(self.user!.uid).setData([
                    "creationDate": Date.now,
                    "testValue" : 1
                ])
                
                
            }
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        self.isLoggedin = false
    }
}


