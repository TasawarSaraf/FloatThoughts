//
//  SignUpView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 4/3/25.
//

import SwiftUI

struct SignUpView: View {

    @StateObject private var signInVM = SignInViewModel(authService: AuthManager.shared)
    @State private var errorMessage: String?
    @Binding var showSignInView: Bool
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            
            VStack(spacing: 25){
                
                Text("Sign Up 🏋🏽").foregroundStyle(Color("TextColor")).font(.largeTitle).fontWeight(.bold)
                TextField("Display Name", text: $signInVM.displayName)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .clipShape(.capsule)
                TextField("Email", text: $signInVM.email)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .clipShape(.capsule)
                SecureField("Password", text: $signInVM.password)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .clipShape(.capsule)
                SecureField("Renter Password", text: $signInVM.retypePassword)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .clipShape(.capsule)
            
                
                
                
                SignUpButtonView(signInVM: signInVM, showSignInView: $showSignInView, errorMessage: $errorMessage)
                
              
                if let errorMessage = errorMessage{
                    Text(errorMessage)
                        .font(.headline)
                        .foregroundStyle(.red)
                        .transition(.opacity)
                }
               
                
                
            }.padding()
        }
    }
}



#Preview {
    SignUpView(showSignInView: .constant(false))
}



extension SignUpView{
    /// Dismiss keyboard on button press
        private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

struct SignUpButtonView: View {
    
    @ObservedObject var signInVM: SignInViewModel
    @Binding var showSignInView: Bool
    let screen = UIScreen.main.bounds
    @Binding var errorMessage: String?
    var body: some View {
        Button {
            // I can use Task to concurrenrly check signUp and signIn
            Task{
                do {
                    try await signInVM.signUp()
                    // this will drop the signInView and go for the ContentView
                    showSignInView = false
                    return
                    
                } catch{
                    withAnimation{
                        errorMessage = error.localizedDescription
                    }
                }
                
            }
            
            
        } label: {
            Text("Sign Up")
                .font(.headline)
                .frame(width: screen.width * 0.85, height: 22)
                .padding()
                .background(Color("TextColor"))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .clipShape(.capsule)
        }
    }
}
