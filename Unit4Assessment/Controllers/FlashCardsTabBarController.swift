//
//  FlashCardsTabBarController.swift
//  Unit4Assessment
//
//  Created by Chelsi Christmas on 2/11/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import DataPersistence

class FlashCardsTabBarController: UITabBarController {
    
    private var dataPersistence = DataPersistence<Card>(filename: "savedCards.plist")
    
    private lazy var existingCardsVC: ExistingCardsViewController = {
     let viewController = ExistingCardsViewController()
        viewController.tabBarItem = UITabBarItem(title: "Cards", image: UIImage(systemName: "studentdesk"), tag: 0)
        viewController.dataPersistence = dataPersistence
        
        return viewController
    }()
    
    private lazy var createCardVC: CreateCardViewController = {
        let viewController = CreateCardViewController()
        
        viewController.tabBarItem = UITabBarItem(title: "Create", image: UIImage(systemName: "plus"), tag: 1)
        viewController.dataPersistence = dataPersistence
        return viewController
    }()
    
    private lazy var searchVC: SearchViewController = {
        let viewController = SearchViewController()
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
       
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
         viewControllers = [UINavigationController(rootViewController: existingCardsVC), UINavigationController(rootViewController: createCardVC), UINavigationController(rootViewController: searchVC)]


    }

}
