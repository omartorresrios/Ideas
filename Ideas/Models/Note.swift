//
//  Note.swift
//  Ideas
//
//  Created by Omar Torres on 10/09/23.
//

import Foundation

struct Note: Identifiable {
	var id: String
	var title: String
	var body: String
	var topics: [Topic]
	var ideas: [Idea]
	
	var isEmptyNote: Bool {
		get { title.isEmpty }
		set {}
	}
	
	func ideasToExplore() -> String {
		let ideasString = ideas.map {
			"\u{2022} " + $0.body
		}.joined(separator: "\n")
		let subtitle = "New ideas to explore"
		return subtitle + "\n\n" + ideasString
	}
}

struct Idea {
	var body: String
	var added = false
}

struct RelatedNote: Identifiable {
	let id: String
	let title: String
	let body: String
	let topics: [Topic]
	let user: User
}
