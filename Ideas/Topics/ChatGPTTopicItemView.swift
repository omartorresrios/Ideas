//
//  ChatGPTTopicItemView.swift
//  Ideas
//
//  Created by Omar Torres on 23/12/23.
//

import SwiftUI

struct ChatGPTTopicItemView: View {
	@Binding var topic: ChatGPTTopic
	private var isLast = false
	private var disabledAddedButton = false

	init(topic: Binding<ChatGPTTopic>, isLast: Bool, disabledAddedButton: Bool) {
		self._topic = topic
		self.isLast = isLast
		self.disabledAddedButton = disabledAddedButton
	}

	var body: some View {
		HStack(spacing: 2) {
			Text(topic.name)
			Spacer()
			Button {
				topic.added.toggle()
			} label: {
				topic.added ? Image(systemName: "minus.circle").renderingMode(.template)
					.foregroundColor(.black) : Image(systemName: "plus.circle").renderingMode(.template)
					.foregroundColor(.black)
			}
			.disabled(disabledAddedButton)
		}
		if !isLast {
			Divider()
		}
	}
}

struct ChatGPTTopicItem_Previews: PreviewProvider {
    static var previews: some View {
		ChatGPTTopicItemView(topic: .constant(ChatGPTTopic(name: "topic",
													   added: false)),
						 isLast: false,
						 disabledAddedButton: false)
    }
}
