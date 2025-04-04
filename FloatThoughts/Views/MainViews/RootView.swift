//
//  RootView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    @StateObject private var rootVM = RootViewModel(authService: AuthManager.shared)
    var body: some View {
        ZStack{
            if !showSignInView{
                NavigationStack{
                    // unless the signinView is false go to the ContentView
                    // we still need it here because of the logout
                    ContentView(showSignInView: $showSignInView)
                }
            }
            
        }.onAppear{
            let authUser = try? AuthManager.shared.getAuthUser()
            self.showSignInView = authUser == nil ? true : false
        }.fullScreenCover(isPresented: $showSignInView) {
            NavigationStack{
                // if it is true go to the SignInvIEW
                SignInOptionsView(showSignInView: $showSignInView)
            }
        }
    }
}

#Preview {
    NavigationStack{
        RootView()
    }
}
