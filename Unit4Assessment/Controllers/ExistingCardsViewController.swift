//
//  ExistingCardsViewController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//
//


import UIKit
import DataPersistence

class ExistingCardsViewController: UIViewController {
    
    
    
    
    public var dataPersistence: DataPersistence<Card>!
    
    
    let existingCardsView = ExistingCardsView()
    let createCardVC = CreateCardViewController()
    
    public var cards = [Card]() {
        didSet {
             existingCardsView.collectionView.reloadData()
            if cards.isEmpty {

                existingCardsView.collectionView.backgroundView = EmptyView(title: "Uh oh!", message: "No cards yet! Click create to get started.")
                
            } else {
                 
                existingCardsView.collectionView.backgroundView = nil
                createCardVC.resetTextViewsAndFields()
                
            }
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        
            fetchSavedCards()
    
    }

override func loadView() {
    view = existingCardsView
    
}
override func viewDidLoad() {
    super.viewDidLoad()
    self.existingCardsView.collectionView.delegate = self
    self.existingCardsView.collectionView.dataSource = self
    view.backgroundColor = .white
    self.existingCardsView.collectionView.register(MainViewCardCell.self, forCellWithReuseIdentifier: "cardCell")
    
    
}
    
        public func fetchSavedCards() {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? MainViewCardCell else {
            fatalError("Unable to dequeue Card Cell")
        }
        
        cell.backgroundColor = .white
        cell.delegate = self
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
                existingCardsView.collectionView.reloadData()

    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        
    }
    
    
}

extension ExistingCardsViewController: CardCellDelegate {
    func didSelectDeleteButton(_ savedCardCell: MainViewCardCell, card: Card) {
        print("what")
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { alertAction in
            self.deleteArticle(card)
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true)
        
        existingCardsView.collectionView.reloadData()

}
    
     private func deleteArticle(_ card: Card) {
            guard let index = cards.firstIndex(of: card) else {
                return
            }
            do {
                try dataPersistence.deleteItem(at: index)
                fetchSavedCards()
                let createCardVC = CreateCardViewController()
                createCardVC.dataPersistence = dataPersistence
            } catch {
                view = EmptyView(title: "NO", message: "NO")
            }
        }
    }
