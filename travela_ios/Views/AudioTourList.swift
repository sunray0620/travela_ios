//
//  Test.swift
//  travela_ios
//
//  Created by LEI SUN on 11/13/24.
//

import SwiftUI

struct AudioTourListView: View {
    
    let audioTourList: [AudioTourViewModel]
    @Binding var selectedDetent: PresentationDetent
        
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 2) {
                    ForEach(audioTourList) { audioTour in
                        NavigationLink(destination: AudioTourDetailView(audioTour: audioTour)) {
                            AudioTourRowCard(audioTour: audioTour)
                        }.simultaneousGesture(TapGesture().onEnded {
                            selectedDetent = .large
                        })
                    }
                }
            }
            .clipped()
            .background(Color.gray.brightness(0.3))
        }
    }
}

struct AudioTourRowCard: View {
    let audioTour: AudioTourViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(audioTour.name)
                    .multilineTextAlignment(TextAlignment.leading)
                    .font(.body)
                    .padding(.bottom, 1)
                    .foregroundColor(.primary)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                Text(audioTour.description)
                    .multilineTextAlignment(TextAlignment.leading)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            // .frame(height: 100)
            .padding(EdgeInsets(top: 15, leading: 16, bottom: 15, trailing: 16))
            .background(Color(.systemBackground))
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct AudioTourDetailView: View {
    @State private var isAudioPlayerPresented = false
    
    let audioTour: AudioTourViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Image Section (Placeholder for visuals)
                Image(systemName: "headphones.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .foregroundColor(.blue)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                
                // Title Section with background
                Text(audioTour.name)
                    .font(.title3)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top, 16)
                
                // Description Section
                Text(audioTour.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                // Creator Information
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.blue)
                    Text("Creator: \(audioTour.creator)")
                        .font(.subheadline)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal)
                
                // Spacer to keep content from touching the bottom
                Spacer()
                // Play Tour Button
                Button(action: {
                    withAnimation(.spring()) {
                        isAudioPlayerPresented = true
                    }
                }) {
                    HStack {
                        Image(systemName: "play.circle.fill")
                            .font(.title2)
                        Text("Play Tour")
                            .font(.headline)
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(15)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
                .fullScreenCover(isPresented: $isAudioPlayerPresented) {
                    AudioPlayerView(audioTourViewModel: audioTour).colorScheme(.dark)
                        .overlay(
                            HStack {
                                Spacer()
                                Button(action: {
                                    isAudioPlayerPresented = false
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                            }
                            .padding(.top, 20), alignment: .topTrailing
                        )
                }
                
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitle("Audio Tour Detail", displayMode: .inline)
    }
}

#Preview {
    // AudioTourListView(audioTourList: allAudioTourViewModels, selectedDetent: .init(id: "1"))
}
