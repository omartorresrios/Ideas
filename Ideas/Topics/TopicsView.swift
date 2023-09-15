//
//  TopicsView.swift
//  Ideas
//
//  Created by Omar Torres on 31/08/23.
//

import SwiftUI

struct TopicsView: View {
	@StateObject var viewModel = TopicsViewModel()
	@Binding var note: Note
	@State var totalNotes = 0
	let completion: () -> Void
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		VStack {
			Text("Related topics")
				.padding()
			if totalNotes == 5 {
				Text("A note can't have more than 5 topics.")
			}
			List {
				ForEach(viewModel.chatGPTTopics.indices, id: \.self) { index in
					HStack {
						Text(viewModel.chatGPTTopics[index].name)
						Spacer()
						Button {
							viewModel.chatGPTTopics[index].added.toggle()
							udpateTotalNotes(with: viewModel.chatGPTTopics[index])
						} label: {
							viewModel.chatGPTTopics[index].added ? Image(systemName: "minus.circle") : Image(systemName: "plus.circle")
						}
						.disabled(disableAddTopicButton(for: viewModel.chatGPTTopics[index]))
					}
				}
			}
			doneButton
		}
		.onAppear {
			viewModel.getTopics(currentTopics: note.topics)
			totalNotes = note.topics.count
		}
	}
	
	private func udpateTotalNotes(with chatGPTTopic: ChatGPTTopic) {
		if chatGPTTopic.added {
			totalNotes += 1
		} else {
			totalNotes -= 1
		}
	}
	
	private func disableAddTopicButton(for chatGPTTopic: ChatGPTTopic) -> Bool {
		if totalNotes == 5 && !chatGPTTopic.added {
			return true
		}
		return false
	}
	
	private func getTopics() -> [ChatGPTTopic] {
		let chatGPTTopics = viewModel.chatGPTTopics.compactMap { chatGPTTopic in
			let noteExist = note.topics.contains { chatGPTTopic.name == $0.name }
			return !noteExist ? ChatGPTTopic(name: chatGPTTopic.name, added: chatGPTTopic.added) : nil
		}
		return chatGPTTopics
	}
	
	var doneButton: some View {
		Button("Done") {
			let newTopics = viewModel.chatGPTTopics.map { Topic(id: UUID().uuidString, name: $0.name, added: $0.added) }.filter({ $0.added })
			note.topics.append(contentsOf: newTopics)
			presentationMode.wrappedValue.dismiss()
		}
		.buttonStyle(.borderedProminent)
		.disabled(totalNotes == 5)
	}
}

struct TopicsView_Previews: PreviewProvider {
	static var previews: some View {
		TopicsView(note: .constant(Note(id: "23", title: "title", body: "body", topics: [])), totalNotes: 0, completion: { })
	}
}
extension Array where Element: Hashable {
	func difference(from other: [Element]) -> [Element] {
		let thisSet = Set(self)
		let otherSet = Set(other)
		return Array(thisSet.subtracting(otherSet))
	}
}
