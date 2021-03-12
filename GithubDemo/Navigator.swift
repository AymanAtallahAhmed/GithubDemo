//
//  Navigator.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
import RxCocoa

class Navigator {
    
    private let window: UIWindow
    
    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    enum ViewController {
      case followersList(String)
    }
    
    func show(viewController: ViewController, sender: UIViewController) {
        if case let .followersList(userName) = viewController {
            let viewModel = FollowersListViewModel.init(userName: userName)
            let followersVC = FollowersListVC.init(viewModel: viewModel, navigator: self)
            show(target: followersVC, sender: sender)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let navController = sender as? UINavigationController {
            navController.pushViewController(target, animated: true)
        } else {
            sender.present(target, animated: true)
        }
    }
    
    func start() {
        let baseNavigation = UINavigationController()
        baseNavigation.navigationBar.tintColor = .black
        window.rootViewController = baseNavigation
        window.makeKeyAndVisible()
        self.show(target: rootViewController, sender: baseNavigation)
    }
    
    private var rootViewController: UIViewController {
        //make it disconneced, to cnage it if needed (ex: if we want to start from another vc)
        let searchVC = SearchVC.init(navigator: self)
        return searchVC
    }
}
