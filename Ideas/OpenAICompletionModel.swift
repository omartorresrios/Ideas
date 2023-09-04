//
//  OpenAICompletionModel.swift
//  Ideas
//
//  Created by Omar Torres on 31/08/23.
//

struct Choice: Decodable {
	let text: String
	let finishReason: String
	let index: Int
}

struct Usage: Decodable {
	let promptTokens: Int
	let completionTokens: Int
	let totalTokens: Int
}

struct TextCompletion: Decodable {
	let id: String
	let object: String
	let created: Int
	let model: String
	let choices: [Choice]
	let usage: Usage
}
