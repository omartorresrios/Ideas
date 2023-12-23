//
//  IdeaItemView.swift
//  Ideas
//
//  Created by Omar Torres on 23/12/23.
//

import SwiftUI

struct IdeaItemView: View {
	@Binding var idea: Idea
	private var isLast = false

	init(idea: Binding<Idea>, isLast: Bool) {
		self._idea = idea
		self.isLast = isLast
	}

	var body: some View {
		HStack(spacing: 2) {
			Text(idea.body)
				.foregroundStyle(.white)
			Spacer()
			Button {
				idea.added.toggle()
			} label: {
				idea.added ? Image(systemName: "minus.circle").renderingMode(.template)
					.foregroundColor(.white) : Image(systemName: "plus.circle").renderingMode(.template)
					.foregroundColor(.white)
			}
		}
		if !isLast {
			Divider()
				.overlay(.white)
		}
	}
}

struct IdeaItem_Previews: PreviewProvider {
    static var previews: some View {
		IdeaItemView(idea: .constant(Idea(body: "some idea")),
				 isLast: false)
    }
}
