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
    
    private var placeholderText = "Enter a fact about this question"

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
        self.createCardView.titleTextField.delegate = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .plain, target: self, action: #selector(pressedCreate(_:)))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(pressedCancel(_:)))
        

        view.backgroundColor = .systemGroupedBackground
    }
    
    
    public func resetTextViewsAndFields() {
        createCardView.factOneTextView.isEditable = true
        createCardView.factTwoTextView.isEditable = true
        createCardView.factOneTextView.text = placeholderText
        createCardView.factOneTextView.textColor = .systemGray
        createCardView.factTwoTextView.text = placeholderText
        createCardView.factTwoTextView.textColor = .systemGray
        
        
        
        
    }
    
    @objc private func pressedCreate(_ gesture: UITapGestureRecognizer) {
        
        guard let cardTitle = createCardView.titleTextField.text,
        !cardTitle.isEmpty,
        let factOne = createCardView.factOneTextView.text,
            !factOne.isEmpty,
            let factTwo = createCardView.factTwoTextView.text,
            !factTwo.isEmpty else {
                showAlert(title: "Missing Fields", message: "All fields are required.")
            
                return
        }
        
        let createdCard = Card(cardTitle: cardTitle, facts: ["\(factOne)", "\(factTwo)"])
        let existingCardsVC = ExistingCardsViewController()
        card = createdCard
       
        
        do {
        try dataPersistence.createItem(card!)
    
             existingCardsVC.dataPersistence = dataPersistence
            print("Article saved")
        } catch {
            print("error saving article \(error)")
        }

        
        showAlert(title: "Success!", message: "\(createdCard.cardTitle) has been created.") { action in
            print("something happened, There are \(existingCardsVC.cards.count) cards")
            
            self.dismiss(animated: true) {
                self.tabBarController?.selectedIndex = 0
                
            }
            
        }
        return

}
    
    @objc private func pressedCancel(_ gesture: UITapGestureRecognizer) {
       self.tabBarController?.selectedIndex = 0
            }

    
}



extension CreateCardViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        textView.text = ""
        textView.textColor = .black
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" || text == placeholderText {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}


extension CreateCardViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

