//
//  MyNotesView.swift
//  Ideas
//
//  Created by Omar Torres on 31/08/23.
//

import SwiftUI

struct MyNotesView: View {
	@StateObject var viewModel = MyNotesViewModel()
	@State var presentingNewNoteView = true
	
	var body: some View {
		NavigationStack {
			if viewModel.notes.isEmpty {
				Text("No notes found. Create one!")
			} else {
				contentView
			}
		}
		.onAppear {
			UITextView.appearance().textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
		}
	}
	
	var contentView: some View {
		ZStack(alignment: .bottomTrailing) {
			notesList
			newNote
		}
	}
	
	var notesList: some View {
		List {
			ForEach($viewModel.notes) { $note in
				ZStack(alignment: .leading) {
					NavigationLink {
						NoteView(note: $note) { note, toUpdate in
							if toUpdate {
								print("Note \(note.id)-\(note.body) needs to be updated")// hit here some api service endpoint to update the particular note. This will run in the background, so the user won't be affected from keep interacting witht the app).
							}
						}
					} label: {
						EmptyView()
					}
					.opacity(0.0)
					
					VStack(alignment: .leading) {
						Text(note.title)
							.lineLimit(1)
							.font(Font.body.weight(.semibold))
						Text(note.body)
							.lineLimit(1)
					}
				}
			}
		}
		.navigationTitle("My notes")
		.navigationBarTitleDisplayMode(.inline)
	}
	
	var newNote: some View {
		NavigationLink {
			NoteView(note: $viewModel.emptyNote) { note, _ in
				if !note.isEmptyNote {
					viewModel.addNewNote(note)
				}
			}
		} label: {
			Image(systemName: "square.and.pencil")
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20)
				.font(.title.weight(.semibold))
				.padding()
				.background(Color.pink)
				.foregroundColor(.white)
				.clipShape(Circle())
		}
		.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
	}
}

struct MyNotesView_Previews: PreviewProvider {
	static var previews: some View {
		MyNotesView()
	}
}
