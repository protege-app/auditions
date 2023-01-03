//
//  ConversationViewModel.swift
//  ProtegeTakeHome
//

import Foundation

class ConversationViewModel: ObservableObject {
    let chat: Chat
    @Published var messages = [Message]()
    @Published var error: Error?
    var lastFetchedDate: Date = .now

    init(chat: Chat) {
        self.chat = chat
        Task {
            await getMessages()
        }
    }
    
    @MainActor
    func getMessages() async {
        // TO DO - implement automatic retry policy
        self.error = nil
        do {
            let batchTimeInterval: TimeInterval = -36000
            let dateIntervalToFetch = DateInterval(start: lastFetchedDate.addingTimeInterval(batchTimeInterval), end: lastFetchedDate)
            
            let newMessages = try await MockChatAPI().fetchMessages(for: chat, interval: dateIntervalToFetch)
            // TO DO - deal with case where there are no messages retrieved for this time range
            messages.append(contentsOf: newMessages.sorted(by: { $0.date > $1.date }))
            lastFetchedDate = lastFetchedDate.addingTimeInterval(batchTimeInterval)
        } catch {
            self.error = error
        }
    }
    
    func loadMoreContentIfNeeded(currentItem index: Int) {
        if index == messages.count - 1 {
            Task {
                await getMessages()
            }
        }
    }
    
    func sendMessage(msg: String) {
        let msgToSend = Message(
            date: .now,
            content: msg,
            sender: chat.primarySender
        )
        messages = [msgToSend] + messages
    }
}
