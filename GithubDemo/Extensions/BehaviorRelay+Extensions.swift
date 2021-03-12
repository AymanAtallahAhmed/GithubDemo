//
//  BehaviorRelay+Extensions.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/12/21.
//  Copyright © 2021 Ayman Ata. All rights reserved.
//

import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func append(element: Element.Element) {
        var array = self.value
        array.append(element)
        self.accept(array)
    }
    
    func append(sequence: [Element.Element]) {
        var array = self.value
        array.append(contentsOf: sequence)
        self.accept(array)
    }
}
