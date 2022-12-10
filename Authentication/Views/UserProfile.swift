//
//  UserProfile.swift
//  Authentication
//
//  Created by Hao on 5/12/2022.
//

import SwiftUI

struct UserProfile: View {
    
    @State private var logOut = false
    
    @EnvironmentObject var authView: UserAuth
    
    var body: some View {
        NavigationStack {
            Text("User Profile").padding()
            Text("\(authView.testValue)")
            Button {
                authView.logout()
            } label: {
                Text("Log Out")
            }

        }.navigationDestination(isPresented: $logOut) {
            SignUpView()
        }
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
//            .environmentObject(UserAuth())
    }
}
