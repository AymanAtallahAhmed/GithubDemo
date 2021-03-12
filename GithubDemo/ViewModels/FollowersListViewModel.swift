//
//  FollowersListViewModel.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FollowersListViewModel {
    private let disposeBage = DisposeBag()
    let userName: String
    private let netManager = NetworkManager()
    private var followers: BehaviorRelay<[Follower]> = .init(value: [])
    var currentFollowers: BehaviorRelay<[Follower]> = .init(value: [])
    
    init(userName: String) {
        self.userName = userName
    }
    
    func viewDidLoad() {
        fetchFollowers()
    }
    
    func fetchFollowers(page: Int = 1) {
        let endPoint = "/users/\(userName)/followers?per_page=80&page=\(page)"
        netManager.getObjects(ofType: [Follower].self, endpoint: endPoint).subscribe(onNext: { [weak self] (followers) in
            print(followers)
            guard let self = self else { return }
            self.followers.append(sequence: followers)
            self.currentFollowers.append(sequence: followers)
        }, onError: { (err) in
            print(err)
            }).disposed(by: disposeBage)
    }
    
    
    func search(with text: String) {
        self.currentFollowers.accept(
            self.followers.value
                .filter({ $0.login.lowercased().contains(text.lowercased()) }
        ))
    }
    
    func searchCanceled() {
        currentFollowers.accept(followers.value)
    }
}
