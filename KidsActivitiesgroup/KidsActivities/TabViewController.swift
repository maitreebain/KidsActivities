//
//  TabViewController.swift
//  KidsActivities
//
//  Created by Maitree Bain on 4/14/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    private lazy var optionsViewController: OptionsViewController = {
        let storyboard = UIStoryboard(name: "OptionsStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "OptionsViewController") as OptionsViewController
        viewController.tabBarItem = UITabBarItem(title: "Options", image: UIImage(systemName: "photo.fill"), tag: 0)
        return viewController
    }()
    
    private lazy var submittedActivitiesController: SubmittedActivitiesViewController = {
        let storyboard = UIStoryboard(name: "SubmittedStoryboard", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SubmittedActivitiesViewController") as SubmittedActivitiesViewController
        viewController.tabBarItem = UITabBarItem(title: "Activities", image: UIImage(systemName: "star.fill"), tag: 1)
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
            
            viewControllers = [UINavigationController(rootViewController: optionsViewController),
            UINavigationController(rootViewController: submittedActivitiesController)]
            
    }

}
