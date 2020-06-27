//
//  LoadingViewSpy.swift
//  PresentationTests
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Presentation

class  LoadingViewSpy: LoadingView {
    var emit: ((LoadingViewModel) -> Void)?
    func observe(completion: @escaping (LoadingViewModel) -> Void ) {
        self.emit = completion
    }
    func display(viewModel: LoadingViewModel) {
        self.emit?(viewModel)
    }
}
