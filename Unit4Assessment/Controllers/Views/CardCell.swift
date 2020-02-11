//
//  CardCell.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

protocol CardCellDelegate: AnyObject {
func didSelectCell(_ savedCardCell: CardCell, card: Card)
}

class CardCell: UICollectionViewCell {
    
    public var card: Card?
    private var isShowingQuestion = true
    weak var delegate: CardCellDelegate?
    
    public lazy var titleLabel: UILabel = {
      let label = UILabel()
        label.text = card?.cardTitle
        label.numberOfLines = 3
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
            print("long pressed")
            return
        }
        isShowingQuestion.toggle()
        self.animate()// true -> false -> true
        
    }
    
    private func animate() {
        let duration = 1.0
        if isShowingQuestion {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 1.0
                self.factLabel.alpha = 0.0
            }, completion: nil)
        } else {
            UIView.transition(with: self, duration: duration, options: [.transitionFlipFromRight], animations: {
                self.titleLabel.alpha = 0.0
                self.factLabel.alpha = 1.0
                       }, completion: nil)
        }
    }
    
    
    
    
}
