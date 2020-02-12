//
//  SearchViewController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class SearchViewController: UIViewController {
    
    
    var cards = [Card]() {
        didSet {
            DispatchQueue.main.async {
                self.searchView.collectionView.reloadData()
            }
        }
    }
    
    public var dataPersistence: DataPersistence<Card>!
    let searchView = SearchView()

    
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
loadStories()
        view.backgroundColor = .yellow
        self.searchView.collectionView.delegate = self
        self.searchView.collectionView.dataSource = self
        self.searchView.collectionView.register(SearchViewCardCell.self, forCellWithReuseIdentifier: "cardCell")
    }
    
    
    func loadStories() {
        CardsAPIClient.fetchTopStories( completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("Error loading cards from search: \(appError)")
            case .success(let cards):
                self?.cards = cards
            }
        })
    }
}
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? SearchViewCardCell else {
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

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.90
        let itemHeight: CGFloat = maxSize.height * 0.30
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

extension SearchViewController: SearchCardCellDelegate {
    func didSelectAddButton(_ searchCardCell: SearchViewCardCell, card: Card) {
        
        
        let existingCardsVC = ExistingCardsViewController()
        
        do {
            try dataPersistence.createItem(card)
          existingCardsVC.cards.append(card)
            showAlert(title: "Success!", message: " This card has been added to your collection.")
            searchCardCell.alpha = 0.5
            searchCardCell.isUserInteractionEnabled = false
        } catch {
            
        }
    

}
    
    
    }



