//
//  MyNotesViewModel.swift
//  Ideas
//
//  Created by Omar Torres on 02/09/23.
//

import Foundation

class MyNotesViewModel: ObservableObject {
	@Published var notes = [Note]()
	@Published var emptyNote = MyNotesViewModel.emptyNote()
	
	init() {
		notes = [Note(id: UUID().uuidString,
					  title: "The thoughts we carry by default",
					  body: "This is only a test that represents the body for this note.",
					  topics: [],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "The defensive nature of our nature",
					  body: "This is only a test that represents the body for this note.",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: [])]
	}
	
	func addNewNote(_ note: Note) {
		notes.insert(note, at: 0)
		emptyNote = Self.emptyNote()
	}
	
	private static func emptyNote() -> Note {
		Note(id: UUID().uuidString, title: "", body: "", topics: [], ideas: [])
	}
}
