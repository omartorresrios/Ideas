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
	@State private var presentingAugmentView = false
	@State private var presentingRelatedNotesView = false
	@FocusState private var titleFocused: Bool
	@FocusState private var bodyFocused: Bool
	@Binding var note: Note
	@State var originalBody = ""
	@State var originalTitle = ""
	@State var enableBodyEditing = true
	@State var showIdeasToExplore = false
	@Environment(\.presentationMode) var presentationMode
	let completion: ((Note, Bool) -> Void)
	@State var selectedTopic = ""
	
	var body: some View {
		navigationBarBackButton
		GeometryReader { geometry in
			ScrollView {
				VStack(spacing: 0) {
					topics
					editor(geometry: geometry)
				}
			}
			.onAppear {
				setInitialValues()
			}
		}
		.toolbar {
			ToolbarItemGroup(placement: .navigationBarTrailing) {
				augmentButton
				topicsButton
			}
		}
		ideasToExploreButton
	}
	
	var navigationBarBackButton: some View {
		VStack {
			Spacer()
				.navigationBarBackButtonHidden()
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button(
							action: {
								if noteHasBeenUpdated() {
									completion(note, true)
								}
								presentationMode.wrappedValue.dismiss()
								completion(note, false)
							},
							label: {
								Image(systemName: "chevron.backward")
							}
						)
					}
				}
		}
	}
	
	var topics: some View {
		HStack {
			ForEach(note.topics.indices, id: \.self) { index in
				let topic = note.topics[index]
				Button {
					presentingRelatedNotesView = true
					selectedTopic = topic.name
				} label: {
					Text(topic.name)
						.padding(EdgeInsets(top: 6, leading: 18, bottom: 6, trailing: 18))
						.foregroundColor(.black)
						.background((presentingRelatedNotesView && selectedTopic == topic.name) ? .yellow : Color(UIColor.systemGray6))
						.foregroundStyle(.white)
						.clipShape(Capsule())
				}
				.sheet(isPresented: $presentingRelatedNotesView) {
					RelatedNotesView(on: selectedTopic)
						.presentationDetents([.medium, .fraction(0.85)])
						.presentationDragIndicator(.hidden)
				}
			}
		}
	}
	
	func editor(geometry: GeometryProxy) -> some View {
		VStack(spacing: 0) {
			TextField("Title", text: $note.title, axis: .vertical)
				.onChange(of: note.title) { newValue in
					if newValue.last == "\n" {
						note.title = newValue.components(separatedBy: CharacterSet.newlines).filter { !$0.isEmpty }.joined(separator: "\n")
						bodyFocused = true
						enableBodyEditing = true
					}
				}
				.onChange(of: titleFocused) { newValue in
					handleIdeasToExploreView(with: newValue)
				}
				.font(Font.title3.weight(.semibold))
				.submitLabel(.return)
				.focused($titleFocused)
				.padding([.leading, .trailing, .top])
			
			TextEditor(text: $note.body)
				.disabled(!enableBodyEditing)
				.focused($bodyFocused)
				.scrollContentBackground(.hidden)
				.onChange(of: bodyFocused) { newValue in
					handleIdeasToExploreView(with: newValue)
				}
			if showIdeasToExplore {
				Text(note.ideasToExplore())
					.lineLimit(nil)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
					.foregroundColor(.white)
					.background(.gray)
					.transition(.move(edge: .trailing))
			}
		}
		.frame(height: geometry.size.height)
	}
	
	var augmentButton: some View {
		Button {
			presentingAugmentView = true
		} label: {
			Text("Augment")
				.font(.headline)
		}
		.sheet(isPresented: $presentingAugmentView) {
			AugmentIdeasView(note: $note) {
				enableBodyEditing = true
			}
			.presentationDetents([.medium])
		}
	}
	
	@ViewBuilder
	var ideasToExploreButton: some View {
		if !note.ideas.isEmpty {
			HStack {
				Spacer()
				VStack {
					Button {
						if titleFocused {
							titleFocused = false
						}
						if bodyFocused {
							bodyFocused = false
						}
						withAnimation(.easeInOut(duration: 0.3)) {
							showIdeasToExplore.toggle()
						}
					} label: {
						showIdeasToExplore ? Image(systemName: "arrow.right.square.fill") : Image(systemName: "arrow.left.square.fill")
					}
				}
				.padding()
			}
		}
	}
	
	var topicsButton: some View {
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
			Text("+ Topics")
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
		}
	}
	
	private func noteHasBeenUpdated() -> Bool {
		note.title = note.title.trimmingCharacters(in: .whitespaces)
		note.body = note.body.trimmingCharacters(in: .whitespaces)
		return note.body != originalBody || note.title != originalTitle
	}
	
	private func handleIdeasToExploreView(with focusedStatus: Bool) {
		if focusedStatus && showIdeasToExplore {
			showIdeasToExplore = false
		}
	}
	
	private func setInitialValues() {
		if note.isEmptyNote {
			titleFocused = note.isEmptyNote
			enableBodyEditing = false
		} else {
			originalBody = note.body
			originalTitle = note.title
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		NoteView(note: .constant(Note(id: "1",
									  title: "title",
									  body: "body",
									  topics: [Topic(id: "1", name: "Topic1"),
											   Topic(id: "2", name: "Topic2")],
									  ideas: [])),
				 originalBody: "", completion: { _, _ in })
	}
}
