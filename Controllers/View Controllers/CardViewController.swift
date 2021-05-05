//
//  CardViewController.swift
//  DeckOfOneCard
//
//  Created by Jantsen Tanner on 5/4/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    @IBOutlet weak var cardLabel: UILabel!
    
    @IBOutlet weak var cardUIImage: UIImageView!
    
    @IBOutlet weak var shuffleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
    }
    
    //MARK: - Properties
    var card: Card?
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        print("\(#function)")
        
        CardController.fetchCard { (result) in
            DispatchQueue.main.async {
                
                switch result {
                case .failure(let error):
                    self.presentErrorToUser(localizedError: error)
                case .success(let card):
                    self.fetchImageAndUpdateViews(for: card)
                }
                
            }
        }
    }
    
    func fetchImageAndUpdateViews(for card: Card) {
        CardController.fetchImage(for: card) { [weak self] result in
            DispatchQueue.main.async {
                
                switch result {
                case .success(let image):
                    self?.cardUIImage.image = image
                    self?.cardLabel.text = "\(card.value) of \(card.suit)"
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                    print ("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
                
            }
        }
    }
}
