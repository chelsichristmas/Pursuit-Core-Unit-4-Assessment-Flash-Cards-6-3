//
//  CardsAPIClient.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import NetworkHelper

struct CardsAPIClient {
  

  
   static func fetchTopStories(completion: @escaping ( Result<[Card], AppError>) -> ()) {
      let endpointURLString = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
      guard let url = URL(string: endpointURLString) else {
        completion(.failure(.badURL(endpointURLString)))
        return
      }
      let request = URLRequest(url: url)
      NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success(let data):
          do {
            let cardStruct = try JSONDecoder().decode(CardStruct.self, from: data)
            completion(.success(cardStruct.cards))
          } catch {
            completion(.failure(.decodingError(error)))
          }
        }
      }
    }

}

