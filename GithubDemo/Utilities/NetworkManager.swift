//
//  NetworkManager.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/8/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import RxAlamofire
import Alamofire

class NetworkManager {
    private let baseURL = "https://api.github.com"
        
    func getObjects<T: Codable>(ofType type: T.Type,
                                endpoint: String,
                                parameters: [String: String]? = nil,
                                token: String? = nil,
                                method: HTTPMethod = .get
                                ) -> Observable<T> {
        
        return Observable.create { [weak self] (observer) -> Disposable in
            let endPoint = self!.baseURL + endpoint
            
            guard let url = URL(string: endPoint) else {
                observer.onError(GHError.invalidURL)
                return Disposables.create()
            }
            var headers: HTTPHeaders?
            headers = token != nil ? [.authorization(bearerToken: token!)] : nil
            
            _ = data(method,
                     url,
                     parameters: parameters,
                     encoding: URLEncoding.default,
                     headers: headers)
            .subscribe(onNext: { (data) in
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    observer.onNext(result)
                } catch {
                    observer.onError(GHError.invalidData)
                }
            }, onError: { err in
                observer.onError(GHError.invalidResponse)
            })
            return Disposables.create()
        }
    }
    
}
