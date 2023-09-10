//
//  Extensions.swift
//  Ideas
//
//  Created by Omar Torres on 10/09/23.
//

import Foundation

extension Array where Element: Equatable {
	 mutating func remove(object: Element) {
		 guard let index = firstIndex(of: object) else {return}
		 remove(at: index)
	 }
}
