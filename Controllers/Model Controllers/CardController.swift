//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Jantsen Tanner on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/?count=1")

    
    
    
    static func fetchCard(completion: @escaping (Result <Card, CardError>) -> Void) {
        //MARK: - Prepare URL
        
        guard let finalURL = baseURL else { return completion(.failure(.invalidURL))}
        print(finalURL)
        //MARK: - Contact Server
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                //MARK: - Handle Errors
                return completion(.failure(.thrownError(error)))
                
            }
            if let response = response as? HTTPURLResponse {
                print("Card Status Code: \(response.statusCode)")
            }
            //MARK: - Check for JSON Data
            guard let data = data else { return completion(.failure(.noData))}
            do {
                //MARK: - Decode JSON into Card
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else { return completion(.failure(.unableToDecode))}
                completion(.success(card))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void) {
        guard let url = card.image else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("Image Status Code: \(response.statusCode)")
            }
            guard let data = data else { return completion(.failure(.noData))
            }
            guard let image = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(image))
        }.resume()
    }
}// End of class

