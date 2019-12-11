//
//  UIViewControllers+Alerts.swift
//  UberClone
//
//  Created by Alan Casas on 09/12/2019.
//  Copyright © 2019 Alan Casas. All rights reserved.
//

import UIKit

extension UIViewController {
    func displayAlert (alertTitle: String, alertMessage: String, actionTitle: String, okCompletionHandler: ((UIAlertAction) -> Void)? = nil, cancelTitle: String? = nil, cancelCompletionHandler: ((UIAlertAction) -> Void)? = nil, presentationCompletion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .default, handler: okCompletionHandler)
        
        alert.addAction(okAction)
        if cancelTitle != nil && cancelTitle != "" {
            let cancel = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelCompletionHandler)
            alert.addAction(cancel)
        }
        
        self.present(alert, animated: true, completion: presentationCompletion)
    }
}
