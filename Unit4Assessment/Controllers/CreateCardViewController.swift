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

    override func loadView() {
        view = createCardView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
    }
    

    

}
