//
//  SettingsViewModel.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/4/25.
//

import Foundation
import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    
    
    @Published var authProviders: [AuthProviderOptions] = []
    
    let authService: AuthService
    
    init(authService: AuthService){
        self.authService = authService
    }
    
    
    func loadAuthProviders() {
        if let providers = try? authService.getProviders(){
            authProviders = providers
        }
    }
    func logOut() throws {
        try authService.signOut()
    }
    
    func resetPassword() async throws{
        let authUser = try authService.getAuthUser()
        
        guard let user_email = authUser.email else {
            print("no email")
            return
        }
        
        try await authService.resetPassword(email: user_email)
        
    }
    
    func deleteAccount() async throws{
        try await authService.deleteUser()
    }
}
