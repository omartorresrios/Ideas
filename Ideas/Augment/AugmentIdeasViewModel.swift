//
//  AugmentIdeasViewModel.swift
//  Ideas
//
//  Created by Omar Torres on 18/12/23.
//

import Foundation

class AugmentIdeasViewModel: ObservableObject {
	@Published var newIdeas = [Idea]()
	
	init() {
		newIdeas = [Idea(body: "This is the first suggestion to explore for example this is a large idea of more than 1 line"),
					Idea(body: "This is the second suggestion to explore"),
					Idea(body: "This is the third suggestion to explore")]
	}
	
	func noIdeasSelected() -> Bool {
		return newIdeas.filter { $0.added }.count == 0
	}
	
	var ideasSelectedText: String {
		return newIdeas.filter({ $0.added }).count == 1 ? "Add idea" : "Add ideas"
	}
}
