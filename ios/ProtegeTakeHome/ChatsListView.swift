//
//  ContentView.swift
//  ProtegeTakeHome
//

import SwiftUI

struct ChatsListView: View {
    @StateObject var viewModel = ChatViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.chats) { chat in
                NavigationLink {
                    ConversationView(chat: chat)
                        .buttonStyle(.plain)
                } label: {
                    ChatListRowView(chat: chat)
                        .buttonStyle(.plain)
                }
            }
        }
    }
}


struct ChatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView()
    }
}
