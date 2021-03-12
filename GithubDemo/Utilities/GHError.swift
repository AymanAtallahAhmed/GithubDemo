//
//  GHError.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/8/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import Foundation
import RxSwift

enum GHError: String, Error, Disposable {
    func dispose() {}
    
    case invalidUsername = "This username created invalid request, please try again"
    case unableToComplete = "Unable to complete your request, Please check your internet connection"
    case invalidData = "Invaled data recived from the server, Please try again."
    case invalidResponse = "Invalid response from the server, Plase try again."
    case invalidURL = "the used URL to fetch data is incorrect"
}
