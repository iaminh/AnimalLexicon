//
//  SwiftTweaks.swift
//  ContactRecords
//
//  Created by Minh Chu on 01.03.16.
//  Copyright © 2016 Minh Chu. All rights reserved.
//

import Foundation
import UIKit

public let kNavigationBarHeight : CGFloat = 64
public func backgroundQueue(closure:  @escaping ()->())
{
    // Move to a background thread to do some long running work
    DispatchQueue.global(qos: .userInitiated).async {
        closure()
    }
//    dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0).asynchronously(execute: closure)
}


public func mainQueue(closure:  @escaping ()->())
{
    DispatchQueue.main.async {
        closure()
    }
}

extension UIColor {

    static func random() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    static func computeColorFromInt(int: Int, alpha: CGFloat, brightNess: Int = 150) -> UIColor {
        let generatedRed  = (int * 12345) % brightNess
        let generatedBlue  = (int * 45678) % brightNess
        let generatedGreen  = (int * 98765) % brightNess
       
        let red:CGFloat = CGFloat(CGFloat(generatedRed)/255.0)
        let green:CGFloat = CGFloat(CGFloat(generatedBlue)/255.0)
        let blue:CGFloat = CGFloat(CGFloat(generatedGreen)/255.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)

    }
}

extension Character {
    var asciiValue: UInt32? {
        return String(self).unicodeScalars.filter{$0.isASCII}.first?.value
    }
}

extension UIView {
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame = self.bounds
    
        let color0 = UIColor.black.cgColor
        let color1 = UIColor.clear.cgColor
              
        layer.colors = [color1,color0]
        layer.startPoint = CGPoint(x: 0, y: 1)
        layer.endPoint = CGPoint(x: 0, y: 0)
        self.layer.insertSublayer(layer, at: 0)
    }
}


extension UIView
{
    class func loadFromNibNamed(_ nibNamed: String, bundle : Bundle? = nil) -> UIView?
    {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
    
    
    func loadAndAddNib()
    {
        if let
            nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last,
            let _ = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        {
            loadAndAddNib(nibName)
        }
    }
    
    
    func loadAndAddNib(_ named: String)
    {
        let contentView = Bundle.main.loadNibNamed(named, owner: self, options: nil)!.first as! UIView
        
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))
    }
}
// MARK: -

public func delay(_ delay:Double,closure:  @escaping ()->())
{
    DispatchQueue.main.asyncAfter(
        
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}




// MARK: -

public func removeNotificationObserver(_ observer: AnyObject?) {
    
    if let observer = observer {
        
        NotificationCenter.default.removeObserver(observer)
    }
}


// MARK: -

public func cycle(_ times: Int, closure: () -> ())
{
    for _ in 0..<times
    {
        closure()
    }
}


public func between<T : Comparable>(_ minimum: T, maximum: T, value: T) -> T
{
    return min( max(minimum, value) , maximum)
}


public func degreesToRadians(_ degrees:Double) -> CGFloat
{
    return CGFloat((degrees * M_PI) / 180.0)
}




// MARK: -

public func printAllAvailableFonts()
{
    
    let fontFamilyNames = UIFont.familyNames
    
    for familyName in fontFamilyNames
    {
        print("------------------------------")
        print("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNames(forFamilyName: familyName )
        print("Font Names = [\(names)]")
    }
}


public func RGB(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat) -> UIColor!
{
    return RGBA(red, green, blue, 1)
}


public func RGBA(_ red: CGFloat,_ green: CGFloat,_ blue: CGFloat,_ alpha: CGFloat) -> UIColor!
{
    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
}






// MARK: - Extensions

public extension String
{
    public var urlEncodeString: String? {
        get {
            let allowedCharacters = (CharacterSet.urlQueryAllowed as NSCharacterSet).mutableCopy() as! NSMutableCharacterSet
            allowedCharacters.removeCharacters(in: "+/=")
            
            return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters as CharacterSet)
        }
    }
}




public extension UITextField
{
    public var isEmpty: Bool
        {
            return text?.isEmpty ?? true
    }
    
    public var isNotEmpty: Bool
        {
            return !isEmpty
    }
}




public extension UINavigationController
{
    public var rootViewController: UIViewController
        {
            return self.viewControllers.first!
    }
    
    
    public func setTransparentNavigationBar()
    {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
}




public extension Array
{
    
    public var isEmpty : Bool
        {
            return count == 0
    }
    
    public var isNotEmpty : Bool
        {
            return !isEmpty
    }
    
    public mutating func removeObject<U: Equatable>(_ object: U)
    {
        var index: Int?
        
        for (idx, objectToCompare) in self.enumerated()
        {
            if let to = objectToCompare as? U
            {
                if object == to
                {
                    index = idx
                }
            }
        }
        
        if let index = index
        {
            self.remove(at: index)
        }
    }
}


public extension UIScreen
{
    public class func screenWidth() -> CGFloat!
    {
        return UIScreen.main.bounds.size.width
    }
    
    public class func screenHeight() -> CGFloat!
    {
        return UIScreen.main.bounds.size.height
    }
}


public extension UICollectionReusableView
{
    static public var autoReuseIdentifier : String
    {
        return NSStringFromClass(self) + "AutogenerateIdentifier"
    }
}



public extension UICollectionView
{
    public var currentPageNumber: Int
        {
            return Int(ceil(self.contentOffset.x / self.frame.size.width))
    }
    
    
    public func dequeue<T: UICollectionReusableView>(cell: T.Type, indexPath: IndexPath) -> T?
    {
        return dequeueReusableCell(withReuseIdentifier: T.autoReuseIdentifier, for: indexPath) as? T
    }
    
    
    public func dequeue<T: UICollectionReusableView>(header: T.Type, indexPath: IndexPath) -> T?
    {
        return  dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: T.autoReuseIdentifier,
            for: indexPath)    as? T
    }
    
    
    public func dequeue<T: UICollectionReusableView>(footer: T.Type, indexPath: IndexPath) -> T?
    {
        return  dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: T.autoReuseIdentifier,
            for: indexPath)    as? T
    }
    
    
    public func registerCell<T: UICollectionReusableView>(_ cell : T.Type)
    {
        register(nibFromClass(cell), forCellWithReuseIdentifier: cell.autoReuseIdentifier)
    }
    
    public func registerSectionHeader<T: UICollectionReusableView>(_ header : T.Type)
    {
        register(nibFromClass(header), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: header.autoReuseIdentifier)
    }
    
    
    public func registerSectionFooter<T: UICollectionReusableView>(_ footer : T.Type)
    {
        register(nibFromClass(footer), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: footer.autoReuseIdentifier)
    }
    
    
    // Private
    
    fileprivate func nibFromClass(_ type: UICollectionReusableView.Type) -> UINib?
    {
        guard let nibName = NSStringFromClass(type).components(separatedBy: ".").last
            else {
                return nil
        }
        
        return UINib(nibName: nibName, bundle: nil)
    }
}




public extension UITableViewCell
{
    static public var autoReuseIdentifier : String {
        
        return NSStringFromClass(self) + "AutogeneratedIdentifier"
    }
}


public extension UITableView
{
    
    public func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T?
    {
        return dequeueReusableCell(withIdentifier: T.autoReuseIdentifier, for: indexPath) as? T
    }
    
    public func registerCell<T: UITableViewCell>(_ cell : T.Type)
    {
        register(nibFromClass(cell), forCellReuseIdentifier: cell.autoReuseIdentifier)
    }
    
    
    // Private
    
    fileprivate func nibFromClass(_ type: UITableViewCell.Type) -> UINib?
    {
        guard let nibName = NSStringFromClass(type).components(separatedBy: ".").last
            else {
                return nil
        }
        
        return UINib(nibName: nibName, bundle: nil)
    }
}




public extension UIImage
{
    
    /**
    Returns image with size 1x1px of certain color.
    */
    public class func imageWithColor(_ color : UIColor) -> UIImage
    {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /**
    Returns current image colored to certain color.
    */
    @available(*, deprecated, message: "Use similar build-in XCAssetCatalog functionality.")
    public func imageWithColor(_ color: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()
        context!.translateBy(x: 0, y: self.size.height)
        context!.scaleBy(x: 1.0, y: -1.0)
        
        
        context!.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context!.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context!.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!;
    }
}

public extension UIWindow
{
    public func visibleViewController() -> UIViewController?
    {
        if let rootViewController: UIViewController  = self.rootViewController
        {
            return UIWindow.getVisibleViewControllerFrom(rootViewController)
        }
        
        return nil
    }
    
    public class func getVisibleViewControllerFrom(_ vc:UIViewController) -> UIViewController
    {
        if let navigationController = vc as? UINavigationController
        {
            return UIWindow.getVisibleViewControllerFrom(navigationController.visibleViewController!)
            
        } else if let tabBarController = vc as? UITabBarController {
            
            return UIWindow.getVisibleViewControllerFrom(tabBarController.selectedViewController!)
            
        } else if let
            pageViewController = vc as? UIPageViewController,
            let currentVC = pageViewController.viewControllers?.first
        {
            return UIWindow.getVisibleViewControllerFrom(currentVC)
            
        } else {
            
            if let presentedViewController = vc.presentedViewController
            {
                return UIWindow.getVisibleViewControllerFrom(presentedViewController)
                
            } else {
                
                return vc
            }
        }
    }
}


extension UIView
{
    func loadNib()
    {
        if let
            nibName = NSStringFromClass(type(of: self)).components(separatedBy: ".").last,
            let _ = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        {
            let contentView = Bundle.main.loadNibNamed(nibName, owner: self, options: nil)!.first as! UIView
            
            addSubview(contentView)
            contentView.translatesAutoresizingMaskIntoConstraints = false
            
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView]|", options: [], metrics: nil, views: ["contentView": contentView]))
        }
    }
}
