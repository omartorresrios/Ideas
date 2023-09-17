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
		notes = [Note(id: UUID().uuidString, title: "first note title", body: "first note body", topics: [], ideas: []),
				 Note(id: UUID().uuidString,
					  title: "second note title",
					  body: "second note body",
					  topics: [Topic(id: UUID().uuidString, name: "Health", added: true),
							   Topic(id: UUID().uuidString, name: "Sports", added: true)], ideas: [])]
	}
	
	func addNewNote(_ note: Note) {
		notes.insert(note, at: 0)
		emptyNote = Self.emptyNote()
	}
	
	private static func emptyNote() -> Note {
		Note(id: UUID().uuidString, title: "", body: "", topics: [], ideas: [])
	}
}
