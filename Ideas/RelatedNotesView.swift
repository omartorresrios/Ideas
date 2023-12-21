//
//  RelatedNotesView.swift
//  Ideas
//
//  Created by Omar Torres on 18/12/23.
//

import SwiftUI

class RelatedNotesViewModel: ObservableObject {
	@Published var relatedNotes = [RelatedNote]()
	
	init() {
		relatedNotes = [RelatedNote(id: UUID().uuidString,
									title: "This is my note regarding the thoughts",
									body: "Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet.Something I have not thought thourhg yet. And this is the end",
									topics: [],
									user: User(name: "Omar Torres")),
						RelatedNote(id: UUID().uuidString,
									title: "And obviously about our nature",
									body: "Which is funny because is something causal.",
									topics: [Topic(id: UUID().uuidString, name: "Health"),
											 Topic(id: UUID().uuidString, name: "Sports")],
									user: User(name: "Barbara Shulf"))]
	}
}

struct RelatedNotesView: View {
	@StateObject var viewModel = RelatedNotesViewModel()
	private let topicName: String
	
	init(on topicName: String) {
		self.topicName = topicName
	}
	
    var body: some View {
		NavigationView {
			VStack(spacing: 0) {
				Text("Related notes on **\(topicName)**")
					.padding()
				relatedNotes
			}
		}
    }
	
	var relatedNotes: some View {
		List {
			ForEach(viewModel.relatedNotes) { note in
				ZStack(alignment: .leading) {
					NavigationLink {
						RelatedNoteView(note: note)
					} label: {
						EmptyView()
					}
					.opacity(0.0)
					
					HStack(alignment: .top) {
						Image(systemName: "person.crop.circle")
							.resizable()
							.frame(width: 30, height: 30)
						
						VStack(alignment: .leading, spacing: 5) {
							Text(note.user.name)
								.font(Font.title3.weight(.semibold))
							VStack(alignment: .leading, spacing: 0) {
								Text(note.title)
									.lineLimit(1)
									.font(Font.body.weight(.semibold))
								Text(note.body)
									.lineLimit(2)
							}
						}
					}
				}
			}
		}
		.listStyle(.plain)
	}
	
	var navigationBarCloseButton: some View {
		VStack {
			Spacer()
				.navigationBarBackButtonHidden()
				.toolbar {
					ToolbarItem(placement: .navigationBarTrailing) {
						Button(
							action: {
//								presentationMode.wrappedValue.dismiss()
							},
							label: {
								Image(systemName: "chevron.backward")
							}
						)
					}
				}
		}
	}
}

struct RelatedNotesView_Previews: PreviewProvider {
    static var previews: some View {
		RelatedNotesView(on: "Genetics")
    }
}
