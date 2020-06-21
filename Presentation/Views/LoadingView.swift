//
//  LoadingView.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 20/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

public struct LoadingViewModel: Equatable {
    public var isActive: Bool
    
    public init(isActive: Bool) {
        self.isActive = isActive
    }
}
