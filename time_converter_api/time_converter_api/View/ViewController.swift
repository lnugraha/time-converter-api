//
//  ViewController.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    private lazy var globeLogo: UIImageView = {
        let view = UIImageView(frame: CGRect(x: Int(FULL_WIDTH/2) - LOGOSIZE/2, y: 80, width: LOGOSIZE, height: LOGOSIZE))
        view.image = UIImage(systemName: "globe")
        view.contentMode = .scaleAspectFit
        view.tintColor = priColor
        return view
    }()

    private lazy var usernameView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 200, width: BOX_WIDTH, height: BOX_HEIGHT))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true

        let image = UIImageView(frame: CGRect(x: 6, y: 6, width: 36, height: 36))
        image.image = UIImage(systemName: "person.fill")
        image.tintColor = priColor
        view.addSubview(image)
        return view
    }()

    private lazy var usernameTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 48, y: 6, width: BOX_WIDTH - 2*OFFSET, height: TEXTFIELD_HEIGHT))
        let placeholderStr = NSAttributedString(string:"帳號", attributes: [NSAttributedString.Key.foregroundColor: pri_5Color])
        field.attributedPlaceholder = placeholderStr
        field.backgroundColor = UIColor.white
        field.textColor = priColor
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.font = UIFont.systemFont(ofSize: 32)
        return field
    }()

    private lazy var passwordView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 260, width: BOX_WIDTH, height: BOX_HEIGHT))
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        let image = UIImageView(frame: CGRect(x: 6, y: 6, width: 36, height: 36))
        image.image = UIImage(systemName: "lock.fill")
        image.tintColor = priColor
        view.addSubview(image)
        return view
    }()

    private lazy var passwordTextField: UITextField = {
        let field = UITextField(frame: CGRect(x: 48, y: 6, width: BOX_WIDTH - 2*OFFSET, height: TEXTFIELD_HEIGHT))
        let placeholderStr = NSAttributedString(string:"密碼", attributes: [NSAttributedString.Key.foregroundColor: pri_5Color])
        field.attributedPlaceholder = placeholderStr
        field.backgroundColor = UIColor.white
        field.textColor = priColor
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.font = UIFont.systemFont(ofSize: 32)
        return field
    }()

    private lazy var warningMessage: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 320, width: BOX_WIDTH, height: 20))
        label.backgroundColor = gyColor
        label.textColor = redColor
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 360, width: BOX_WIDTH, height: BOX_HEIGHT))
        button.backgroundColor = priColor
        button.layer.cornerRadius = 8
        button.setTitle("登入", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitleColor(gyColor, for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func loginButtonTapped() {

        if (usernameTextField.text == "" || passwordTextField.text == "") {
            warningMessage.text = "帳號或密碼不能空間"
            passwordView.layer.borderWidth = 2
            passwordView.layer.borderColor = redColor.cgColor
            usernameView.layer.borderWidth = 2
            usernameView.layer.borderColor = redColor.cgColor

        } else {

            // Check if the returned response are correct
            APIHandler.postHttpsResponse(username: usernameTextField.text!, password: passwordTextField.text!){ resultParsed in
                typealias configureSet = ConfigureUserDefault.SetUserDefaultValue

                configureSet.setObjectId(objectId: resultParsed.objectId)
                configureSet.setSessionToken(sessionToken: resultParsed.sessionToken)
                configureSet.setUsername(username: resultParsed.username)
                configureSet.setTimezone(timezone: resultParsed.timezone)
                configureSet.setCode(code: resultParsed.code)
                configureSet.setPhone(phone: resultParsed.phone)
                configureSet.setReportEmail(reportEmail: resultParsed.reportEmail)
                configureSet.setIsVerifiedReportEmail(isVerifiedReportEmail: resultParsed.isVerifiedReportEmail)

            }

            typealias configureGet = ConfigureUserDefault.GetUserDefaultValue

            if (configureGet.getObjectId() != "NULL_ID" && configureGet.getSessionToken() != "NULL_ID" && configureGet.getUsername() == usernameTextField.text!) {
                // Save all login credentials inside the UserDefaults
                UserDefaults.standard.setLoggedIn(value: true)
                // Transition to the next view controller
                let mainPageView = MainPageView()
                mainPageView.modalPresentationStyle = .fullScreen
                present(mainPageView, animated: false, completion: nil)
            } else {
                // Display error message upon unsuccessful login
                warningMessage.text = "帳號或密碼無效，請重新輸入！"
                passwordView.layer.borderWidth = 2
                passwordView.layer.borderColor = redColor.cgColor
                usernameView.layer.borderWidth = 2
                usernameView.layer.borderColor = redColor.cgColor
            }

        }
    }

    @objc func displayLoginPageView() {
        self.view.backgroundColor = gyColor

        self.view.addSubview(globeLogo)
        globeLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            globeLogo.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            globeLogo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            globeLogo.widthAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE)),
            globeLogo.heightAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE))
        ])

        self.view.addSubview(usernameView)
        usernameView.addSubview(usernameTextField)
        self.view.addSubview(passwordView)
        passwordView.addSubview(passwordTextField)

        usernameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameView.topAnchor.constraint(equalTo: globeLogo.bottomAnchor, constant: 5),
            usernameView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            usernameView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: CGFloat(PADDING)),
            usernameView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -CGFloat(PADDING)),
            usernameView.heightAnchor.constraint(equalToConstant: CGFloat(BOX_HEIGHT))
        ])

        passwordView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: usernameView.bottomAnchor, constant: 10),
            passwordView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            passwordView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: CGFloat(PADDING)),
            passwordView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -CGFloat(PADDING)),
            passwordView.heightAnchor.constraint(equalToConstant: CGFloat(BOX_HEIGHT))
        ])

        self.view.addSubview(warningMessage)
        warningMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningMessage.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 2),
            warningMessage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            warningMessage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: CGFloat(PADDING)),
            warningMessage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -CGFloat(PADDING)),
            warningMessage.heightAnchor.constraint(equalToConstant: CGFloat(20))
        ])

        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: warningMessage.bottomAnchor, constant: 2),
            loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: CGFloat(PADDING)),
            loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -CGFloat(PADDING)),
            loginButton.heightAnchor.constraint(equalToConstant: CGFloat(BOX_HEIGHT))
        ])

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Dismiss keyboard when tapping any part of the screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)

        if UserDefaults.standard.isLoggedIn() {
            let mainPageView = MainPageView()
            mainPageView.modalPresentationStyle = .fullScreen
            present(mainPageView, animated: false, completion: nil)
        } else {
            perform(#selector(displayLoginPageView))
        }
    }

}

