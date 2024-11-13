

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    
    @State var isPlaying: Bool = false
    @State var width: CGFloat = 300
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("turtlerock")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: 60)
                    .offset(y: -300)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        // Audio Image
                        Image("turtlerock")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: width, height: width)
                            .overlay(RoundedRectangle(cornerRadius: 150).stroke(Color.white, lineWidth: 4))
                            .cornerRadius(150)
                            .shadow(radius: 50)
                        
                        // Audio Name
                        Text("明天")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 25)
                            .padding(.horizontal)
                            .lineLimit(1)
                        
                        Text("孙磊")
                            .font(.title3)
                            .fontWeight(.light)
                            .padding(.top, 5)
                            .padding(.horizontal)
                            .lineLimit(1)
                    }
                    VStack {
                        Text("00:00")
                            .font(.body)
                            .padding()
                        
                        HStack(spacing: 55) {
                            
                            // Go Backward Button
                            Button(action: {
                                print("go backward")
                            }) {
                                Image(systemName: "gobackward.15")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .clipShape(Circle())
                            }
                            
                            // Play / Pause Button
                            Button(action: {
                                print("play / pause")
                            }) {
                                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title)
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            
                            // Go Forward Button
                            Button(action: {
                                print("go forward")
                            }) {
                                Image(systemName: "goforward.15")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear {
                print("on appear")
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                } catch {
                    print ("error setting audio session category: \(error)")
                }
                
                guard let url = URL(string: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3") else { return }
            }
        }
    }
}


#Preview {
    AudioPlayerView().preferredColorScheme(.dark)
}
