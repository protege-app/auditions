//
//  ChatListRowView.swift
//  ProtegeTakeHome
//

import Foundation
import SwiftUI

struct ChatListRowView: View {
    var chat: Chat
    
    var body: some View {
        Text(chat.displayTitle)
    }
}
