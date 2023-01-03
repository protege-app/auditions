//
//  ChatAPI.swift
//  ProtegeTakeHome
//

import Foundation

/// The enum representing chat API errors.
enum ChatAPIError: LocalizedError {
    case timedOut
    
    var errorDescription: String? {
        "Sorry, the app had an issue loading the network request."
    }
}

/// A protocol that represents an interface to a remote chat API.
protocol ChatAPI {
    /// Returns an array of messages for a given chat and date interval.
    ///
    /// - Parameters:
    ///     - chat: The chat to fetch.
    ///     - startDate: The start date.
    ///     - endDate: The end date.
    func fetchMessages(for chat: Chat, interval: DateInterval) async throws -> [Message]
}

/// A struct representing a chat between a primary and secondary sender.
struct Chat: Identifiable, Equatable, Hashable {
    let id = UUID()
    var primarySender: MessageSender
    var secondarySender: MessageSender
    
    static let liaAndKatie = Chat(primarySender: .lia, secondarySender: .katie)
    static let liaAndChristina = Chat(primarySender: .lia, secondarySender: .christina)
}

extension Chat {
    var displayTitle: String {
        if let firstName = secondarySender.name.givenName {
            if let lastName = secondarySender.name.familyName {
                return firstName + " " + lastName
            }
            return firstName
        }
        return secondarySender.name.familyName ?? ""
    }
}

/// A response from the API that represents a single message.
struct Message: Identifiable, Equatable, Hashable {
    let id = UUID()
    let date: Date
    let content: String
    let sender: MessageSender
}

/// A response from the API that represents the person who sent the message.
struct MessageSender: Identifiable, Equatable, Hashable {
    let id = UUID()
    let name: PersonNameComponents
}

/// Message sender constants.
extension MessageSender {
    static let lia       = MessageSender(name: try! .init("Lia Lynn Longo"))
    static let katie     = MessageSender(name: try! .init("Katie Agatha Abeles"))
    static let christina = MessageSender(name: try! .init("Christina Ethel Ahmed"))
    static let kelly     = MessageSender(name: try! .init("Kelly Sloan Altick"))
}
