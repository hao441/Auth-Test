//
//  SignUpView.swift
//  Authentication
//
//  Created by Hao on 4/12/2022.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var authView: UserAuth
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                //Username
                HStack{
                    Text("Email")
                        .frame(width: 80, alignment: .trailing)
                    TextField("Email", text: $email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .submitLabel(.go)
                }
                .padding()
                //Password
                HStack{
                    Text("Password")
                        .frame(width: 80, alignment: .trailing)
                    SecureField("Password", text: $password)
                }
                .padding()
                
                //Login
                    Button {
                        logMeIn()
                    } label: {
                        Text("Login")
                    }
                HStack {
                    Text("Don't have an account? ")
                    NavigationLink("Sign up", destination: SignUpView())
                }
                .padding()
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
    func logMeIn() {
        authView.logIn(email: email, password: password)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
