//
//  AuthManager.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//


import Foundation
import FirebaseAuth



/** key things I need back for my app */
struct UserModel{
    let uuid: String
    let email: String?
    let displayName: String?
    
    init(user: User){
        self.uuid = user.uid
        self.email = user.email
        self.displayName = user.displayName
    }
}




struct GoogleSignInResultModel{
    let idToken: String
    let accessToken: String
    let name: String?
}



enum AuthProviderOptions: String{
    case email_and_password = "password"
    case google = "google.com"
}



































final class AuthManager: AuthService{
    
    /**not reccomended for larger projects**/
    // MARK: If multiple Tasks access and mutate the singleton simultaneously, it can lead to race conditions unless carefully protected.
    static let shared = AuthManager()
    
    private init() {
        
    }
    
    
    /**
     reaching out locally to find the user
     
     server might delay until it is found  **/
    func getAuthUser() throws  -> UserModel{
        guard let user = Auth.auth().currentUser else{
            throw URLError(.badServerResponse)
        }
        
        return UserModel(user: user)
    }
    
    
    // provider : google.com (tested on the frontend)
    // provider2 : password (tested on the frontend)
    
    func getProviders() throws -> [AuthProviderOptions]{
        // the provider is either Email/Password or Google
        guard let providerData = Auth.auth().currentUser?.providerData else{
            throw URLError(.badServerResponse)
        }
        
        var providers: [AuthProviderOptions] = []
        
        for provider in providerData{
            // we are using if let so it can continue with the loop
            if let option = AuthProviderOptions(rawValue: provider.providerID){
                providers.append(option)
            } else{
                // safest to use
                assertionFailure("Provider not found \(provider.providerID)")
            }
        }
        
        return providers
    }
    
    
    func signOut() throws{
        try Auth.auth().signOut()
    }
    
    
    
    /**delete account from the app**/
    
    func deleteUser() async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        
        try await user.delete()
    }
    
   
}





/**MARK: Sign In With email & password**/

extension AuthManager{
    @discardableResult
    func createUser(email: String, password: String, displayName: String) async throws -> UserModel{
       let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
        
        let user = authResult.user
        
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = displayName
        
        try await changeRequest.commitChanges()
        
        return  UserModel(user: user)
        
    }
    
    
    func signInUser(email: String, password: String) async throws -> UserModel{
        let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
        
        return UserModel(user: authResult.user)
        
    }
    
    
    func resetPassword(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
}



// MARK: Sign In SSO like Google Functions
extension AuthManager{
    
    @discardableResult
    func signInWithGoogle(tokens: GoogleSignInResultModel) async throws -> UserModel{
        let credential =  GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        return try await signIn(creditential: credential)
    }
    
    
    func signIn(creditential: AuthCredential) async throws -> UserModel{
        let auth_result = try await Auth.auth().signIn(with: creditential)
        return UserModel(user: auth_result.user)
    }
    
    
    
    
    
    
}
