

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    
    @StateObject private var audioPlayer = AudioPlayer()
    @State var width: CGFloat = 300
    @State private var isLoading: Bool = true
    @State private var audioTourViewModel : AudioTourViewModel?
    
    private var originalAudioTourViewModel : AudioTourViewModel?
    
    init(audioTourViewModel : AudioTourViewModel) {
        self.originalAudioTourViewModel = audioTourViewModel
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
                        AsyncImage(url: self.audioTourViewModel?.imageFileUrl ?? URL(string: "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                            .frame(width: width, height: width)
                            .overlay(RoundedRectangle(cornerRadius: 150).stroke(Color.white, lineWidth: 4))
                            .cornerRadius(150)
                            .shadow(radius: 50)
                        
                        // Audio Name
                        Text(self.audioTourViewModel?.name ?? "Name")
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
                            Text("-")
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
                }.blur(radius: isLoading ? 20 : 0)
                .animation(.easeInOut, value: isLoading)
                
                if isLoading {
                    Color.black.opacity(0.7)
                        .ignoresSafeArea()
                    VStack {
                        ProgressView()
                            .scaleEffect(2.0)
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        Text("Contacting Your Travel Agent...")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                    }
                    .padding(30)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(15)
                    .shadow(radius: 10)
                }
            }
            .onAppear {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                    Task {
                        if let originalAudioTourViewModel = self.originalAudioTourViewModel {
                            var processedAudioTourViewModel = originalAudioTourViewModel
                            await AudioTourHelper.prepareAudioTour(audioTourViewModel: &processedAudioTourViewModel)
                            self.audioTourViewModel = processedAudioTourViewModel
                            audioPlayer.setup(url: (self.audioTourViewModel?.audioFileUrl)!)
                        }
                        isLoading = false
                    }
                } catch {
                    print ("error setting audio session category: \(error)")
                }
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
    AudioPlayerView(audioTourViewModel: allAudioTourViewModels[2]).preferredColorScheme(.dark)
}
