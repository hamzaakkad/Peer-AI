//
//  ContentView.swift
//  Peer
//
//  Created by Hamza Akkad on 01/09/2025.
//

import SwiftUI
//@State private var wallpaper : Int = 0

struct ContentView: View {
    var wallpaper = Int.random(in: 0...46)
    @State private var wallpaperArray = ["wallpaper", "wallpaper2", "wallpaper3", "wallpaper4", "wallpaper5","wallpaper6","wallpaper7","wallpaper8","wallpaper9","wallpaper10","wallpaper11","wallpaper12","wallpaper13","wallpaper14","wallpaper15","wallpaper16","wallpaper17","wallpaper18","wallpaper19","wallpaper20","wallpaper21","wallpaper22","wallpaper23","wallpaper24","wallpaper25","wallpaper26","wallpaper27","wallpaper28","wallpaper29","wallpaper30","wallpaper31","wallpaper32","wallpaper33","wallpaper34","wallpaper35","wallpaper36","wallpaper37","wallpaper38","wallpaper39", "wallpaper40", "wallpaper41", "wallpaper42", "wallpaper43", "wallpaper44", "wallpaper45", "wallpaper46"]
    var body: some View {
        NavigationView {
            ZStack {
                // MARK: Background wallpaper
                Image(wallpaperArray[wallpaper])
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                 
                
                VStack {
                    // MARK: Top Title
                    Spacer()
                    Text("Choose Your Friend\n")
                        .foregroundColor(.white.opacity(0.85))
                        .font(.title3)
                        .bold()
                        .padding(.top, 40)
                    
                    // MARK: Glass Buttons
                    VStack(spacing: 20) {
                        NavigationLink(destination: DeepSeekView()) {
                            GlassButton(title: "DeepSeek")
                        }
                        NavigationLink(destination: ChatGPTView()) {
                            GlassButton(title: "ChatGPT")
                        }
                        NavigationLink(destination: DeepHermesView()) {
                            GlassButton(title: "DeepHermes")
                        }
                        NavigationLink(destination: LlamaView()) {
                            GlassButton(title: "Llama")
                        }
//                        NavigationLink(destination: LlamaView()) {
//                            GlassButton(title: "Llama")
//                        }
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // MARK: Footer
                    Text("Hamza Akkad's Production")
                        .foregroundColor(.white.opacity(0.85))
                        .font(.caption)
                        .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true) // Hide nav bar in ContentView
        }
        .navigationViewStyle(StackNavigationViewStyle()) // fixes navigation on iPad
    }
}

// MARK: - Glass Button
struct GlassButton: View {
    var title: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.ultraThinMaterial) // iOS 15+ glass effect
                .frame(height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
            
            Text(title)
                .foregroundColor(.white)
                .font(.headline)
                .bold()
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

