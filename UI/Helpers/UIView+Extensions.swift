//
//  UIView+Extensions.swift
//  UI
//
//  Created by Matheus Lima Gomes on 28/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import UIKit


public extension UIButton {
    func makeRounded(cornerRadius: CGFloat) {
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
}
