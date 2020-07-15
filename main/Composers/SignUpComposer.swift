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

public final class SignUpComposer {
    public static func composeControllerWith(_ addAccount: AddAccount) -> SignUpViewController {
        return ControllerFactory.makeSignUp(addAccount: addAccount)
    }
}
