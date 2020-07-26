//
//  SignUpComposer.swift
//  main
//
//  Created by Matheus Lima Gomes on 15/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain
import UI
import Presentation
import Validation

public final class SignUpComposer {
    public static func composeControllerWith(_ addAccount: AddAccount) -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller), validation: <#Validation#>)
        controller.signUp = presenter.signUp
        return controller
    }
}
