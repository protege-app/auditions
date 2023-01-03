//
//  ChatViewModel.swift
//  ProtegeTakeHome
//

import Foundation

class ChatViewModel: ObservableObject {
    @Published var chats = [Chat]()
    
    init() {
        getChats()
    }
    
    func getChats() {
        // Get the chats (could replace with API call instead of using fake data)
        chats = [Chat.liaAndKatie, Chat.liaAndChristina]
    }
}
