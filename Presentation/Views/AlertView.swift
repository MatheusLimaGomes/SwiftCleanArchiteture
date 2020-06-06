//
//  AlertView.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 06/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public protocol AlertView {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Equatable {
    var title: String
    var message: String
   public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}

