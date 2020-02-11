//
//  ExistingCardsViewController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class ExistingCardsViewController: UIViewController {
    
    
    
    // TODO: Persist this array
    public var dataPersistence: DataPersistence<Card>!
    
    
    let existingCardsView = ExistingCardsView()
    
    public var cards = [Card]() {
        didSet {
//            existingCardsView.collectionView.reloadData()
//            if cards.isEmpty {
//
//                existingCardsView.collectionView.backgroundView = EmptyView(title: "Uh oh!", message: "No cards yet! Click create to get started.")
//            } else {
//                existingCardsView.collectionView.backgroundView = existingCardsView
//            }
        }
    }


//    {
//       didSet {
//        existingCardsView.collectionView.reloadData()
//


override func loadView() {
    view = existingCardsView
}
override func viewDidLoad() {
    super.viewDidLoad()
    self.existingCardsView.collectionView.delegate = self
    self.existingCardsView.collectionView.dataSource = self
    view.backgroundColor = .white
    self.existingCardsView.collectionView.register(CardCell.self, forCellWithReuseIdentifier: "cardCell")
    fetchSavedCards()
    
//    existingCardsView.collectionView.backgroundView = EmptyView(title: "Uh oh!", message: "No cards yet! Click create to get started.")
    
    print("\(cards.count)")
}
    
        private func fetchSavedCards() {
            do {
                cards = try dataPersistence.loadItems()
            } catch {
                print("error fetching articles: \(error)")
            }
        }
    }







extension ExistingCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? CardCell else {
            fatalError("Unable to dequeue Card Cell")
        }
        
        cell.backgroundColor = .white
        let card = cards[indexPath.row]
        cell.card = card
        cell.configureCell(with: card)
        
        return cell
    }
}

extension ExistingCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.90
        let itemHeight: CGFloat = maxSize.height * 0.30 
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension ExistingCardsViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        print("new item")
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
    
    // when a card is created something happens here
}
