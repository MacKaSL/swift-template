//
//  Extensions.swift
//
//  Created by Himal Madhushan.
//  Copyright © Himal Madhushan. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import AlamofireImage

// MARK: -
extension  UIView {
    
    @IBInspectable
    var viewCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var isRounded : Bool {
        set {
            layer.cornerRadius = frame.size.height / 2
        }
        get {
            return self.isRounded
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    // MARK: - View Shadow
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func addViewShadow() {
        let shadowPath = UIBezierPath(rect: self.bounds)
        self.layer.shadowOffset = CGSize(width: 10, height: 0)
        self.layer.shadowOpacity = 0.2
        self.layer.shadowRadius = 7
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func removeShadow() {
        self.layer.shadowColor = UIColor.clear.cgColor
        self.layer.shadowPath = nil
    }
    
    func resetTransform() {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
        }) { (completed) in
        }
    }
    
}

// MARK: -
extension UINavigationController {
    
//    open override func viewDidLoad() {
//        navigationController?.navigationBar.largeTitleTextAttributes =
//            [NSAttributedStringKey.foregroundColor: UIColor.black,
//             NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 30) ??
//                UIFont.systemFont(ofSize: 30)]
//    }
    
    func makeTransparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.backgroundColor = UIColor.clear
    }
    
    @IBInspectable var barTintColor: UIColor? {
        set {
            navigationBar.barTintColor = newValue
        }
        get {
            guard  let color = navigationBar.barTintColor else { return nil }
            return color
        }
    }
    
    @IBInspectable var tintColor: UIColor? {
        set {
            navigationBar.tintColor = newValue
        }
        get {
            guard  let color = navigationBar.tintColor else { return nil }
            return color
        }
    }
    
    @IBInspectable var titleColor: UIColor? {
        set {
            guard let color = newValue else { return }
            navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: color]
        }
        get {
            return navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] as? UIColor
        }
    }
}

// MARK: -
extension UIViewController {
    func showAlert(title:String, message:String, actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler:nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String, message:String, actionTitle:String, completion: @escaping (()->())) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: { (action) in
            completion()
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: -
extension UIButton {
    
    @IBInspectable public var isBtnRounded : Bool {
        set {
            layer.cornerRadius = frame.size.height / 2
        }
        get {
            return self.isBtnRounded
        }
    }
    
    @IBInspectable public var btnCornerRadius : CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable public var centerVertical : Bool {
        set {
            centerVerticallyTextAndImage(padding: 0)
        }
        get {
            return self.centerVertical
        }
    }
    
    func centerVerticallyTextAndImage(padding: CGFloat) {
        let imageSize = imageView?.frame.size;
        let titleSize = titleLabel?.frame.size;
        
        let totalHeight = ((imageSize?.height)! + (titleSize?.height)! + padding);
        
//        let buttonSize = frame.size
//        let cen = buttonSize.width / 2 - ((imageSize?.width)!/2)
        
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize?.height)!, left: 0, bottom: 0, right: (-titleSize!.width))
        self.titleEdgeInsets = UIEdgeInsets(top: padding, left: (-(imageSize?.width)!), bottom: -(totalHeight - (titleSize?.height)!), right: 0)
//        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: (titleSize?.height)!, right: 0)
    }
}


// MARK: -
extension UICollectionView {
    func indexPathsForElement(in rect: CGRect) -> [IndexPath] {
        let allLayoutAttributes = collectionViewLayout.layoutAttributesForElements(in: rect)!
        return allLayoutAttributes.map { $0.indexPath }
    }
}

// MARK: -
extension UIApplication {
    var screenShot: UIImage?  {
        return keyWindow?.layer.screenShot
    }
}

// MARK: -
extension CALayer {
    var screenShot: UIImage?  {
        let scale = UIScreen.main.scale
        let layer = UIApplication.shared.keyWindow!.layer
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
//        if let context = UIGraphicsGetCurrentContext() {
//            render(in: context)
//            let screenshot = UIGraphicsGetImageFromCurrentImageContext()
//            UIGraphicsEndImageContext()
//            return screenshot
//        }
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return screenshot
    }
}

// MARK: -
extension UIImageView {
    @IBInspectable public var isImageRounded : Bool {
        set {
            layer.cornerRadius = frame.size.height / 2
            clipsToBounds = true
        }
        get {
            return self.isImageRounded
        }
    }
    
    func setImage(from url: String) {
        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicator.isHidden = false
        indicator.frame.origin.x = self.frame.width/2-10
        indicator.frame.origin.y = self.frame.height/2-10
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        indicator.color = AppColor.blue
        self.addSubview(indicator)
        self.bringSubview(toFront: indicator)
        
        self.af_setImage(withURL: URL(string: url)!, placeholderImage:#imageLiteral(resourceName: "Logo"), filter: nil, progress: { (progress) in
        }, progressQueue: DispatchQueue(label: "imageDlQueue"), imageTransition: UIImageView.ImageTransition.crossDissolve(0.4), runImageTransitionIfCached: true) { (image) in
            indicator.stopAnimating()
            indicator.removeFromSuperview()
        }
    }
}


// MARK: -
extension UITextField {
    func isEmpty() -> Bool {
        return (self.text?.isEmpty)! ? true : false
    }
    
    func isNotEmpty() -> Bool {
        return !(self.text?.isEmpty)! ? true : false
    }
    
    @IBInspectable var placeholderColor: UIColor {
        get {
            guard let currentAttributedPlaceholderColor = attributedPlaceholder?.attribute(NSAttributedStringKey.foregroundColor, at: 0, effectiveRange: nil) as? UIColor else { return UIColor.clear }
            return currentAttributedPlaceholderColor
        }
        set {
            guard let currentAttributedString = attributedPlaceholder else { return }
            let attributes = [NSAttributedStringKey.foregroundColor : newValue]
            attributedPlaceholder = NSAttributedString(string: currentAttributedString.string, attributes: attributes)
        }
    }
}


// MARK: -
extension UIColor {
    
    class func hex(_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func randomColor(randomAlpha randomApha:Bool = false)->UIColor{
        let redValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let greenValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let blueValue = CGFloat(arc4random_uniform(255)) / 255.0;
        let alphaValue = randomApha ? CGFloat(arc4random_uniform(255)) / 255.0 : 1;
        return UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
    }

}

// MARK: -
extension String {
    func toDate(format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let date = formatter.date(from: self)
        return date
    }
}

// MARK: -
extension Date {
    func seconds(to: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: self, to: to).second ?? 0
    }
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssa"
        let dateStr = formatter.string(from: self)
        return dateStr
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateStr = formatter.string(from: self)
        return dateStr
    }
}

// MARK: -
extension Array {
    func removeDuplicates(array: [String]) -> [String] {
        var encountered = Set<String>()
        var result: [String] = []
        for value in array {
            if !encountered.contains(value) {
                // Do not add a duplicate element.
                encountered.insert(value)
                result.append(value)
            }
        }
        return result
    }
}

// MARK: -
extension NSDate {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssa"
        let dateStr = formatter.string(from: self as Date)
        return dateStr
    }
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let dateStr = formatter.string(from: self as Date)
        return dateStr
    }
}

// MARK: -
extension Dictionary {
    mutating func add(other:Dictionary) -> Dictionary {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
        return self
    }
    
    func containsAndNotNil(key: Key) -> Bool {
        if self.keys.contains(key) && !(self[key] is NSNull) && self[key] != nil {
            return true
        } else {
            return false
        }
    }
}

// MARK: -
extension AppDelegate {
    func registerNotifications() {
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            UIApplication.shared.registerForRemoteNotifications()
        }
        // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
        // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
}

// MARK: -
protocol JSONConvertible {}
extension JSONConvertible {
    func toDictionary() -> [String:Any] {
        var dict = [String:Any]()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value
            }
        }
        return dict
    }
}
