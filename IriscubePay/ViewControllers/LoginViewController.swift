//
//  LoginViewController.swift
//  IriscubePay
//
//  Created by Lorenzo Barranco on 01/09/2020.
//  Copyright © 2020 Lorenzo Barranco. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewControllerDelegate: class {
    func loginViewController(_ loginViewController: LoginViewController, didEnterAgentCode code: String)
}

final class LoginViewController: UIViewController {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(named: "bankAgent")
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.text = "Inserisci il tuo codice agente"
        return descriptionLabel
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Codice agente"
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        textField.textAlignment = .center
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ENTRA", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    weak var coordinatorDelegate: LoginViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        setUpLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        print("test")
    }
    
    private func setUpLayout() {
        view.backgroundColor = UIColor.white
        view.addSubview(button)
        view.addSubview(textField)
        view.addSubview(descriptionLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            
            descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            button.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    private func setUp() {
        button.addTarget(self, action: #selector(loginButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped(_ sender: UIButton) {
        guard let agentCode = textField.text, !agentCode.isEmpty else { return }
        
        coordinatorDelegate?.loginViewController(self, didEnterAgentCode: agentCode)
    }
}
