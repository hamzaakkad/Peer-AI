//
//  Message.swift
//  Peer
//"Bearer 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", forHTTPHeaderField: "Authorization")
//request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//// KEEP DeepSeek model under the hood
//let json: [String: Any] = [
//    "model": "openai/gpt-oss-20b:free",
//                "messages": [
//  Created by Hamza Akkad on 05/09/2025.
//
// just that same save message when you leave the app (Save Chat in a more begineer way) struct i've moved it here to have easy access to it from any file i want

import SwiftUI

import Foundation

struct Message: Identifiable, Codable, Equatable {
    let id: UUID
    let text: String
    let isUser: Bool
    
    init(id: UUID = UUID(), text: String, isUser: Bool) {
        self.id = id
        self.text = text
        self.isUser = isUser
    }
}
