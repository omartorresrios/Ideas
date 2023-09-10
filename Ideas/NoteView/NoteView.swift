//
//  NoteView.swift
//  Ideas
//
//  Created by Omar Torres on 31/08/23.
//

import SwiftUI
import Foundation

struct NoteView: View {
	@State private var noteText = ""
	@State private var finalNote = ""
	@State private var presentingTopicsView = false
	@FocusState private var noteFocused: Bool
	@Binding var note: Note
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				topics
				VStack(spacing: 0) {
					TextField("Title", text: $note.title, axis: .vertical)
						.focused($noteFocused)
						.padding()
					
					TextEditor(text: $note.body)
						.scrollContentBackground(.hidden)
				}
				.frame(height: geometry.size.height)
			}
		}
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				themesButton
			}
		}
		
		.onAppear {
			if note.title.isEmpty && note.body.isEmpty {
				noteFocused = true
			} else {
				noteFocused = false
			}
		}
		.onDisappear {
			UINavigationBar.setAnimationsEnabled(true)
		}
	}
	
	var topics: some View {
		HStack {
			ForEach(note.topics.indices, id: \.self) { index in
				let topic = note.topics[index]
				Text(topic.name)
					.padding(10)
					.background(.gray)
					.foregroundStyle(.white)
					.clipShape(Capsule())
			}
		}
	}
	
	var themesButton: some View {
		Button {
//			Task {
//				do {
//					let completion = try await Service.makeCompletion(with: noteText)
//					let newNote = (completion.choices.first?.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).filter{!$0.isEmpty}.joined(separator: "\n")
//					finalNote = "Because anyone who is deeply interested in writing about something, there is always a profound and genuine desire to dig deeper in the subject. Bringing humans together who have been writing about the same topics, to have conversations, to explore together, to improve their own writing even more.\n List the themes of this text"//newNote
					presentingTopicsView = true
//				} catch let error {
//					print("something went wrong: ", error)
//				}
//			}
		} label: {
			Text(note.topics.isEmpty ? "Add topics" : "Add more topics")
				.font(.headline)
//							.foregroundColor(.white)
//							.padding()
//							.frame(maxWidth: .infinity)
//							.background(Color(red: 48/255, green: 116/255, blue: 118/255))
//							.cornerRadius(10)
		}
		.disabled(note.topics.count == 5)
		.sheet(isPresented: $presentingTopicsView) {
			TopicsView(note: $note) {
				presentingTopicsView = false
			}
			.presentationDetents([.fraction(0.60)])
			.interactiveDismissDisabled()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		NoteView(note: .constant(Note(id: 1, title: "title", body: "body", topics: [])))
	}
}