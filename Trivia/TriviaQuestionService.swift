//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Quang Nguyen on 10/13/23.
//

import Foundation

class TriviaQuestionService {
    private static let NUM_QUESTIONS = 5
    private static let url = URL(string: "https://opentdb.com/api.php?amount=\(NUM_QUESTIONS)")!
    
    static func fetchTriviaQuestions(completion: (([TriviaQuestion]) -> Void)? = nil) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // error handlings
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            
            // data hanlding
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(response.results)
            }
            
        }
        task.resume()
    }
}
