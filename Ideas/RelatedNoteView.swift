//
//  RelatedNoteView.swift
//  Ideas
//
//  Created by Omar Torres on 19/12/23.
//

import SwiftUI

struct RelatedNoteView: View {
	
	var note: RelatedNote
	@Environment(\.presentationMode) var presentationMode
	
    var body: some View {
		navigationBarBackButton
		GeometryReader { geometry in
			ScrollView {
				VStack(alignment: .leading, spacing: 5) {
					Text(note.title)
						.font(Font.title3.weight(.semibold))
					Text(note.body)
				}
				.padding([.leading, .trailing, .bottom], 10)
				.frame(maxWidth: .infinity, maxHeight: .infinity)
			}
		}
    }
	
	var navigationBarBackButton: some View {
		VStack {
			Spacer()
				.navigationBarBackButtonHidden()
				.toolbar {
					ToolbarItem(placement: .navigationBarLeading) {
						Button(
							action: {
								presentationMode.wrappedValue.dismiss()
							},
							label: {
								Image(systemName: "chevron.backward")
							}
						)
					}
				}
		}
	}
}

struct RelatedNoteView_Previews: PreviewProvider {
    static var previews: some View {
		RelatedNoteView(note: RelatedNote(id: "1",
										  title: "title",
										  body: "body",
										  topics: [],
										  user: User(name: "Juan")))
    }
}
