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
									body: "Something I have not thought through yet, but will definetly at some point in the future since this is so much related to my research outcomes that it will be a bit dissapointed to not have it included in my notes by the end of the year.",
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
				ScrollView(showsIndicators: false) {
					LazyVStack(spacing: 15) {
						ForEach(viewModel.relatedNotes.indices, id: \.self) { index in
							RelatedNoteItemView(note: viewModel.relatedNotes[index], isLast: viewModel.relatedNotes.last == viewModel.relatedNotes[index])
						}
					}
					.padding()
					.background(.white)
					.cornerRadius(8)
				}
				.padding([.leading, .trailing])
			}
			.background(Color(UIColor.systemGray6))
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
