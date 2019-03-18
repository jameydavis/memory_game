//
//  GameplayViewController.swift
//  Memory Game
//
//  Created by Jamey Davis on 3/17/19.
//  Copyright © 2019 Jamey Davis. All rights reserved.
//

import UIKit

class GameplayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let inset: CGFloat = 10
    let minimumSpacing: CGFloat = 10
    let minimumInteritemSpacing: CGFloat = 10
    let cellsPerRow = UserDefaults.standard.integer(forKey: "NumberOfColumns")
    let cardCount = UserDefaults.standard.integer(forKey: "NumberOfCards")
    var model = CardModel()
    var cardArray = [Card]()
    
    var grid: [Int] = []
    
    var firstFlippedCardIndex: IndexPath?

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        self.collectionView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    // MARK: - UICollectionView Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardCount
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
                checkForMatches(indexPath)
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // MARK: - Actions    
    @IBAction func backToLobby(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Game Logic Methods
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.item]
        let cardTwo = cardArray[secondFlippedCardIndex.item]
        
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            cardOne.isFlipped = true
            cardTwo.isFlipped = true
        } else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            if cardOneCell == nil {
                collectionView.reloadItems(at: [firstFlippedCardIndex!])
            }
        }
        
        firstFlippedCardIndex = nil
    }
    

}

