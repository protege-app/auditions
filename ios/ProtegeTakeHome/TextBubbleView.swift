//
//  TextBubbleView.swift
//  ProtegeTakeHome
//

import Foundation
import SwiftUI

struct TextBubbleView: View {
    var isFromUser: Bool
    var content: String
    
    var body: some View {
        Text(content)
            .padding(10)
            .foregroundColor(isFromUser ? Color.white : Color.black)
            .background(isFromUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}
