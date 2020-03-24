//
//  NibLoadable.swift
//  iOS Starter Project
//
//  Created by Botond Magyarosi on 29/07/2019.
//  Copyright © 2019 Halcyon Mobile. All rights reserved.
//

import UIKit

protocol NibLoadable {
    static func makeFromNib() -> Self
}

extension NibLoadable where Self: UIView {

    static func makeFromNib() -> Self {
        // swiftlint:disable force_cast
        return Bundle.main.loadNibNamed("\(Self.self)", owner: nil, options: nil)![0] as! Self
    }
}
