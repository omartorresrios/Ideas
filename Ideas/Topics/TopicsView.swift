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
	let completion: () -> Void
	@Environment(\.presentationMode) var presentationMode
	
	var body: some View {
		VStack {
			Text("Related topics")
				.padding()
			if viewModel.reachLimitOf5Topics() {
				Text("A note can't have more than 5 topics.")
			}
			List {
				ForEach(viewModel.chatGPTTopics.indices, id: \.self) { index in
					HStack {
						Text(viewModel.chatGPTTopics[index].name)
						Spacer()
						Button {
							viewModel.chatGPTTopics[index].added.toggle()
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
		}
	}
	
	private func disableAddTopicButton(for chatGPTTopic: ChatGPTTopic) -> Bool {
		return viewModel.reachLimitOf5Topics() && !chatGPTTopic.added
	}
	
	var doneButton: some View {
		Button("Done") {
			let newTopics = viewModel.chatGPTTopics.filter { $0.added }.map { Topic(id: UUID().uuidString, name: $0.name) }
			note.topics.append(contentsOf: newTopics)
			presentationMode.wrappedValue.dismiss()
		}
		.buttonStyle(.borderedProminent)
		.disabled(viewModel.reachLimitOf5Topics())
	}
}

struct TopicsView_Previews: PreviewProvider {
	static var previews: some View {
		TopicsView(note: .constant(Note(id: "23", title: "title", body: "body", topics: [], ideas: [])), completion: { })
	}
}
extension Array where Element: Hashable {
	func difference(from other: [Element]) -> [Element] {
		let thisSet = Set(self)
		let otherSet = Set(other)
		return Array(thisSet.subtracting(otherSet))
	}
}
