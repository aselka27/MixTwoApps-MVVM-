//
//  ViewController.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // MARK: - Properties
    
    let stopwatchVC = StopwatchViewController()
    let toDoVC = UINavigationController(rootViewController: TaskViewController())
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK: - Configure UI
    
    func configureUI() {
        stopwatchVC.title = "ToDo"
        toDoVC.title = "Clock"
        
        assignVCs()
        setImages()
        
        tabBar.tintColor = .black
    }
    
    func assignVCs() {
        setViewControllers([stopwatchVC, toDoVC], animated: true)
    }
    
    func setImages() {
        guard let items = self.tabBar.items else {return}
        let images = ["clock.arrow.2.circlepath", "scroll"]
        for i in 0...images.count-1 {
            items[i].image = UIImage(systemName: images[i])
        }
    }
}

