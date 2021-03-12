//
//  Follower.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import Foundation
import RxDataSources


struct Follower: Codable, Hashable, Equatable, IdentifiableType {
    
    var identity: String {
        return avatar_url
    }
        
    var login: String
    var avatar_url: String
}
