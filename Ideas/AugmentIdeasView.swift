//
//  AugmentIdeasView.swift
//  Ideas
//
//  Created by Omar Torres on 16/09/23.
//

import SwiftUI

class AugmentIdeasViewModel: ObservableObject {
	@Published var newIdeas = [Idea]()
	
	init() {
		newIdeas = [Idea(body: "This is the first suggestion to explore"),
					Idea(body: "This is the second suggestion to explore"),
					Idea(body: "This is the third suggestion to explore")]
	}
}

struct AugmentIdeasView: View {
	@Binding var note: Note
	@StateObject var viewModel = AugmentIdeasViewModel()
	@Environment(\.presentationMode) var presentationMode
	let completionHandler: () -> Void
	
    var body: some View {
		VStack {
			Text("Explore new paths")
				.padding()
			List {
				ForEach(viewModel.newIdeas.indices, id: \.self) { index in
					HStack {
						Text(viewModel.newIdeas[index].body)
						Spacer()
						Button {
							viewModel.newIdeas[index].added.toggle()
						} label: {
							viewModel.newIdeas[index].added ? Image(systemName: "minus.circle") : Image(systemName: "plus.circle")
						}
					}
				}
			}
			doneButton
		}
    }
	
	var doneButton: some View {
		Button("Done") {
			let newIdeas = viewModel.newIdeas.filter({ $0.added })
			note.ideas.append(contentsOf: newIdeas)
			note.addIdeasToBody()
			completionHandler()
			presentationMode.wrappedValue.dismiss()
		}
		.buttonStyle(.borderedProminent)
	}
}

struct AugmentIdeasView_Previews: PreviewProvider {
    static var previews: some View {
		AugmentIdeasView(note: .constant(Note(id: "", title: "", body: "", topics: [], ideas: [])), completionHandler: { })
    }
}
