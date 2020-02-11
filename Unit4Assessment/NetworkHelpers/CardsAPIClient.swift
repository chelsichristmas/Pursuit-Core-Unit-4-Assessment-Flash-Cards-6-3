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
  

  
    static func postCard(card: Card, completion: @escaping (Result<Bool,AppError>) -> ()) {
    
    let endpointURLString = "https://5daf8b36f2946f001481d81c.mockapi.io/api/v2/cards"
    
    
    guard let url = URL(string: endpointURLString) else {
      completion(.failure(.badURL(endpointURLString)))
      return
    }
    
    do {
      let data = try JSONEncoder().encode(card)
      
      var request = URLRequest(url: url)
      
      request.httpMethod = "POST"
      
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      
      request.httpBody = data
      
      NetworkHelper.shared.performDataTask(with: request) { (result) in
        switch result {
        case .failure(let appError):
          completion(.failure(.networkClientError(appError)))
        case .success:
          completion(.success(true))
        }
      }
      
    } catch {
      completion(.failure(.encodingError(error)))
    }
    
  }

}

