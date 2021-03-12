//
//  SearchVC.swift
//  GithubDemo
//
//  Created by Ayman Ata on 3/6/21.
//  Copyright © 2020 Ayman Ata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gh-logo")
        imageView.tintColor = .systemPink
        return imageView
    }()
    
    let userTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.textColor = .label
        textField.tintColor = .label
        textField.textAlignment = .center
        textField.font = UIFont.preferredFont(forTextStyle: .title2)
        return textField
    }()
    
    let getFollowerBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius  = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.backgroundColor = .systemPink
        button.setTitle("Git Followers", for: .normal)
        button.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        return button
    }()
    
    
    private let viewModel = SearchViewModel()
    private let navigator: Navigator
    private let disposeBage = DisposeBag()
    private var followers = [Follower]()
    
    init(navigator: Navigator) {
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        dismissKeyboardGesture()
        userTextField.delegate = self
        setupUI()
        
        userTextField.rx.text.map({ $0 ?? ""}).bind(to: viewModel.userName).disposed(by: disposeBage)
        viewModel.isValid().bind(to: getFollowerBtn.rx.isEnabled).disposed(by: disposeBage)
        viewModel.isValid().map ({ $0 ? 1 : 0.5}).bind(to: getFollowerBtn.rx.alpha).disposed(by: disposeBage)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func dismissKeyboardGesture() {
        let tabGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tabGesture)
    }
    
    
     @objc private func pushFollowersVC() {
        guard let userName = userTextField.text, !userName.isEmpty else { return }
        navigator.show(viewController: .followersList(userName), sender: self.navigationController!)
    }
    
    private func setupUI() {
        _ = [logoImageView, userTextField, getFollowerBtn].map { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
        
            userTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userTextField.heightAnchor.constraint(equalToConstant: 48),
            
            getFollowerBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            getFollowerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowerBtn.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

}


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        print("hola")
        return true
    }
}
