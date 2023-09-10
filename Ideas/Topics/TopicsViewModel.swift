//
//  TopicsViewModel.swift
//  Ideas
//
//  Created by Omar Torres on 06/09/23.
//

import Foundation

class TopicsViewModel: ObservableObject {
	@Published var chatGPTTopics = [ChatGPTTopic]()
	
	init() {
		chatGPTTopics = [ChatGPTTopic(name: "Generated topic 1", added: false),
						 ChatGPTTopic(name: "Health", added: false),
						 ChatGPTTopic(name: "Generated topic 3", added: false)]
	}
	
	func getTopics(currentTopics: [Topic]) {
		let chatGPTTopics = chatGPTTopics.compactMap { chatGPTTopic in
			let noteExist = currentTopics.contains { chatGPTTopic.name == $0.name }
			return !noteExist ? ChatGPTTopic(name: chatGPTTopic.name, added: chatGPTTopic.added) : nil
		}
		self.chatGPTTopics = chatGPTTopics
	}
}
