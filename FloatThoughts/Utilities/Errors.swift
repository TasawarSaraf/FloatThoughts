//
//  Errors.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/3/25.
//

import Foundation


enum SignInError: LocalizedError {
    case emptyFields
    case invalidEmail
    case weakPassword
    case userAlreadyExists
    case mismatchPassword

    var errorDescription: String? {
        switch self {
            case .emptyFields:
                return "Email and password cannot be empty."
            case .invalidEmail:
                return "Please enter a valid email address or password."
            case .weakPassword:
                return "Password must be at least 6 characters."
            case .userAlreadyExists:
                return "This user already exists. Try signing in."
            case .mismatchPassword:
                return "Passwords do not match."
            
        }
        
        
    }
}





