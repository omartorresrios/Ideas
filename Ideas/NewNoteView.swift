//
//  NewNoteView.swift
//  Ideas
//
//  Created by Omar Torres on 31/08/23.
//

import SwiftUI
import Foundation

struct NewNoteView: View {
	@State private var noteText = ""
	@State private var finalNote = ""
	@State private var showTopics = false
	@FocusState private var noteFocused: Bool
	@Binding var titleText: String
	@Binding var bodyText: String
	
	var body: some View {
		GeometryReader { geometry in
			ScrollView {
				VStack(spacing: 0) {
					TextField("Title", text: $titleText, axis: .vertical)
						.focused($noteFocused)
						.padding()
					
					TextEditor(text: $bodyText)
						.scrollContentBackground(.hidden)
				}
				.frame(height: geometry.size.height)
			}
		}
		Spacer()
		themesButton
		.onAppear {
			if titleText.isEmpty && bodyText.isEmpty {
				noteFocused = true
			} else {
				noteFocused = false
			}
		}
		.onDisappear {
			UINavigationBar.setAnimationsEnabled(true)
		}
		if showTopics {
			Topics(topics: finalNote) {
				showTopics.toggle()
			}
		}
	}
	
	var themesButton: some View {
		Button {
			Task {
				do {
					let completion = try await Service.makeCompletion(with: noteText)
					let newNote = (completion.choices.first?.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).filter{!$0.isEmpty}.joined(separator: "\n")
					finalNote = "Because anyone who is deeply interested in writing about something, there is always a profound and genuine desire to dig deeper in the subject. Bringing humans together who have been writing about the same topics, to have conversations, to explore together, to improve their own writing even more.\n List the themes of this text"//newNote
					showTopics.toggle()
				} catch let error {
					print("something went wrong: ", error)
				}
			}
		} label: {
			Text("Get themes")
				.font(.headline)
//							.foregroundColor(.white)
//							.padding()
//							.frame(maxWidth: .infinity)
//							.background(Color(red: 48/255, green: 116/255, blue: 118/255))
//							.cornerRadius(10)
		}
		.buttonStyle(.borderedProminent)
//				}
//				.padding()
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		NewNoteView(titleText: .constant("title"), bodyText: .constant("body"))
	}
}
