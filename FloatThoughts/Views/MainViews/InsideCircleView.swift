import SwiftUI

struct InsideCircleView: View {
    
    @State var likeCounts: Int = 0
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            
            VStack {
                
                VStack(spacing: 16) {
                    HStack {
                        Button {
                            
                        } label: {
                            Image(systemName: "arrow.backward")
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .font(.title2)
                                .padding()
                        }
                        
                        
                        Spacer()
                    }
                    
                    
                    ScrollView {
                        Text("Here are my thoughts. I love myself so much. Thank you so much world, you are amazing. Please love me more, remember that please please. Don't leave me, you are amazing and you are my everything.Here are my thoughts. I love myself so much. Thank you so much world, you are amazing. Please love me more, remember that please please. Don't leave me, you are amazing and you are my everything.Here are my thoughts. I love myself so much. Thank you so much world, you are amazing. Please love me more, remember that please please. Don't leave me, you are amazing and you are my everything. Here are my thoughts. I love myself so much. Thank you so much world, you are amazing. Please love me more, remember that please please. Don't leave me, you are amazing and you are my everything.Here are my thoughts. I love myself so much. Thank you so much world, you are amazing. Please love me more, remember that please please. Don't leave me, you are amazing and you are my everything.Here are my thoughts. I love myself so much. Thank you so much world, you are amazing. Please love me more, remember that please please. Don't leave me, you are amazing and you are my everything.")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                            .foregroundStyle(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    HStack{
                        LikeButtonView(likeCounts: $likeCounts)
                      
                        Text("\(likeCounts)").foregroundStyle(.white).bold().font(.title2)
                        Spacer()
                        
                        CommentButtonView()
                        
                    }.padding()
                }
                .background(
                    Rectangle()
                        .fill(Color("TextColor"))
                        .cornerRadius(20)
                )
                .containerRelativeFrame([.horizontal, .vertical]) { dimension, axis in
                    dimension * 2.8 / 3
                }
                
            }
        }
    }
}

#Preview {
    InsideCircleView()
}

struct LikeButtonView: View {
    @Binding var likeCounts: Int
    var body: some View {
        Button{
            likeCounts += 1
        } label: {
            Image(systemName: "hand.thumbsup.fill").fontWeight(.semibold).foregroundStyle(.white).padding(.vertical).font(.title2)
        }
    }
}

struct CommentButtonView: View {
    var body: some View {
        Button {
            
        } label: {
            Image(systemName: "bubble.right.fill").fontWeight(.semibold).foregroundStyle(.white).padding(.vertical).font(.title2)
        }
    }
}
