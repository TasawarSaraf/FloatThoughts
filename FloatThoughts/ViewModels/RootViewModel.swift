//
//  RootViewModel.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/4/25.
//



import Foundation


final class RootViewModel: ObservableObject{
    private let authService: AuthService
    
    init(authService: AuthService){
        self.authService = authService
    }
    
    func checkAuthStatus() {
           let user = try? authService.getAuthUser()
    }
}
