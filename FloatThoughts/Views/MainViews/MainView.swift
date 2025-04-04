//
//  MainView.swift
//  FloatThoughts
//
//  Created by Tasawar Saraf on 3/30/25.
//

import SwiftUI

struct MainView: View {
    
    
    @State private var circles: [MockCircle] = []
    
    let screen = UIScreen.main.bounds
    
    let numberOfCircles = CircleLayoutConfig.numberOfCircles
    let width = CircleLayoutConfig.width
    let height = CircleLayoutConfig.height
    let radius = CircleLayoutConfig.radius

    
    var body: some View {
        ZStack{
        
//            Rectangle()
//                .fill(Color.red)
//                .frame(width: screen.width * 0.90, height: screen.height * 0.85)
            
            
            Color("BackgroundColor").ignoresSafeArea()
            
            GeometryReader { geometry in
                
                let rectWidth = screen.width * 0.90
               let rectHeight = screen.height * 0.85
               let originX = (geometry.size.width - rectWidth) / 2
               let originY = (geometry.size.height - rectHeight) / 2
                ForEach(circles) { circle in
                    Button {
                        print(circle.emoji)
                    } label: {
                        ThoughtCircle(circle: circle, width: width, height: height)
                    }.offset(x: circle.position.x + originX - rectWidth / 2,y: circle.position.y + originY - rectHeight / 2)
                }
            }
            
            
        }.onAppear {
            generateRandomCircle()
        }
    }
    
    
    
    /**https://www.youtube.com/watch?v=XATr_jdh-44**/
    
    /**Circle Packing Algorithm**/
    
    
    func generateRandomCircle(){
        
        /**newCirclesList (viewModel),radius, numberOfCircle, emoji**/
        var newCircles: [MockCircle] = []
        
        let rectWidth = screen.width * 0.90
        let rectHeight = screen.height * 0.85
        
        let radius: CGFloat = radius
        
        
        var attempts = 0
        
        
        while newCircles.count < numberOfCircles && attempts < 1000 {
            attempts += 1
            
            let x = CGFloat.random(in: radius...(rectWidth - radius))
            let y = CGFloat.random(in: radius...(rectHeight - radius))
            
            let newPosition = CGPoint(x: x, y: y)
            
            let overlaps = newCircles.contains { existing in
                let distance = hypot(existing.position.x - newPosition.x, existing.position.y - newPosition.y)
                
                return distance < radius * 2
            }
            
            if !overlaps {
                let emoji = CircleLayoutConfig.emoji.randomElement() ?? "💬"
               newCircles.append(MockCircle(position: newPosition, emoji: emoji))
            }
        }

        print(radius)
    
        circles = newCircles
        
    }
    
    
   
}

#Preview {
    MainView()
}





struct ThoughtCircle: View {
    let circle: MockCircle
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        ZStack{
            Circle()
                .fill(Color("TextColor"))
                .frame(width: width, height: height)
                .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 4)
            
            Text(circle.emoji)
                .font(.title2)
        }
        .position(circle.position)
        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
        .opacity(0.8)
    }
}
