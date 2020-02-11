//
//  CreateCardViewController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardViewController: UIViewController {
    
    let createCardView = CreateCardView()
    
    public var card: Card?
    

    override func loadView() {
        view = createCardView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCardView.factOneTextView.delegate = self
        self.createCardView.factTwoTextView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(pressedCreate(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(pressedCancel(_:)))
        

        view.backgroundColor = .systemPink
    }
    
    
    @objc private func pressedCreate(_ gesture: UITapGestureRecognizer) {
        guard let cardTitle = createCardView.titleTextField.text,
        !cardTitle.isEmpty,
        let factOne = createCardView.factOneTextView.text,
            !factOne.isEmpty,
            let factTwo = createCardView.factTwoTextView.text,
            !factTwo.isEmpty else {
                showAlert(title: "Missing Fields", message: "All fields are required.")
//                sender.isEnabled = true
                return
        }
        
        let createdCard = Card(cardTitle: cardTitle, facts: ("\(factOne), \(factTwo)"))
        let existingCardsView = ExistingCardsViewController()
        existingCardsView.cards.append(createdCard)
        showAlert(title: "Success!", message: "\(createdCard.cardTitle) has been created.")
        
        

        return

    
    
    
    

}
    
    @objc private func pressedCancel(_ gesture: UITapGestureRecognizer) {
        //        guard let card = card else { return }
            }
    //TODO: Implement post function somewhere?
    
}

extension CreateCardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
    }
}


