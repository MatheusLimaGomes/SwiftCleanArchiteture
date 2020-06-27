//
//  Tests+Extensions.swift
//  UITests
//
//  Created by Matheus Lima Gomes on 27/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {
    private func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach{ action in
                (target as NSObject).perform(Selector(action))
            }
        }
    }
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
