//
//  ViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 08.10.2021.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var vKLogoImage: UIImageView!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginViaFacebook: UIButton!
    @IBOutlet weak var facebookLogoImage: UIImageView!



    func addShadow (view: UIView) {
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.white.cgColor]
        gradientLayer.locations = [0.5, 1]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.view.bounds
        gradientLayer.zPosition = 0
        self.view.layer.addSublayer(gradientLayer)

        loginTextField.layer.zPosition = 1
        passwordTextField.layer.zPosition = 1
        loginButton.layer.zPosition = 1
        vKLogoImage.layer.zPosition = 1
        forgetPasswordButton.layer.zPosition = 1
        loginViaFacebook.layer.zPosition = 1
        facebookLogoImage.layer.zPosition = 1


        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)

        addShadow(view: loginTextField)
        addShadow(view: passwordTextField)
        addShadow(view: loginButton)

        loginButton.layer.cornerRadius = 10


    }

    @objc func tapFunction() {
        self.view.endEditing(true)
    }


    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text,
              let password = passwordTextField.text
        else {return}

        if login == "1",
           password == "1" {
            print("login success")
            loginTextField.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            passwordTextField.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            performSegue(withIdentifier: "toGreenSegue", sender: nil)
        }
        else {
            loginTextField.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            passwordTextField.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

            return
        }


    }


}


