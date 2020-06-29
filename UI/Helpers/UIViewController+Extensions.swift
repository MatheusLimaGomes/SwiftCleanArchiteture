//
//  UIViewController+Extensions.swift
//  UI
//
//  Created by Matheus Lima Gomes on 28/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    private func hideKeyboard() {
        view.endEditing(true)
    }
}
