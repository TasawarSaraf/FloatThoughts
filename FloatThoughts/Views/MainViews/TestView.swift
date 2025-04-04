//
//  TestView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/31/25.
//

import SwiftUI

struct TestView: View {
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
    

            ZStack {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: screen.width * 0.90, height: screen.height * 0.85)
            }
        

    }
}

#Preview {
    TestView()
}
