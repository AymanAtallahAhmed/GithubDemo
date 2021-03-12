//
//  SearchViewModel.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
import RxSwift

class SearchViewModel {
    let userName = PublishSubject<String>()
    
    func isValid() -> Observable<Bool> {
        userName.asObservable().startWith("").map { (value) in
            return value.count > 4
        }
    }
}
