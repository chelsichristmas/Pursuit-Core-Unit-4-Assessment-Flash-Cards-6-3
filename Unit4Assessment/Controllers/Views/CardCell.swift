//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol CardCellDelegate: AnyObject {
func didSelectDeleteButton(_ savedCardCell: CardCell, card: Card)
}

class CardCell: UICollectionViewCell {
    
    public var card: Card?
    
    private var isShowingQuestion = true
    
    weak var delegate: CardCellDelegate?
    
    public lazy var titleLabel: UILabel = {
      let label = UILabel()
        label.text = card?.cardTitle
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    public lazy var factLabel: UILabel = {
     let label = UILabel()
        label.numberOfLines = 3
        label.alpha = 0
     return label
    }()
    
   
    
    private lazy var tapGesture: UITapGestureRecognizer = {
          let gesture = UITapGestureRecognizer()
          gesture.addTarget(self, action: #selector(didPress(_:)))
          return gesture
      }()
    
    public lazy var moreButton: UIButton = {
          let button = UIButton()
          button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
          button.addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
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
        setupMoreButtonConstraints()
    }
    
    private func setupMoreButtonConstraints() {
        addSubview(moreButton)
        moreButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: topAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            moreButton.heightAnchor.constraint(equalToConstant: 44),
            moreButton.widthAnchor.constraint(equalTo: moreButton.heightAnchor)
        ])
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupFirstFactLabelConstraint() {
        addSubview(factLabel)
        factLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//        factLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
//        factLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
        factLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        factLabel.centerYAnchor.constraint(equalTo: centerYAnchor)

        
        ])
    }
    
    
    
    public func configureCell(with: Card) {
        titleLabel.text = card?.cardTitle
        factLabel.text = card?.facts
    }
    
    @objc private func didPress(_ gesture: UITapGestureRecognizer) {
//        guard let card = card else { return }
        if gesture.state == .began || gesture.state == .changed {
            return
        }
        isShowingQuestion.toggle()
        self.animate()// true -> false -> true
        
    }
    
    private func animate() {
        let duration = 0.75
        if isShowingQuestion {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 1.0
                self.moreButton.alpha = 1.0
                self.factLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromLeft], animations: {
                self.titleLabel.alpha = 0.0
                self.moreButton.alpha = 0.0
                self.factLabel.alpha = 1.0
                       }, completion: nil)
        }
    }
    
      
    
    @objc private func deleteButtonPressed(_ sender: UIButton) {
         print("Button was pressed for delete card")
         delegate?.didSelectDeleteButton(self, card: card!)
     }
     
    
    
}
