//
//  AugmentIdeasView.swift
//  Ideas
//
//  Created by Omar Torres on 16/09/23.
//

import SwiftUI

struct AugmentIdeasView: View {
	@Binding var note: Note
	@StateObject var viewModel = AugmentIdeasViewModel()
	@Environment(\.presentationMode) var presentationMode
	let completionHandler: () -> Void
	
    var body: some View {
		VStack(spacing: 0) {
			Text("Explore new ideas")
				.font(Font.body.weight(.semibold))
				.padding()
			ScrollView(showsIndicators: false) {
				LazyVStack(spacing: 15) {
					ForEach(viewModel.newIdeas.indices, id: \.self) { index in
						IdeaItemView(idea: $viewModel.newIdeas[index],
									 isLast: viewModel.newIdeas.last == viewModel.newIdeas[index])
					}
				}
				.padding()
				.background(.white)
				.cornerRadius(8)
			}
			.padding([.leading, .trailing])
			Spacer()
			addButton
		}
		.background(Color(UIColor.systemGray6))
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
		.padding([.leading, .trailing])
		.disabled(viewModel.noIdeasSelected())
	}
}

struct AugmentIdeasView_Previews: PreviewProvider {
    static var previews: some View {
		AugmentIdeasView(note: .constant(Note(id: "", title: "", body: "", topics: [], ideas: [])), completionHandler: { })
    }
}
