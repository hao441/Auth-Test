//
//  SignUpView.swift
//  Authentication
//
//  Created by Hao on 4/12/2022.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmedPassword = ""
    
    @EnvironmentObject var authView: UserAuth
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign up")
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
                
                //Password
                HStack{
                    Text("Password")
                        .frame(width: 80, alignment: .trailing)
                    SecureField("Confirm Password", text: $confirmedPassword)
                }
                .padding()
                //signup
                Button {
                    signUp()
                } label: {
                    Text("Sign up")
                }


            }
        }
    }
    func signUp() {
        authView.signUp(email: email, password: password)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
