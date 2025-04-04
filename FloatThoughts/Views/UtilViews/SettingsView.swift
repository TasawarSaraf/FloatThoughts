//
//  SettingsView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//

import SwiftUI



struct SettingsView: View {
    
    @StateObject private var settingVm = SettingsViewModel(authService: AuthManager.shared)
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            
            
            VStack(spacing: 25){
                HStack {
                    Text("Settings ⚙️").font(.largeTitle).fontWeight(.bold).foregroundStyle(Color("TextColor"))
                    Spacer()
                }.padding()
                    
                Spacer()
                
                LogoutButtonView(settingVm: settingVm, showSignInView: $showSignInView)
            
                
                // if it contains email and password only then show the
                // reset password, cuz you can't do it with Google
                if settingVm.authProviders.contains(.email_and_password){
                    ResetButtonView(settingVm: settingVm)
                }
                
                
                
                DeleteAccountButtonView(settingVm: settingVm, showSignInView: $showSignInView)

                Spacer()
                
                
                
                
            }
        }.onAppear {
            settingVm.loadAuthProviders()
        }
    }
}

#Preview {
    NavigationStack{
        SettingsView(showSignInView: .constant(false))
    }
}






struct LogoutButtonView: View {
    
    @ObservedObject var settingVm: SettingsViewModel
    @Binding var showSignInView: Bool
    var body: some View {
        Button{
            Task{
                do {
                    try settingVm.logOut()
                    showSignInView = true
                } catch{
                    print(error.localizedDescription)
                }
            }
        } label: {
            Text("Logout")
                .frame(width: 200, height: 15)
                .padding()
                .background(Color("TextColor"))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .clipShape(.capsule)
        }
    }
}





struct ResetButtonView: View {
    
    @ObservedObject var settingVm: SettingsViewModel
    var body: some View {
        Button{
            Task{
                do {
                    try await settingVm.resetPassword()
                } catch{
                    print(error.localizedDescription)
                }
            }
            
        } label: {
            Text("Reset Password")
                .frame(width: 200, height: 15)
                .padding()
                .background(Color("TextColor"))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .clipShape(.capsule)
        }
    }
}

struct DeleteAccountButtonView: View {
    @ObservedObject var settingVm : SettingsViewModel
    @Binding var showSignInView: Bool
    var body: some View {
        Button(role: .destructive) {
            Task{
                do {
                    try await settingVm.deleteAccount()
                    showSignInView = true
                } catch{
                    print(error.localizedDescription)
                }
            }
        } label: {
            Text("Delete Account")
                .frame(width: 200, height: 15)
                .padding()
                .background(Color("DeleteColor"))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .clipShape(.capsule)
        }
    }
}
