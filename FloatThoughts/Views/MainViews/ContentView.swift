//
//  ContentView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/27/25.
//

import SwiftUI

struct ContentView: View {
    
    @Binding var showSignInView: Bool
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Text("Hello Tasawar!").foregroundStyle(Color("TextColor")).bold().font(.largeTitle)
                
                
                Button {
                    
                } label: {
                    Text("Float In 🧠")
                        .frame(width: 175, height: 15)
                        .padding()
                        .background(Color("TextColor"))
                        .foregroundStyle(.white)
                        .fontWeight(.bold)
                        .clipShape(.capsule)
                }
                
                
                
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    } label: {
                        Text("Settings ⚙️")
                            .frame(width: 175, height: 15)
                            .padding()
                            .background(Color("TextColor"))
                            .foregroundStyle(.white)
                            .fontWeight(.bold)
                            .clipShape(.capsule)
                    }

                
                
                
                

            }
            .padding()
        }
    }
}

#Preview {
    NavigationStack{ContentView(showSignInView: .constant(false))}
}
