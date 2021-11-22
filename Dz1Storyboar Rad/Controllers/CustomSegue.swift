//
//  CustomSegue.swift
//  Dz1Storyboar Rad
//
//  Created by Andrey rachitsky on 10.11.2021.
//

import UIKit

class CustomSegue: UIStoryboardSegue {

    override func perform() {
        guard let containerView = source.view.superview,
              let destinationView = destination.view,
              let sourceController = source as? ViewController else { return }


        let containerViewFrame = containerView.frame
        let destinationFrame = source.view.frame

        containerView.addSubview(destination.view)


        destinationView.frame = CGRect(x: source.view.frame.width / 2, y: source.view.frame.height / 2, width: 0, height: 0)


//        sourceController.loginViaFacebook.isHidden = true
//        sourceController.facebookLogoImage.isHidden = true
//        sourceController.vKLogoImage.isHidden = true
//        sourceController.forgetPasswordButton.isHidden = true
//        destinationView.clearsContextBeforeDrawing = true

        UIView.animate(withDuration: 0.01) {[weak self] in
            self?.source.view.frame = destinationView.frame
        } completion: { isSuccessfully in
            if isSuccessfully {
                UIView.animate(withDuration: 0.01) {
                    destinationView.frame = destinationFrame
                } completion: { [weak self] isSuccess in
                    if isSuccess,
                    let self = self {
                        self.source.present(self.destination, animated: false, completion: nil)
                    }
                }

            }
        }
    }

}
