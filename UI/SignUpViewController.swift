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
    
    public override func viewDidLoad() {
        super.viewDidLoad()

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
