//
//  SupportingPageView.swift
//  time_converter_api
//
//  Created by Leo Nugraha on 2021/8/19.
//

import Foundation
import UIKit

// MARK: Return back to the login menu when pressed
class LogoutPageView: UIViewController {

    private lazy var logoutMessage: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: BOX_WIDTH, height: 400))
        let LOGO_SIZE = 80

        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: LOGO_SIZE, height: LOGO_SIZE))
        logo.image = UIImage(systemName: "exclamationmark.triangle")
        logo.tintColor = priColor
        logo.translatesAutoresizingMaskIntoConstraints = false

        let label = UILabel(frame: CGRect(x: 0, y: 0, width: BOX_WIDTH, height: 30))
        label.text = "您確定想登出？"
        label.textColor = priColor
        label.font = UIFont.systemFont(ofSize: 28)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(label)
        view.addSubview(logo)

        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: CGFloat(LOGO_SIZE)),
            logo.heightAnchor.constraint(equalToConstant: CGFloat(LOGO_SIZE))
        ])

        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: CGFloat(Int(FULL_WIDTH)-32)),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])

        return view
    }()
    
    // MARK: Confirm logout and proceed to login page
    private lazy var logoutButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 200, y: 250, width: 100, height: 36))
        button.backgroundColor = priColor
        button.layer.cornerRadius = 8
        button.setTitle("確定", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func logoutButtonTapped(){
        let viewController = ViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false, completion: nil)
    }

    // MARK: Cancel logout and return to main page
    private lazy var cancelButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 250, width: 100, height: 36))
        button.backgroundColor = blColor
        button.layer.cornerRadius = 8
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func cancelButtonTapped(){
        let mainPageView = MainPageView()
        mainPageView.modalPresentationStyle = .fullScreen
        present(mainPageView, animated: false, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = gyColor
        self.view.addSubview(logoutMessage)
        self.view.addSubview(logoutButton)
        self.view.addSubview(cancelButton)

        logoutMessage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutMessage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutMessage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoutMessage.widthAnchor.constraint(equalToConstant: CGFloat(BOX_WIDTH)),
            logoutMessage.heightAnchor.constraint(equalToConstant: 400)
        ])

        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: logoutMessage.topAnchor, constant: 160),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            cancelButton.widthAnchor.constraint(equalToConstant: CGFloat(BUTTON_WIDTH)),
            cancelButton.heightAnchor.constraint(equalToConstant: CGFloat(BUTTON_HEIGHT))
        ])

        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.topAnchor.constraint(equalTo: logoutMessage.topAnchor, constant: 160),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            logoutButton.widthAnchor.constraint(equalToConstant: CGFloat(BUTTON_WIDTH)),
            logoutButton.heightAnchor.constraint(equalToConstant: CGFloat(BUTTON_HEIGHT))
        ])

    }
}

// MARK: Update the Time Zone by sending an API Request using this class
class TimeZoneChangeView: UIViewController {

    private lazy var topBannerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(FULL_WIDTH), height: 100))
        view.backgroundColor = priColor

        let label = UILabel(frame: CGRect(x: 0, y: 50, width: Int(FULL_WIDTH), height: 80))
        label.text = "請輸入數字(-12至+12)："
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = priColor
        label.font = UIFont.systemFont(ofSize: 28)

        view.addSubview(label)
        return view
    }()

    private lazy var currentLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: Int(FULL_WIDTH)/2, y: 150, width: LOGOSIZE, height: 30))
        label.backgroundColor = priColor
        label.text = "目前的時區"
        label.textColor = UIColor.white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()

    private lazy var timezoneLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: Int(FULL_WIDTH)/2, y: 180, width: LOGOSIZE, height: LOGOSIZE))
        label.text = String(GlobalDataAccess.shared.timezone)
        label.backgroundColor = UIColor.white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        label.textColor = bkColor
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 48)
        return label
    }()
    
    private lazy var timezoneStepper: UIStepper = {
        let stepper = UIStepper(frame: CGRect(x: Int(FULL_WIDTH)/2, y: 250, width: BOX_WIDTH, height: BOX_HEIGHT))
        stepper.wraps = false
        stepper.autorepeat = false
        stepper.minimumValue = -12
        stepper.maximumValue = 12
        stepper.value = Double(GlobalDataAccess.shared.timezone)
        stepper.stepValue = 1
        stepper.addTarget(self, action: #selector(stepperValueTapped(_:)), for: .valueChanged)
        return stepper
    }()
    
    @objc func stepperValueTapped(_ sender: UIStepper!){
        timezoneLabel.text = String( Int(sender.value) )
    }

    private lazy var submitButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 10, y: 250, width: 100, height: 36))
        button.backgroundColor = priColor
        button.layer.cornerRadius = 8
        button.setTitle("確定", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc func submitButtonTapped(){
        // Obtain the number value from UIStepper's target label or UITextField (Limit UIStepper from -12 to +12)
        let newTimeZone: Int = Int(timezoneStepper.value)
        print("Timezone Stepper Value: \(newTimeZone)")
        
        // Second API Function for update comes here
        let statusCodeUpdate = APIHandler.putHttpsResponse(sessionToken: GlobalDataAccess.shared.sessionToken, objectId: GlobalDataAccess.shared.objectId, timezone: newTimeZone)
        print("DEBUG: \(statusCodeUpdate)")
        
        if statusCodeUpdate == 200 {
            let successMessage = SuccessAlertMessage()
            successMessage.modalPresentationStyle = .fullScreen
            present(successMessage, animated: false, completion: nil)
            GlobalDataAccess.shared.timezone = newTimeZone
        } else {
            let warningMessage = WarningAlertMessage()
            warningMessage.modalPresentationStyle = .fullScreen
            present(warningMessage, animated: false, completion: nil)
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = gyColor
        self.view.addSubview(topBannerView)
        self.view.addSubview(currentLabel)
        self.view.addSubview(timezoneLabel)
        self.view.addSubview(timezoneStepper)
        self.view.addSubview(submitButton)

        currentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentLabel.topAnchor.constraint(equalTo: topBannerView.bottomAnchor, constant: 80),
            currentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            currentLabel.widthAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE)),
            currentLabel.heightAnchor.constraint(equalToConstant: 30)
        ])

        timezoneLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timezoneLabel.topAnchor.constraint(equalTo: currentLabel.bottomAnchor, constant: 0),
            timezoneLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timezoneLabel.widthAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE)),
            timezoneLabel.heightAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE))
        ])

        timezoneStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timezoneStepper.topAnchor.constraint(equalTo: timezoneLabel.bottomAnchor, constant: 16),
            timezoneStepper.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timezoneStepper.widthAnchor.constraint(equalToConstant: CGFloat(LOGOSIZE)),
        ])

        submitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: CGFloat(BUTTON_HEIGHT)),
            submitButton.widthAnchor.constraint(equalToConstant: CGFloat(BUTTON_WIDTH))
        ])

    }

}
