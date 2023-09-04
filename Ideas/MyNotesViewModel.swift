//
//  MyNotesViewModel.swift
//  Ideas
//
//  Created by Omar Torres on 02/09/23.
//

import Foundation

class MyNotesViewModel: ObservableObject {
	@Published var notes = [Note]()
	
	init() {
		notes = [Note(id: 1, title: "first note title", body: "first note body"),
				 Note(id: 2, title: "second note title", body: "second note body")]
	}
}
