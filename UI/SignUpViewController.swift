//
//  SignUpViewController.swift
//  UI
//
//  Created by Matheus Lima Gomes on 26/06/20.
//  Copyright © 2020 Matheus Lima Gomes. All rights reserved.
//

import UIKit
import Presentation

public final class SignUpViewController: UIViewController {

    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView?
    @IBOutlet weak var saveButton: UIButton?
    var signUp: ((SignUpViewModel) -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup() {
        saveButton?.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside )
    }
    
    
    @objc
    private func saveButtonTapped() {
        signUp?(SignUpViewModel(name: nil, email: nil, password: nil, passwordConfirmation: nil ))
    }

}
extension SignUpViewController: LoadingView {
    public func display(viewModel: LoadingViewModel) {
        if viewModel.isActive {
            self.loadingIndicator?.startAnimating()
        } else {
            self.loadingIndicator?.stopAnimating()
        }
    }
}
extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        
    }
}
