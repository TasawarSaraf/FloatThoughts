//
//  EmailUIView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//

import SwiftUI


struct SignInView: View {
    
    // and you can use another authService as long as it conforms to the authService protocol
    
    @StateObject private var signInVM = SignInViewModel(authService: AuthManager.shared)
    
    @Binding var showSignInView: Bool
    
    @State private var errorMessage: String?
    
    var body: some View {
        
        
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            
            VStack(spacing: 25){
                
                Text("Sign In 🏋🏽").foregroundStyle(Color("TextColor")).font(.largeTitle).fontWeight(.bold)
                TextField("Email", text: $signInVM.email)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .clipShape(.capsule)
                SecureField("Password", text: $signInVM.password)
                    .padding()
                    .background(Color.white.opacity(0.6))
                    .clipShape(.capsule)
                
                SignInButtonView(signInVM: signInVM, showSignInView: $showSignInView, errorMessage: $errorMessage)
                
                NavigationLink{
                    SignUpView(showSignInView: $showSignInView)
                } label:{
                    Text("Don't have an account? Sign Up")
                }
                
                
                
              if let errorMessage = errorMessage{
                  Text(errorMessage)
                      .font(.headline)
                      .foregroundStyle(.red)
                      .transition(.opacity)
                      .multilineTextAlignment(.center)
              }
                
            }.padding()
        }
    }
}

#Preview {
    NavigationStack {
        SignInView(showSignInView: .constant(false))
    }
}

struct SignInButtonView: View {
    
    @ObservedObject var signInVM: SignInViewModel
    let screen = UIScreen.main.bounds
    @Binding var showSignInView: Bool
    @Binding var errorMessage: String?
    var body: some View {
        Button {
            // I can use Task to concurrenrly check signUp and signIn
            Task{
                
                do {
                    try await signInVM.signIn()
                    // this will drop the signInView and go for the ContentView
                    showSignInView = false
                    return
                    
                } catch{
                    withAnimation {
                        errorMessage = error.localizedDescription
                    }
                }
                
            }
            
            
        } label: {
            Text("Float In 💭")
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
