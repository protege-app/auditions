//
//  ConversationView.swift
//  ProtegeTakeHome
//

import Foundation
import SwiftUI

struct ConversationView: View {
    @ObservedObject var conversationViewModel: ConversationViewModel
    @State var typingMessage: String = ""
    
    init(chat: Chat) {
        self.conversationViewModel = ConversationViewModel(chat: chat)
    }
    
    var body: some View {
        // TO DO - make keyboard close on scroll, make ScrollView scroll to bottom to show new message when sent or received
        VStack(spacing: 0) {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(Array(conversationViewModel.messages.enumerated()), id: \.element) { index, message in
                        
                        let isFromUser = message.sender == conversationViewModel.chat.primarySender
                        HStack {
                            let textBubble = TextBubbleView(
                                isFromUser: isFromUser,
                                content: message.content
                            )
                            if isFromUser {
                                Spacer(minLength: 30)
                                textBubble
                            } else {
                                textBubble
                                Spacer(minLength: 30)
                            }
                        }
                        .padding(.horizontal, 10)
                        .onAppear {
                            conversationViewModel.loadMoreContentIfNeeded(currentItem: index)
                        }
                        
                        if
                            let previousMessage = conversationViewModel.messages[safe: index + 1],
                            let timeDiff = Calendar.current.dateComponents([.hour, .minute], from: previousMessage.date, to: message.date).hour,
                            abs(timeDiff) >= 1,
                            let timeStampText = message.date.messageDateLabel
                        {
                            Text(timeStampText)
                        }
                    }
                    .flippedUpsideDown()
                }
                .padding(.vertical, 10)
                
                if let _ = conversationViewModel.error {
                    Button {
                        Task {
                            await conversationViewModel.getMessages()
                        }
                    } label: {
                        VStack {
                            Text("Unable to load more messages.")
                            Label("Retry", systemImage: "arrow.counterclockwise")
                        }
                    }
                    .flippedUpsideDown()
                    .padding(.horizontal, 10)

                } else {
                    // TO DO - make showing progress indicator based on whether or not request is in flight instead of whether or not there is an error
                    ProgressView()
                }
            }
            .flippedUpsideDown()
            
            Divider()
            HStack {
                TextField("Message...", text: $typingMessage)
                    .onSubmit {
                        conversationViewModel.sendMessage(msg: typingMessage)
                        typingMessage = ""
                    }
                Button {
                    conversationViewModel.sendMessage(msg: typingMessage)
                    typingMessage = ""
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(Color.blue)
                }
            }
            .padding(10)
        }
        .navigationTitle(conversationViewModel.chat.displayTitle)
    }
}

struct ConversationView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationView(chat: Chat.liaAndKatie)
    }
}
