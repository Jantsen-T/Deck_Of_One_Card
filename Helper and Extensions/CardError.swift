//
//  CardError.swift
//  DeckOfOneCard
//
//  Created by Jantsen Tanner on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach Server"
        case .thrownError(let error) :
            print(error.localizedDescription)
            return "That card does not exist\nPlease check spelling"
        case .noData:
            return "The servier responded with no data"
        case .unableToDecode:
            return "The server responded with bad data"
        }
    }
}
