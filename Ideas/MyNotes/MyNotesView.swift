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
				noteList
			}
			newNote
		}
		.onAppear {
			UITextView.appearance().textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
		}
	}
	
	var noteList: some View {
		List {
			ForEach($viewModel.notes) { $note in
				ZStack(alignment: .leading) {
					NavigationLink {
						NoteView(note: $note) { note, toUpdate in
							if toUpdate {
								print("Note \(note.id)-\(note.body) needs to be updated")// hit here some api service endpoint to update the particular note. This will run in the background, so the user won't be affected from keep interacting witht the app).
							}
						}
						.toolbarRole(.editor)
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
			.toolbarRole(.editor)
		} label: {
			Image(systemName: "square.and.pencil")
				.resizable()
				.scaledToFit()
				.frame(width: 20, height: 20)
		}.simultaneousGesture(TapGesture().onEnded {
			UINavigationBar.setAnimationsEnabled(false)
		})
	}
}

struct MyNotesView_Previews: PreviewProvider {
	static var previews: some View {
		MyNotesView()
	}
}
