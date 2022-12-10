//
//  ContentView.swift
//  Authentication
//
//  Created by Hao on 4/12/2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @ObservedObject var userAuth: UserAuth = UserAuth()
    // MARK: - View

    @ViewBuilder              // no need return inside
    var body: some View {
        if !userAuth.isLoggedin {
            LoginView().environmentObject(userAuth)
        }
        else {
            UserProfile().environmentObject(userAuth)
        }
    }
}
