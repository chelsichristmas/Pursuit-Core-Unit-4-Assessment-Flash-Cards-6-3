//
//  CreateCardViewController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class CreateCardViewController: UIViewController {
    
    let createCardView = CreateCardView()
    
    public var card: Card?
    
    public var dataPersistence: DataPersistence<Card>!

    var questionWasCreated = false
    
    
    override func loadView() {
        view = createCardView
            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        resetTextViewsAndFields()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createCardView.factOneTextView.delegate = self
        self.createCardView.factTwoTextView.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(pressedCreate(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(pressedCancel(_:)))
        

        view.backgroundColor = .systemPink
    }
    
    
    func resetTextViewsAndFields() {
        createCardView.factOneTextView.isEditable = true
        createCardView.factTwoTextView.isEditable = true
        createCardView.factOneTextView.text = ""
        createCardView.factTwoTextView.text = ""
        createCardView.titleTextField.text = ""
        
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
        let existingCardsVC = ExistingCardsViewController()
        existingCardsVC.cards.append(createdCard)
        showAlert(title: "Success!", message: "\(createdCard.cardTitle) has been created.") { action in
          print("something happened")
            self.dismiss(animated: true) {
                self.tabBarController?.selectedIndex = 0
            }
            
        }
        return

}
    
    @objc private func pressedCancel(_ gesture: UITapGestureRecognizer) {
        //        guard let card = card else { return }
            }

    
}

// TODO: Move constraints upward when user is typing in second text view anmd back down when they press return (may need to replace with text field)

extension CreateCardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.isEditable = false
        resignFirstResponder()
    }
}


