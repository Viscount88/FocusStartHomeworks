//
//  AddingNewCarViewController.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class AddingNewCarViewController: UIViewController {

    fileprivate enum Constants {
        static let buttonCornerRadius:CGFloat = 10
        static let chooseCarBodySegueID = "chooseCarBody"
    }

    var saveCarDelegate:SaveCarDelegate?
    @IBOutlet var manufacturerTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var yearOfIssueTextField: UITextField!
    @IBOutlet var carNumberTextField: UITextField!
    @IBOutlet var carBodyButton: UIButton!

    fileprivate func setupTextFields() {
        manufacturerTextField.delegate = self
        modelTextField.delegate = self
        yearOfIssueTextField.delegate = self
        carNumberTextField.delegate = self
    }

    fileprivate func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    fileprivate func setupButtons() {
        carBodyButton.layer.cornerRadius = Constants.buttonCornerRadius
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    fileprivate func setupTapToCloseTextField() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupKeyboardNotifications()
        setupTextFields()
        setupButtons()
        setupTapToCloseTextField()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.chooseCarBodySegueID {
            (segue.destination as! CarBodysTableViewController).chosenCarBodyDelegate = self
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if carNumberTextField.isFirstResponder {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height/3
                }
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    fileprivate func chooseCarBody() {
        performSegue(withIdentifier: Constants.chooseCarBodySegueID, sender: self)
    }

    fileprivate func textFieldIsnotFilled(withMessage message:String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

    fileprivate func saveCar() {
        guard let manufacturer = manufacturerTextField.text, manufacturer != "" else {
            textFieldIsnotFilled(withMessage: "Вы не заполнили поле производитель")
            return
        }
        guard let model = modelTextField.text, model != "" else {
            textFieldIsnotFilled(withMessage: "Вы не заполнили поле модель")
            return
        }
        guard let bodyText = carBodyButton.title(for: .normal),
              bodyText != "Выбрать",
              let body = Body(rawValue: bodyText) else {
            textFieldIsnotFilled(withMessage: "Вы не выбрали тип кузова")
            return
        }

        var yearOfIssue:Int?
        if let yearOfIssueText = yearOfIssueTextField.text {
            yearOfIssue = Int(yearOfIssueText)
        } else {
            yearOfIssue = nil
        }

        let carNumber = carNumberTextField.text == "" ? nil : carNumberTextField.text
        saveCarDelegate?.saveCar(Car(manufacturer: manufacturer,
                                     model: model,
                                     body: body,
                                     yearOfIssue: yearOfIssue,
                                     carNumber: carNumber))
        navigationController?.popViewController(animated: true)
    }

    @IBAction func saveAction(_ sender: Any) {
        saveCar()
    }
}

// MARK: - UITextFieldDelegate
extension AddingNewCarViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        if textField == manufacturerTextField {
            modelTextField.becomeFirstResponder()
        } else if textField == modelTextField {
            chooseCarBody()
        } else if textField == yearOfIssueTextField {
            carNumberTextField.becomeFirstResponder()
        } else if textField == carNumberTextField {
            saveCar()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == yearOfIssueTextField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

// MARK: - ChosenCarBodyDelegate
extension AddingNewCarViewController: ChosenCarBodyDelegate {
    func chosenBody(body: String) {
        carBodyButton.setTitle(body, for: .normal)
        yearOfIssueTextField.becomeFirstResponder()
    }
}
