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
		VStack(spacing: 0) {
			Text("Related topics")
				.font(Font.body.weight(.semibold))
				.padding()
			VStack(spacing: 10) {
				if viewModel.reachLimitOf5Topics() {
					Text("A note can't have more than 5 topics.")
						.foregroundStyle(.red)
						.frame(maxWidth: .infinity)
						.padding()
						.background(.white)
						.cornerRadius(8)
				}
				ScrollView(showsIndicators: false) {
					VStack(spacing: 15) {
						ForEach(viewModel.chatGPTTopics.indices, id: \.self) { index in
							ChatGPTTopicItemView(topic: $viewModel.chatGPTTopics[index],
												 isLast: viewModel.chatGPTTopics.last == viewModel.chatGPTTopics[index],
												 disabledAddedButton: disableAddTopicButton(for: viewModel.chatGPTTopics[index]))
						}
					}
					.padding()
					.background(.white)
					.cornerRadius(8)
				}
			}
			.padding([.leading, .trailing])
			Spacer()
			addButton
		}
		.background(Color(UIColor.systemGray6))
		.onAppear {
			viewModel.getTopics(currentTopics: note.topics)
		}
	}
	
	private func disableAddTopicButton(for chatGPTTopic: ChatGPTTopic) -> Bool {
		return viewModel.reachLimitOf5Topics() && !chatGPTTopic.added
	}
	
	var addButton: some View {
		Button {
			let newTopics = viewModel.chatGPTTopics.filter { $0.added }.map { Topic(id: UUID().uuidString, name: $0.name) }
			note.topics.append(contentsOf: newTopics)
			presentationMode.wrappedValue.dismiss()
		} label: {
			Text(viewModel.topicsSelectedText)
				.frame(maxWidth: .infinity)
		}
		.buttonStyle(.borderedProminent)
		.controlSize(.large)
		.padding([.leading, .trailing])
		.disabled(viewModel.reachLimitOf5Topics() || viewModel.noTopicsSelected())
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
