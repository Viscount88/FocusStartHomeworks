//
//  ThirdView.swift
//  Homework_№3
//
//  Created by Андрей Шамин on 10/30/20.
//

import UIKit

final class ThirdView: UIView {

    // MARK: - Constants

    private enum Constants {
        static let doneButtonCornerRadius: CGFloat = 15
        static let anchorConstant:CGFloat = 16
    }

    // MARK: - Views

    let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.textContentType = .password
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        return textField
    }()

    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = Constants.doneButtonCornerRadius
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Properties

    private var isKeyboardShowing = false
    private var doneButtonBottomAnchor:NSLayoutConstraint!
    private var doneButtonBottomAnchorWithKeyboard:NSLayoutConstraint!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemBackground
        setupElements()
        setupNotifications()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Установка constraint-ов для элементов

private extension ThirdView {
    func setupElements() {
        setupDoneButtonAnchor()
        setupLoginTextField()
        setupPasswordTextField()
        setupDoneButton()
        hideKeyboardWhenTappedAround()
        setupTextFieldsDelegate()
    }

    func setupTextFieldsDelegate() {
        passwordTextField.delegate = self
        loginTextField.delegate = self
    }

    func setupDoneButtonAnchor() {
        doneButtonBottomAnchor = doneButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0)
    }

    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupLoginTextField() {
        self.addSubview(loginTextField)
        NSLayoutConstraint.activate([
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.anchorConstant),
            loginTextField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: Constants.anchorConstant),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
        ])
    }

    func setupPasswordTextField() {
        self.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.anchorConstant),
            passwordTextField.topAnchor.constraint(equalTo: self.loginTextField.bottomAnchor, constant: Constants.anchorConstant),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
        ])
    }

    func setupDoneButton() {
        self.addSubview(doneButton)
        NSLayoutConstraint.activate([
            doneButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.anchorConstant),
            doneButtonBottomAnchor,
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.anchorConstant),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardShowing {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                let anchorConstant = keyboardHeight - self.safeAreaInsets.bottom
                doneButtonBottomAnchorWithKeyboard = doneButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -anchorConstant)

                NSLayoutConstraint.deactivate([self.doneButtonBottomAnchor])
                NSLayoutConstraint.activate([self.doneButtonBottomAnchorWithKeyboard])

                UIView.animate(withDuration: 0.25) {
                    self.layoutIfNeeded()
                }
                isKeyboardShowing = true
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if isKeyboardShowing {
            NSLayoutConstraint.deactivate([self.doneButtonBottomAnchorWithKeyboard])
            NSLayoutConstraint.activate([self.doneButtonBottomAnchor])
            UIView.animate(withDuration: 0.25) {
                self.layoutIfNeeded()
            }
            isKeyboardShowing = false
        }
    }

    // Убираем клавиатуру, когда нажимаем куда-либо
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate: действия для return от UITextField-ов

extension ThirdView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginTextField {
            textFieldShouldReturnForLoginTF()
        } else if textField == passwordTextField {
            textFieldShouldReturnForPasswordTF()
        }
        return true
    }

    fileprivate func textFieldShouldReturnForLoginTF() {
        passwordTextField.becomeFirstResponder()
        loginTextField.resignFirstResponder()
    }

    fileprivate func textFieldShouldReturnForPasswordTF() {
        passwordTextField.resignFirstResponder()
        if let login = loginTextField.text, let password = passwordTextField.text  {
            checkingLoginAndPasswordTextField(login, password)
        }
    }

    fileprivate func checkingLoginAndPasswordTextField(_ login: String, _ password: String) {
        if !login.isEmpty , !password.isEmpty {
            print("Дальнейшее выполнение с логином \(login) и паролем \(password)")
        } else if login.isEmpty {
            print("Надо ввести логин")
        } else if password.isEmpty {
            print("Надо ввести пароль")
        }
    }
}
