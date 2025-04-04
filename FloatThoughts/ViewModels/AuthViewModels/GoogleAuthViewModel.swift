//
//  GoogleAuthViewModel.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/3/25.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift

@MainActor
final class GoogleAuthViewModel: ObservableObject{
    
    
    private let authService: AuthService
    
    init(authService: AuthService){
        self.authService = authService
    }
    
    func signInWithGoogle() async throws{
        
        guard let topVC = Utilities.shared.topViewController() else {
           throw  URLError(.cannotFindHost)
            
        }
        
        let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken: String = result.user.idToken?.tokenString else{
            throw URLError(.badServerResponse)
        }
        
        let accessToken: String = result.user.accessToken.tokenString
        
        let name = result.user.profile?.name
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name)
        
        let _ = try await authService.signInWithGoogle(tokens: tokens)
        
       
    }
}
