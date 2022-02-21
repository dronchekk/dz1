//
//  ViewController.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 08.10.2021.
//

import Foundation
import UIKit
import WebKit
import Alamofire
import SwiftUI

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var vKLogoImage: UIImageView!
    @IBOutlet weak var forgetPasswordButton: UIButton!
    @IBOutlet weak var loginViaFacebook: UIButton!
    @IBOutlet weak var facebookLogoImage: UIImageView!

    func addShadow (view: UIView) {
        view.layer.shadowColor = UIColor.brandBlackC
        view.layer.shadowOffset = CGSize(width: 10, height: 10)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "8006490"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "401502"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]

        let request = URLRequest(url: urlComponents.url!)
        webView.load(request)

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.brandBlueC, UIColor.brandWhiteC]
        gradientLayer.locations = [0.5, 1]
        gradientLayer.startPoint = CGPoint.zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.view.bounds
        gradientLayer.zPosition = 0
        self.view.layer.addSublayer(gradientLayer)

        webView.layer.zPosition = 1
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

        if login != "",
           password != "" {
            print("login success")
            loginUser = login
            loginTextField.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            passwordTextField.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            let session = Session.instance
            session.userlogin = loginTextField.text ?? ""
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.performSegue(withIdentifier: "toGreenSegue", sender: nil)
            }
        }
        else {
            loginTextField.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            passwordTextField.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)

            return
        }
    }
}


extension ViewController {

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let session = Session.instance
        let token = params["access_token"] as? String

        print(token)
        session.token = token ?? "Error"
        decisionHandler(.cancel)
        //        Alamofire.request ("http://api.vk.com/method/friends.get?fields=first_name,photo_50&access_token=\(session.token)&v=5.131").responseJSON { data in print(data.value)}
        //        Alamofire.request ("http://api.vk.com/method/photos.getAll?access_token=\(session.token)&v=5.131").responseJSON { data in print(data.value)}
        //        Alamofire.request ("http://api.vk.com/method/groups.get?extended=1&access_token=\(session.token)&v=5.131").responseJSON { data in print(data.value)}
        //        Alamofire.request ("http://api.vk.com/method/groups.search?access_token=\(session.token)&q=qwerty&v=5.131").responseJSON { data in print(data.value)}

    }
}
