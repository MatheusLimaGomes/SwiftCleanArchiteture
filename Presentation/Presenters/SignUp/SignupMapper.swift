//
//  SignUpMapper.swift
//  Presentation
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import Foundation
import Domain

public final class SignUpMapper {
    static func toAddAccountModel(_ viewModel: SignUpViewModel) -> AddAccountModel {
        return  AddAccountModel(name: viewModel.name!,                                                         email: viewModel.email!, password: viewModel.password!, passwordConfirmation: viewModel.passwordConfirmation!)
    }
}
