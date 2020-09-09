//  Created by Minh Chu on 05.03.15.
//  Copyright © 2016 Minh Chu. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension UIApplication {
    
    func applicationVersion() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }
    
    
    func applicationBuild() -> String {
        
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
    
    
    func versionBuild() -> String {
        
        let version = self.applicationVersion()
        let build = self.applicationBuild()
        
        return "v\(version) (\(build))"
    }
    
    
    func openURLInSafariControllerFromVC(_ viewController : UIViewController, url : URL) {
       
        if #available(iOS 9.0, *) {
            let safariController = SFSafariViewController(url: url)
            viewController.present(safariController, animated: true, completion: nil)
        } else {
            self.openURL(url)
        }
    }
}




// --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
// MARK: - Device detection

// Thanks to http://stackoverflow.com/questions/24059327/detect-current-device-with-ui-user-interface-idiom-in-swift

enum UIUserInterfaceIdiom : Int {
    
    case unspecified
    case phone
    case pad
}


struct ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}


struct DeviceType {
    
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P         = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
}




