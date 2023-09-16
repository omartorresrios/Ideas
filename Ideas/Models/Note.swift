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
		get { title.isEmpty && body.isEmpty }
		set {}
	}
	
	mutating func addIdeasToBody() {
		let ideasText = ideas.map { $0.body }.joined(separator: "\n")
		body = body + "\n" + ideasText
	}
}

struct Idea {
	let body: String
	var added = false
}
