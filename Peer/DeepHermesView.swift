//
//  DeepHermesView.swift
//  Peer
//
//  Created by Hamza Akkad on 12/09/2025.
//

import SwiftUI
import Foundation
struct DeepHermesView: View {
    @State private var messages: [Message] = []
    @State private var messageText: String = ""
    @Environment(\.presentationMode) var presentationMode
    var wallpaper = Int.random(in: 0...46)
    @State private var wallpaperArray = ["wallpaper", "wallpaper2", "wallpaper3", "wallpaper4", "wallpaper5","wallpaper6","wallpaper7","wallpaper8","wallpaper9","wallpaper10","wallpaper11","wallpaper12","wallpaper13","wallpaper14","wallpaper15","wallpaper16","wallpaper17","wallpaper18","wallpaper19","wallpaper20","wallpaper21","wallpaper22","wallpaper23","wallpaper24","wallpaper25","wallpaper26","wallpaper27","wallpaper28","wallpaper29","wallpaper30","wallpaper31","wallpaper32","wallpaper33","wallpaper34","wallpaper35","wallpaper36","wallpaper37","wallpaper38","wallpaper39", "wallpaper40", "wallpaper41", "wallpaper42", "wallpaper43", "wallpaper44", "wallpaper45", "wallpaper46"]
    
    private let storageKey = "savedMessagesDeepHermes" // Unique key for this view
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                // === BACKGROUND IMAGE ===
                Image(wallpaperArray[wallpaper])
                    .resizable()
                    .scaledToFill()
                    .frame(width: geo.size.width, height: geo.size.height)
                    .ignoresSafeArea()

                Color.black.opacity(0.14)
                    .ignoresSafeArea()

                VStack {
                    // === TOP BAR ===
                    HStack {
                        // Back Button
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("<<")
                                .font(.system(size: geo.size.width * 0.05, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: geo.size.width * 0.12, height: geo.size.width * 0.12)
                                .background(Color.white.opacity(0.08))
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Text("DeepHermes")
                            .bold()
                            .font(.system(size: max(15, geo.size.width * 0.045), weight: .medium))
                            .foregroundColor(.white.opacity(0.85))
                        
                        Spacer()
                        
                        // Clear Button
                        Button(action: {
                            clearMessages()
                        }) {
                            Image(systemName: "trash.fill")
                                .font(.system(size: geo.size.width * 0.05))
                                .foregroundColor(.white)
                                .frame(width: geo.size.width * 0.12, height: geo.size.width * 0.12)
                                .background(Color.white.opacity(0.08))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 2)

                    Spacer()
                    
                    
                    // === CHAT MESSAGES ===
                    ScrollViewReader { scrollProxy in
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: geo.size.height * 0.025) {
                                ForEach(messages) { message in
                                    HStack {
                                        if message.isUser {
                                            Spacer()
                                            Text(message.text)
                                                .bold()
                                                .font(.system(size: max(12, geo.size.width * 0.038)))
                                                .foregroundColor(.white)
                                                .padding(.vertical, 12)
                                                .padding(.horizontal, 16)
                                                .background(Capsule().fill(Color.white.opacity(0.4)))
                                                .overlay(Capsule().stroke(Color.white.opacity(0.4), lineWidth: 1))
                                                .frame(maxWidth: geo.size.width * 0.75, alignment: .trailing)
                                        } else {
                                            Text(message.text)
                                                .font(.system(size: max(12, geo.size.width * 0.038)))
                                                .foregroundColor(.white)
                                                .padding(.vertical, 12)
                                                .padding(.horizontal, 16)
                                                .background(Capsule().fill(Color.white.opacity(0.08)))
                                                .overlay(Capsule().stroke(Color.white.opacity(0.12), lineWidth: 1))
                                                .frame(maxWidth: geo.size.width * 0.82, alignment: .leading)
                                            Spacer()
                                        }
                                    }
                                    .id(message.id) // Add ID for scrolling
                                }
                                Spacer().frame(height: 8)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 4)
                        }
                        .onChange(of: messages.count) { _ in
                            // Scroll to the last message when messages change
                            withAnimation(.easeOut(duration: 0.3)) {
                                if let lastMessage = messages.last {
                                    scrollProxy.scrollTo(lastMessage.id, anchor: .bottom)
                                }
                            }
                        }
                        .onAppear {
                            // Scroll to bottom when view appears
                            if let lastMessage = messages.last {
                                scrollProxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                    .frame(maxHeight: .infinity)
                    
                    Spacer()

                    // === INPUT BAR ===
                    HStack {
                        TextField("Just imagine...", text: $messageText)
                            .foregroundColor(.white.opacity(0.85))
                            .font(.system(size: max(14, geo.size.width * 0.038)))
                            .padding(.leading, 16)
                            .submitLabel(.send)
                            .onSubmit{sendMessage()}

                        Button {
                            sendMessage()
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .font(.system(size: geo.size.width * 0.05))
                                .foregroundColor(.white)
                                .frame(width: geo.size.width * 0.12, height: geo.size.width * 0.12)
                                .background(Color.white.opacity(0.08))
                                .clipShape(Circle())
                        }
                        .padding(.trailing, 8)
                    }
                    .frame(height: max(46, geo.size.height * 0.07))
                    .background(Capsule().fill(Color.white.opacity(0.08)))
                    .overlay(Capsule().stroke(Color.white.opacity(0.10), lineWidth: 1))
                    .padding(.horizontal, 16)
                    .padding(.bottom, geo.safeAreaInsets.bottom + 12)
                }
            }
            .ignoresSafeArea(.keyboard)
            .onAppear {
                loadMessages()
            }
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }

    // === MESSAGE HANDLING ===
    func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        let userMessage = Message(text: messageText, isUser: true)
        messages.append(userMessage)
        saveMessages()
        
        let prompt = messageText
        messageText = ""
        
        contactLLM(userInput: prompt)
    }
    
    func appendAIMessage(_ text: String) {
        DispatchQueue.main.async {
            let aiMessage = Message(text: text, isUser: false)
            messages.append(aiMessage)
            saveMessages()
        }
    }
    
    // === STORAGE ===
    func saveMessages() {
        if let data = try? JSONEncoder().encode(messages) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func loadMessages() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let saved = try? JSONDecoder().decode([Message].self, from: data) {
            messages = saved
        }
    }
    
    func clearMessages() {
        messages.removeAll()
        UserDefaults.standard.removeObject(forKey: storageKey)
    }
    
    // === CALL LLM API ===
    func contactLLM(userInput: String) {
        let url = URL(string: "https://openrouter.ai/api/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = [
            "model": "nousresearch/deephermes-3-llama-3-8b-preview:free",
                    "messages": [
                        [
                            "role": "user",
                            "content": "\(userInput)"
                        ]
                    ]
                ]
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: json, options: [])
        } catch {
            appendAIMessage("❌ Error serializing JSON: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                appendAIMessage("❌ Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                appendAIMessage("⚠️ Invalid Response Try Again Later")
                return
            }
            guard let data = data else {
                appendAIMessage("⚠️ No data received")
                return
            }
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let choices = jsonResponse["choices"] as? [[String: Any]],
                   let firstChoice = choices.first,
                   let message = firstChoice["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    appendAIMessage(content)
                } else {
                    appendAIMessage("⚠️ Could not parse AI response")
                }
            } catch {
                appendAIMessage("❌ Error parsing JSON: \(error)")
            }
        }.resume()
    }
}
struct DeepHermesView_Previews: PreviewProvider {
    static var previews: some View {
        DeepHermesView()
    }
}
