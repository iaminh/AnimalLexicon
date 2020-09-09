//
//  UIViewController+Extensions.swift
//  PABK
//
//  Created by Minh on 6/15/16.
//  Copyright © 2016 ZENTITY a.s. All rights reserved.
//

import Foundation
import SVProgressHUD
import RESideMenu

extension UIViewController {
    func showRequestTimeOut() {
        self.showAlertMessage("Error", message: "Request timed out")
    }
    
    func showAlertMessage(_ title: String, message: String) {
        let alertCtrl = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction  = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertCtrl.addAction(okAction)
        self.present(alertCtrl, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {

        SVProgressHUD.show()

    }
    func showActivityIndicator(withStatus status: String){
        //TODO: Decide what to do with this
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show(withStatus: status)
    }
    func showSuccess(withStatus status: String){
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    func hideActivityIndicator() {
        delay (0.5) {
            SVProgressHUD.dismiss()
        }
    }
    
    func setNavigationBarAppearance() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.Lexikon.Orange
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isOpaque = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

        setMenu()
    }
    
    func setMenu() {
        let revealButton = UIBarButtonItem(image: #imageLiteral(resourceName: "menu-icon"), style: .plain, target: self, action: #selector(showMenu))
        self.navigationItem.leftBarButtonItem = revealButton
    }
    
    @objc func showMenu() {
        (UIApplication.shared.delegate as? AppDelegate)?.sideMenuVC?.presentLeftMenuViewController()
    }
}
