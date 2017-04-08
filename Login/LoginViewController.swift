//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        // Overall
        static let textColor = UIColor.white
        static let secTextColor = UIColor.lightGray
        static let cornerRadius: CGFloat = 10

        // For the UIView
        static let viewColor = UIColor.white

        // For the login button
        static let buttonHeight: CGFloat = 100
        static let buttonMargin: CGFloat = 128
        static let buttonTextSize: CGFloat = 24
    }

    // TODO: instantiate the views needed for your project
    var topLabel: UILabel = {
        let myLabel = UILabel()
        myLabel.text = "Login View Controller"
        myLabel.textColor = Constants.textColor
        myLabel.font = UIFont(name: "Avenir", size: 36)
        return myLabel
    }()
    
    var loginView: UIView = {
        let myView = UIView()
        myView.backgroundColor = Constants.viewColor
        myView.layer.cornerRadius = Constants.cornerRadius
        myView.layer.masksToBounds = true
        return myView
    }()
    
    var userField: UITextField = {
        let myField = UITextField()
        myField.placeholder = "berkeley.edu account"
        myField.textColor = Constants.secTextColor
        myField.autocorrectionType = UITextAutocorrectionType.no
        myField.autocapitalizationType = UITextAutocapitalizationType.none
        myField.spellCheckingType = UITextSpellCheckingType.no
        return myField
    }()
    
    var passField: UITextField = {
        let myField = UITextField()
        myField.placeholder = "Password"
        myField.textColor = Constants.secTextColor
        myField.isSecureTextEntry = true
        myField.autocorrectionType = UITextAutocorrectionType.no
        myField.autocapitalizationType = UITextAutocapitalizationType.none
        myField.spellCheckingType = UITextSpellCheckingType.no
        return myField
    }()
    
    var loginButton: UIButton = {
        let myButton = UIButton()
        myButton.setTitle("Login", for: .normal)
        myButton.titleLabel?.font = UIFont(name: "Avenir", size: Constants.buttonTextSize)
        myButton.titleLabel?.numberOfLines = 2
        myButton.titleLabel?.textAlignment = .center
        myButton.setTitleColor(Constants.textColor, for: .normal)
        
        // configure button itself
        myButton.backgroundColor = Constants.backgroundColor
        // makes the corners of the cell rounded, instead of squared off
        myButton.layer.cornerRadius = Constants.cornerRadius
        myButton.layer.masksToBounds = true
        
        myButton.addTarget(self, action: #selector(authenticateLogin), for: .touchDown)
        return myButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        view.addSubview(topLabel)
        view.addSubview(loginView)
        loginView.addSubview(userField)
        loginView.addSubview(passField)
        loginView.addSubview(loginButton)
        
        // TODO: layout your views using frames or AutoLayout
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        loginView.translatesAutoresizingMaskIntoConstraints = false
        userField.translatesAutoresizingMaskIntoConstraints = false
        passField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: layout your views using frames or AutoLayout
        let myConstraints = [
            // Label
            topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topLabel.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            topLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            topLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            // Login Wrapper
            loginView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 4),
            // Button
            loginButton.bottomAnchor.constraint(equalTo: loginView.bottomAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 60),
            // Username Field
            userField.topAnchor.constraint(equalTo: loginView.topAnchor, constant: 20),
            userField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            userField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 20),
            userField.heightAnchor.constraint(equalToConstant: 30),
            // Password Field
            passField.topAnchor.constraint(equalTo: userField.bottomAnchor, constant: 10),
            passField.centerXAnchor.constraint(equalTo: loginView.centerXAnchor),
            passField.leadingAnchor.constraint(equalTo: loginView.leadingAnchor, constant: 20),
            passField.heightAnchor.constraint(equalToConstant: 30)
            
        ]
        
        NSLayoutConstraint.activate(myConstraints)
    }
    
    // TODO: create an IBAction for your login button, is done above?
    @IBAction func authenticateLogin(sender: Any?) {
        authenticateUser(username: userField.text, password: passField.text)
    }
    
    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
