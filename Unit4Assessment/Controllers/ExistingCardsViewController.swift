//
//  ExistingCardsViewController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class ExistingCardsViewController: UIViewController {
    
    public var cards = [Card]()
    // TODO: Persist this array
    
   let existingCardsView = ExistingCardsView()

    override func loadView() {
        view = existingCardsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.existingCardsView.collectionView.delegate = self
        self.existingCardsView.collectionView.dataSource = self
        view.backgroundColor = .white
        self.existingCardsView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cardCell")
    }
    

    

}

extension ExistingCardsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}

extension ExistingCardsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.90
        let itemHeight: CGFloat = maxSize.height * 0.40 // 30%
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
