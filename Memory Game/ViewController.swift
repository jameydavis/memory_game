//
//  ViewController.swift
//  Memory Game
//
//  Created by Jamey Davis on 3/17/19.
//  Copyright © 2019 Jamey Davis. All rights reserved.
//

import UIKit

class GamePlayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the getCards method of the CardModel
        cardArray = model.getCards()
        
        self.collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    // MARK: - UICollectionView Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.item]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.item]
        
        if card.isFlipped == false && card.isMatched == false {
            cell.flip()
            card.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            } else {
                // TODO: - perform matching logic
                checkForMatches(indexPath)
            }
        }
        
    }
    
    // MARK: - Game Logic Methods
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        // get the cells for the 2 cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // get the cards for the 2 cards taht were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.item]
        let cardTwo = cardArray[secondFlippedCardIndex.item]
        
        // compare
        if cardOne.imageName == cardTwo.imageName {
            // it's a match
            
            // set the status of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // remove the cards from the grid
            cardOneCell?.isUserInteractionEnabled = false
            cardTwoCell?.isUserInteractionEnabled = false
        } else {
            // it's not a match
            
            // set the statues of cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // flip both cards back
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            if cardOneCell == nil {
                collectionView.reloadItems(at: [firstFlippedCardIndex!])
            }
        }
        firstFlippedCardIndex = nil
    }
    

}

