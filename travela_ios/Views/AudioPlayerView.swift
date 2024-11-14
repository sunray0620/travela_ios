

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    
    @StateObject private var audioPlayer = AudioPlayer()
    @State var width: CGFloat = 301
    
    var audioTourId: String
    var audioTourAudioFileUrl : URL
    
    init(audioTourId: String) {
        self.audioTourId = audioTourId
        AudioTourHelper.prepareAudioTour(audioTourId: audioTourId)
        
        self.audioTourAudioFileUrl = AudioTourHelper.getAudioTourFileUrl(audioTourId: audioTourId)
    }
    
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
                        HStack {
                            Text(getTimeString(from: audioPlayer.currentTime))
                                .font(.body)
                                .padding()
                            Text("/")
                                .font(.body)
                                .padding()
                            Text(getTimeString(from: audioPlayer.duration))
                                .font(.body)
                                .padding()
                        }
                        HStack(spacing: 55) {
                            // Go Backward Button
                            Button(action: {
                                audioPlayer.goBackward()
                            }) {
                                Image(systemName: "gobackward.15")
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding()
                                    .clipShape(Circle())
                            }
                            
                            // Play / Pause Button
                            Button(action: {
                                if (audioPlayer.isPlaying) {
                                    audioPlayer.pause()
                                } else {
                                    audioPlayer.play()
                                }
                            }) {
                                Image(systemName: audioPlayer.isPlaying ? "pause.fill" : "play.fill")
                                    .font(.title)
                                    .foregroundColor(Color.black)
                                    .padding()
                                    .background(Color.white)
                                    .clipShape(Circle())
                            }
                            
                            // Go Forward Button
                            Button(action: {
                                audioPlayer.goForward()
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
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                } catch {
                    print ("error setting audio session category: \(error)")
                }
                
                audioPlayer.setup(url: self.audioTourAudioFileUrl)
            }
        }
    }
    
    func getTimeString(from time: TimeInterval) -> String {
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


#Preview {
    AudioPlayerView(audioTourId: "lesunAudioTour").preferredColorScheme(.dark)
}
