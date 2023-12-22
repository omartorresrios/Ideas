//
//  AugmentIdeasView.swift
//  Ideas
//
//  Created by Omar Torres on 16/09/23.
//

import SwiftUI

struct IdeaItem: View {
	@Binding var idea: Idea
	private var isLast = false

	init(idea: Binding<Idea>, isLast: Bool) {
		self._idea = idea
		self.isLast = isLast
	}

	var body: some View {
		HStack(spacing: 2) {
			Text(idea.body)
				.foregroundStyle(.white)
			Spacer()
			Button {
				idea.added.toggle()
			} label: {
				idea.added ? Image(systemName: "minus.circle").renderingMode(.template)
					.foregroundColor(.white) : Image(systemName: "plus.circle").renderingMode(.template)
					.foregroundColor(.white)
			}
		}
		if !isLast {
			Divider()
				.overlay(.white)
				.frame(maxWidth: 100)
		}
	}
}

struct AugmentIdeasView: View {
	@Binding var note: Note
	@StateObject var viewModel = AugmentIdeasViewModel()
	@Environment(\.presentationMode) var presentationMode
	let completionHandler: () -> Void
	
    var body: some View {
		VStack(spacing: 0) {
			Text("Explore new ideas")
				.padding()
//				.background(Color.yellow)
			ScrollView(.vertical, showsIndicators: false) {
				VStack(spacing: 15) {
					ForEach(viewModel.newIdeas.indices, id: \.self) { index in
						IdeaItem(idea: $viewModel.newIdeas[index], isLast: viewModel.newIdeas.last == viewModel.newIdeas[index])
					}
				}
				.padding()
				.background(Color.gray)
				.cornerRadius(8)
			}
			.padding([.leading, .trailing])
//			.background(Color.blue)
			Spacer()
			addButton
		}
    }
	
	var addButton: some View {
		Button {
			let newIdeas = viewModel.newIdeas.filter({ $0.added })
			note.ideas.append(contentsOf: newIdeas)
			completionHandler()
			presentationMode.wrappedValue.dismiss()
		} label: {
			Text(viewModel.ideasSelectedText)
				.frame(maxWidth: .infinity)
		}
		.buttonStyle(.borderedProminent)
		.controlSize(.large)
		.padding()
		.disabled(viewModel.noIdeasSelected())
	}
}

struct AugmentIdeasView_Previews: PreviewProvider {
    static var previews: some View {
		AugmentIdeasView(note: .constant(Note(id: "", title: "", body: "", topics: [], ideas: [])), completionHandler: { })
    }
}
