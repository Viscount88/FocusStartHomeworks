//
//  AddingNewCarViewController.swift
//  Homework №1
//
//  Created by Андрей Шамин on 10/15/20.
//

import UIKit

class AddingNewCarViewController: UIViewController {

    private enum Constants {
        static let buttonCornerRadius:CGFloat = 10
        static let chooseCarBodySegueID = "ChooseCarBody"
    }

    var saveCarDelegate:SaveCarDelegate?
    @IBOutlet var manufacturerTextField: UITextField!
    @IBOutlet var modelTextField: UITextField!
    @IBOutlet var yearOfIssueTextField: UITextField!
    @IBOutlet var carNumberTextField: UITextField!
    @IBOutlet var carBodyButton: UIButton!

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupKeyboardNotifications()
        self.setupTextFields()
        self.setupButtons()
        self.setupTapToCloseTextField()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.chooseCarBodySegueID {
            (segue.destination as! CarBodysTableViewController).chosenCarBodyDelegate = self
        }
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.carNumberTextField.isFirstResponder {
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

    @IBAction func saveAction(_ sender: Any) {
        self.saveCar()
    }
}

// MARK: - UITextFieldDelegate
extension AddingNewCarViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        textField.resignFirstResponder()
        if textField == manufacturerTextField {
            self.modelTextField.becomeFirstResponder()
        } else if textField == modelTextField {
            self.chooseCarBody()
        } else if textField == yearOfIssueTextField {
            self.carNumberTextField.becomeFirstResponder()
        } else if textField == carNumberTextField {
            self.saveCar()
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        if textField == self.yearOfIssueTextField {
            return Formatter.allowCharaters("0123456789", inString: string)
        }
        return true
    }
}

// MARK: - ChosenCarBodyDelegate
extension AddingNewCarViewController: ChosenCarBodyDelegate {
    func chosenBody(body: String) {
        self.carBodyButton.setTitle(body, for: .normal)
        self.yearOfIssueTextField.becomeFirstResponder()
    }
}


private extension AddingNewCarViewController {
    func setupTextFields() {
        self.manufacturerTextField.delegate = self
        self.modelTextField.delegate = self
        self.yearOfIssueTextField.delegate = self
        self.carNumberTextField.delegate = self
    }

    func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func setupButtons() {
        self.carBodyButton.layer.cornerRadius = Constants.buttonCornerRadius
    }

    func setupTapToCloseTextField() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    func chooseCarBody() {
        performSegue(withIdentifier: Constants.chooseCarBodySegueID, sender: self)
    }

    func textFieldIsnotFilled(withMessage message:String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ок", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

    func saveCar() {
        guard let manufacturer = self.manufacturerTextField.text, !manufacturer.isEmpty else {
            self.textFieldIsnotFilled(withMessage: "Вы не заполнили поле производитель")
            return
        }
        guard let model = self.modelTextField.text, model != "" else {
            self.textFieldIsnotFilled(withMessage: "Вы не заполнили поле модель")
            return
        }
        guard let bodyText = self.carBodyButton.title(for: .normal),
              bodyText != "Выбрать",
              let body = Body(rawValue: bodyText) else {
            self.textFieldIsnotFilled(withMessage: "Вы не выбрали тип кузова")
            return
        }

        var yearOfIssue:Int?
        if let yearOfIssueText = self.yearOfIssueTextField.text {
            yearOfIssue = Int(yearOfIssueText)
        }

        let carNumber = self.carNumberTextField.text == "" ? nil : self.carNumberTextField.text
        saveCarDelegate?.saveCar(Car(manufacturer: manufacturer,
                                     model: model,
                                     body: body,
                                     yearOfIssue: yearOfIssue,
                                     carNumber: carNumber))
        navigationController?.popViewController(animated: true)
    }
}
