//
//  SignInView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//

import SwiftUI
import GoogleSignInSwift




struct SignInOptionsView: View {
    
    @Binding var showSignInView: Bool
    
    @StateObject private var googleVM = GoogleAuthViewModel(authService: AuthManager.shared)

    var body: some View {
        ZStack{
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 20) {
                Text("One Space. Infinite minds. Pure anonymity.")
                    .foregroundStyle(Color("TextColor"))
                    .font(.title2)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(.vertical)
                Text("Float Thoughts!")
                    .foregroundStyle(Color("TextColor"))
                    .bold()
                    .font(.largeTitle)
                
                EmailOptionButtonView(showSignInView: $showSignInView)
            
                
                Button{
                    Task{
                        do {
                            try await googleVM.signInWithGoogle()
                            // if it is sucessful turn off showSignInView
                            showSignInView = false
                        }
                        
                        catch{
                            print(error.localizedDescription)
                        }
                    }
                    
                }label: {
                    HStack(spacing: 12) {
                            Image("Google") // Add your Google icon to Assets.xcassets
                                .resizable()
                                .frame(width: 30, height: 30)

                            Text("Sign In With Google")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .font(.headline)
                        

                        }
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color("TextColor"))
                        .clipShape(Capsule())
                    
                }
                
                

            }
            .padding()
        }
    }
}

#Preview {
    
    NavigationStack{
        SignInOptionsView(showSignInView: .constant(false))
    }
    
}

struct EmailOptionButtonView: View {
    @Binding var showSignInView: Bool
    var body: some View {
        NavigationLink {
            SignInView(showSignInView: $showSignInView)
        } label: {
            Text("Sign In With Email")
                .frame(width: 220, height: 15)
                .padding()
                .background(Color("TextColor"))
                .foregroundStyle(.white)
                .fontWeight(.bold)
                .clipShape(.capsule)
        }
    }
}
