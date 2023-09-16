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
	
	var isEmptyNote: Bool {
		get { title.isEmpty && body.isEmpty }
		set {}
	}
}
