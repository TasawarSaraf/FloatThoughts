//
//  AuthService.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/4/25.
//



import Foundation
import FirebaseAuth

protocol AuthService {
    func getAuthUser() throws -> UserModel
    func getProviders() throws -> [AuthProviderOptions]
    func signOut() throws
    func deleteUser() async throws

    func createUser(email: String, password: String, displayName: String) async throws -> UserModel
    func signInUser(email: String, password: String) async throws -> UserModel
    func resetPassword(email: String) async throws

    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> UserModel
    func signIn(creditential: AuthCredential) async throws -> UserModel
}


