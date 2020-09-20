//
//  Helper.swift
//  KnowFacts
//
//  Created by Spica Rawat on 20/09/20.
//  Copyright © 2020 spicarawat. All rights reserved.
//

import Foundation
import UIKit

class Helpers: NSObject {

    // MARK: - SINGLETON OBJECT
    static var instance: Helpers = {
        return Helpers()
    }()

    // MARK: - SHOW ALERT
    func showAlertWithTitle(messageBody: String, handler: @escaping (() -> Void)) {
        let alertPopUp = UIAlertController(title: "KnowFacts", message: messageBody, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { (_) in
        }
        alertPopUp.addAction(okAction)
        AppDelegate.delegate().window?.rootViewController?.present(alertPopUp, animated: true, completion: {
            handler()
        })
    }
}
