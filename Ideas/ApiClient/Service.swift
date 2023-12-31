//
//  Service.swift
//  Ideas
//
//  Created by Omar Torres on 31/08/23.
//

import Foundation

final class Service {
	
	static let completionsURL = "https://api.openai.com/v1/completions"
	static let davinciModel = "text-davinci-003"
	static let temperature = 0
	static let maxTokens = 1000
	
	enum Error: Swift.Error {
		case invalidURL
		case plistFailed
		case invalidData
	}
	
	static func completionsUrlRequest(url: URL, openAIKey: String, jsonData: Data?) -> URLRequest {
		var request = URLRequest(url: url)
		request.httpMethod = "POST"
		request.httpBody = jsonData
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		request.setValue("Bearer \(openAIKey)", forHTTPHeaderField: "Authorization")
		return request
	}
	
	static func makeCompletion(with prompt: String) async throws -> TextCompletion {
		guard let url = URL(string: completionsURL) else { throw Error.invalidURL }
		
		let json: [String: Any] = ["model": davinciModel,
								   "prompt": prompt,
								   "temperature": temperature,
								   "max_tokens": maxTokens]
		let jsonData = try? JSONSerialization.data(withJSONObject: json)
		
		guard let plistPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
			  let plistDict = NSDictionary(contentsOfFile: plistPath),
			  let openAIKey = plistDict.object(forKey: "OpenAIKey") as? String else { throw Error.plistFailed }
		
		let request = completionsUrlRequest(url: url, openAIKey: openAIKey, jsonData: jsonData)
//
//		do {
			let (data, _) = try await URLSession.shared.data(for: request)
	//		guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw Error.invalidData }
			let decoder = JSONDecoder()
			decoder.keyDecodingStrategy = .convertFromSnakeCase
			let json1 = try JSONSerialization.jsonObject(with: data)
			print("the json: ", json1)
			let textCompletion = try decoder.decode(TextCompletion.self, from: data)
			return textCompletion
//		} catch {
//			print("what's the error?: ", error)
//			throw error
//		}
		
	}
}
