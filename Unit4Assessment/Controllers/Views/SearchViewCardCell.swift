//
//  SearchViewCardCell.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
protocol SearchCardCellDelegate: AnyObject {
func didSelectAddButton(_ searchCardCell: SearchViewCardCell, card: Card)
}



class SearchViewCardCell: UICollectionViewCell {
        
        public var card: Card?
        
        private var isShowingQuestion = true
        
        weak var delegate: SearchCardCellDelegate?
        
        public lazy var titleLabel: UILabel = {
          let label = UILabel()
            label.text = card?.cardTitle
            label.numberOfLines = 3
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            return label
        }()
        public lazy var factLabel: UILabel = {
         let label = UILabel()
            label.numberOfLines = 5
            label.alpha = 0
         return label
        }()
        
       
        
        private lazy var tapGesture: UITapGestureRecognizer = {
              let gesture = UITapGestureRecognizer()
              gesture.addTarget(self, action: #selector(didPress(_:)))
              return gesture
          }()
        
        public lazy var addButton: UIButton = {
              let button = UIButton()
              button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
              button.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
            button.alpha = 1.0
              return button
          }()
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        
        required init? (coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        private func commonInit(){
            
            setupTitleLabel()
            addGestureRecognizer(tapGesture)
           
            setupFirstFactLabelConstraint()
            setupAddButtonConstraints()
        }
        
        private func setupAddButtonConstraints() {
            addSubview(addButton)
            addButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                addButton.topAnchor.constraint(equalTo: topAnchor),
                addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
                addButton.heightAnchor.constraint(equalToConstant: 44),
                addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor)
            ])
        }
        
        private func setupTitleLabel() {
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
        
        private func setupFirstFactLabelConstraint() {
            addSubview(factLabel)
            factLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                factLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            factLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            factLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            factLabel.centerYAnchor.constraint(equalTo: centerYAnchor)

            
            ])
        }
        
        
        
        public func configureCell(with: Card) {
            titleLabel.text = card?.cardTitle
            factLabel.text = card?.facts.first
        }
        
        @objc private func didPress(_ gesture: UITapGestureRecognizer) {
    //        guard let card = card else { return }
            if gesture.state == .began || gesture.state == .changed {
                return
            }
            isShowingQuestion.toggle()
            self.animate()// true -> false -> true
            
        }
        
        public func animate() {
            let duration = 0.75
            if isShowingQuestion {
                UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                    self.titleLabel.alpha = 1.0
                    self.addButton.alpha = 1.0
                    self.factLabel.alpha = 0.0
                }, completion: nil)
            } else {
                UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                    self.titleLabel.alpha = 0.0
                    self.addButton.alpha = 0.0
                    self.factLabel.alpha = 1.0
                           }, completion: nil)
            }
        }
        
          
        
        @objc private func addButtonPressed(_ sender: UIButton) {
             print("Button was pressed for add card")
             delegate?.didSelectAddButton(self, card: card!)
         }
         
        
        
    }


