//
//  SignUpViewController.swift
//  UI
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import UIKit
import Presentation

public final class SignUpViewController: UIViewController, Storyboarded {

    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var emailTextField: UITextField?
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var passwordConfirmationTextField: UITextField?
    @IBOutlet weak var saveButton: UIButton?
    
    var signUp: ((SignUpViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        saveButton?.makeRounded(cornerRadius: 10)
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside )
        hideKeyboardOnTap()
    }
    @objc
    private func saveButtonTapped() {
        let viewModel = SignUpViewModel(name: nameTextField?.text,
        email: emailTextField?.text,
        password: passwordTextField?.text,
        passwordConfirmation: passwordConfirmationTextField?.text)
        signUp?(viewModel )
    }

}
extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isActive {
            self.view.isUserInteractionEnabled = false
            self.loadingIndicator?.startAnimating()
        } else {
            self.view.isUserInteractionEnabled = true
            self.loadingIndicator?.stopAnimating()
        }
    }
}
extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
}
