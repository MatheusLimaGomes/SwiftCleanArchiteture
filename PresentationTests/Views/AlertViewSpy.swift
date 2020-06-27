//
//  AlertViewSpy.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Presentation

public class AlertViewSpy: AlertView {
    var emit: ((AlertViewModel) -> Void)?
    
    func observe(completion: @escaping (AlertViewModel) -> Void ) {
        self.emit = completion
    }
    
    public func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
