//
//  SignupFactory.swift
//  main
//
//  Created by Matheus Lima Gomes on 13/07/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import UIKit
import UI
import Validation
import Presentation
import Infrastructure
import Data
import Domain

final public class SignupFactory {
    static public  func makeController() -> SignUpViewController {
        let controller = SignUpViewController.instantiate()
        let emailValidatorAdapter = EmailValidatorAdapter()
        let alamofireAdapter = AlamofireAdapter()
        let url = URL(string: "https://clean-node-api.herokuapp.com/api/signup")!
        let remoteAddAccount = RemoteAddAccount(url: url, httpClient: alamofireAdapter)
        let presenter = SignUpPresenter(alertView: controller, emailValidator: emailValidatorAdapter, addAccount: remoteAddAccount, loadingView: controller)
        controller.signUp = presenter.signUp
        return controller
    }
}
