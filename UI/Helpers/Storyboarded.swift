//
//  Storyboarded.swift
//  UI
//
//  Created by Matheus Lima Gomes on 28/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import UIKit

public protocol Storyboarded {
    static func instantiate() -> Self
}
extension Storyboarded where Self: UIViewController {
    public static func instantiate() -> Self {
        let viewControllerName = String(describing: self)
        let bundle = Bundle(for: Self.self)
        let storyboardName = viewControllerName.components(separatedBy: "ViewController")[0]
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(identifier: viewControllerName) as Self
        
    }
}
