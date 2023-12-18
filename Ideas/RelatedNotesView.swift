//
//  RelatedNotesView.swift
//  Ideas
//
//  Created by Omar Torres on 18/12/23.
//

import SwiftUI

class RelatedNotesViewModel: ObservableObject {
	@Published var notes = [Note]()
	
	init() {
		notes = [Note(id: UUID().uuidString,
					  title: "first note title",
					  body: "first note body",
					  topics: [],
					  ideas: []),
				 Note(id: UUID().uuidString,
					  title: "second note title",
					  body: "second note body",
					  topics: [Topic(id: UUID().uuidString, name: "Health"),
							   Topic(id: UUID().uuidString, name: "Sports")],
					  ideas: [])]
	}
}

struct RelatedNotesView: View {
	@StateObject var viewModel = MyNotesViewModel()
	
    var body: some View {
		VStack {
			Text("Related notes")
				.padding()
		}
    }
}

struct RelatedNotesView_Previews: PreviewProvider {
    static var previews: some View {
        RelatedNotesView()
    }
}
