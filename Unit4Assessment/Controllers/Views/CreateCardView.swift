//
//  CreateCardView.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class CreateCardView: UIView {
    
    public lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Title"
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    public lazy var factOneTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Enter a fact about this question"
        textView.textColor = .systemGray
        return textView
        
    }()
    
    public lazy var factTwoTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Enter a fact about this question"
        textView.textColor = .systemGray
        return textView
        
    }()
    
    private var isSelected = false
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init? (coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit(){
        setupTitleTextFieldConstraints()
        setupFactOneTextViewConstraints()
        setupFactTwoTextViewConstraints()
    }
    
    private func setupTitleTextFieldConstraints() {
        addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
            titleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupFactOneTextViewConstraints() {
        addSubview(factOneTextView)
        factOneTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            factOneTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            factOneTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            factOneTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            factOneTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.30)
            
        ])
        
    }
    private func setupFactTwoTextViewConstraints() {
        addSubview(factTwoTextView)
        factTwoTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate ([
            factTwoTextView.topAnchor.constraint(equalTo: factOneTextView.bottomAnchor, constant: 15),
            factTwoTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            factTwoTextView.trailingAnchor.constraint(equalTo: titleTextField.trailingAnchor),
            factTwoTextView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.30)
        ])
    }
    
}
