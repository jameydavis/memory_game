//
//  CardModel.swift
//  Memory Game
//
//  Created by Jamey Davis on 3/17/19.
//  Copyright © 2019 Jamey Davis. All rights reserved.
//

import Foundation

class CardModel {
    
    let pairsMultiplier = UserDefaults.standard.integer(forKey: "PairsMultiplier")
    
    func getCards() -> [Card] {
        
        var generatedNumbersArray = [Int]()
        var generatedCardsArray = [Card]()
        
        while generatedNumbersArray.count < pairsMultiplier {
            
            let randomNumber = arc4random_uniform(10) + 1
            
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                generatedNumbersArray.append(Int(randomNumber))
                
                let cardOne = Card()
                cardOne.imageName = "memoryCardFront_\(randomNumber)"
                generatedCardsArray.append(cardOne)
                
                let cardTwo = Card()
                cardTwo.imageName = "memoryCardFront_\(randomNumber)"
                generatedCardsArray.append(cardTwo)
                
                for i in 0...generatedCardsArray.count - 1 {
                    let randomNumber = Int(arc4random_uniform(UInt32(generatedCardsArray.count)))
                    let temporaryStorage = generatedCardsArray[i]
                    generatedCardsArray[i] = generatedCardsArray[randomNumber]
                    generatedCardsArray[randomNumber] = temporaryStorage
                }
            }
        }
        
        return generatedCardsArray
    }
}
