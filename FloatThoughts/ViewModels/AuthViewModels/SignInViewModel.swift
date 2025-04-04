//
//  SignInViewModel.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/3/25.
//

import SwiftUI



@MainActor
final class SignInViewModel:ObservableObject {
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var retypePassword: String = ""
    @Published var displayName: String = ""
    
    
    private let authService: AuthService
    
    init(authService: AuthService){
        self.authService = authService
    }
    
    func signUp() async throws{
        guard !email.isEmpty && !password.isEmpty else {
            /** better auth practice*/
            throw SignInError.emptyFields
        }
        
        guard password == retypePassword else {
            throw SignInError.mismatchPassword
        }
        
        // we know there is a value but we don't need to do anything
        
        let _ =  try await authService.createUser(email: email, password: password, displayName: displayName)
    
        
        
    }
    
    func signIn() async throws{
        guard !email.isEmpty && !password.isEmpty else {
            /** better auth practice*/
            print("No email or password found")
            throw SignInError.invalidEmail
        }
        
        // we know there is a value but we don't need to do anything
        
        let _ = try await authService.signInUser(email: email, password: password)
        
    }
}
