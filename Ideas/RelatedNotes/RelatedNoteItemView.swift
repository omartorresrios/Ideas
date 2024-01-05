//
//  RelatedNoteItemView.swift
//  Ideas
//
//  Created by Omar Torres on 05/01/24.
//

import SwiftUI

struct RelatedNoteItemView: View {
	private let note: RelatedNote
	private var isLast: Bool
	
	init(note: RelatedNote, isLast: Bool) {
		self.note = note
		self.isLast = isLast
	}
	
	var body: some View {
		NavigationLink(destination: RelatedNoteView(note: note)) {
			HStack(alignment: .top) {
				Image(systemName: "person.crop.circle")
					.resizable()
					.renderingMode(.template)
					.foregroundColor(.black)
					.frame(width: 30, height: 30)
				
				VStack(alignment: .leading, spacing: 5) {
					Text(note.user.name)
						.font(Font.title3.weight(.semibold))
						.foregroundColor(.black)
					
					VStack(alignment: .leading) {
						Text(note.title)
							.lineLimit(1)
							.font(Font.body.weight(.semibold))
							.foregroundColor(.black)
						Text(note.body)
							.lineLimit(2)
							.foregroundColor(.black)
					}
					.multilineTextAlignment(.leading)
					.frame(maxWidth: .infinity, alignment: .leading)
				}
			}
		}
		if !isLast {
			Divider()
		}
	}
}


struct RelatedNoteItemView_Previews: PreviewProvider {
    static var previews: some View {
		RelatedNoteItemView(note: RelatedNote(id: "id",
											  title: "title",
											  body: "body",
											  topics: [],
											  user: User(name: "user")),
							isLast: false)
    }
}
