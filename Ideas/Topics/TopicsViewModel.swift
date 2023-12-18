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
		chatGPTTopics = [ChatGPTTopic(name: "Random topic 1", added: false),
						 ChatGPTTopic(name: "Random topic 2", added: false),
						 ChatGPTTopic(name: "Random topic 3", added: false),
						 ChatGPTTopic(name: "Random topic 4", added: false),
						 ChatGPTTopic(name: "Random topic 5", added: false),
						 ChatGPTTopic(name: "Random topic 6", added: false)]
	}
	
	func getTopics(currentTopics: [Topic]) {
		let chatGPTTopics = chatGPTTopics.compactMap { chatGPTTopic in
			let existingNote = currentTopics.contains { chatGPTTopic.name == $0.name }
			return !existingNote ? chatGPTTopic : nil
		}
		self.chatGPTTopics = chatGPTTopics
	}
	
	func reachLimitOf5Topics() -> Bool {
		return chatGPTTopics.filter({ $0.added }).count == 5
	}
}
