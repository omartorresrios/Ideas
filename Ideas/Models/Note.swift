//
//  Note.swift
//  Ideas
//
//  Created by Omar Torres on 10/09/23.
//

import Foundation

struct Note: Identifiable {
	let id: Int
	var title: String
	var body: String
	var topics: [Topic]
}
