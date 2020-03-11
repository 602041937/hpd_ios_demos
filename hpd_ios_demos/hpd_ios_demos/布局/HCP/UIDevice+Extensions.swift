//
//  UIDeviceExtension.swift
//  雅思哥
//
//  Created by Samuel on 2017/9/12.
//  Copyright © 2017年 chutzpah. All rights reserved.
//

import Foundation


#if os(iOS) || os(tvOS)

import UIKit

private let DeviceList = [
    /* iPod 5 */
    "iPod5,1": "iPod Touch 5",
    /* iPod 6 */
    "iPod7,1": "iPod Touch 6",
    /* iPhone 4 */
    "iPhone3,1": "iPhone 4",
    "iPhone3,2": "iPhone 4",
    "iPhone3,3": "iPhone 4",
    /* iPhone 4S */
    "iPhone4,1": "iPhone 4S",
    /* iPhone 5 */
    "iPhone5,1": "iPhone 5",
    "iPhone5,2": "iPhone 5",
    /* iPhone 5C */
    "iPhone5,3": "iPhone 5C",
    "iPhone5,4": "iPhone 5C",
    /* iPhone 5S */
    "iPhone6,1": "iPhone 5S",
    "iPhone6,2": "iPhone 5S",
    /* iPhone 6 */
    "iPhone7,2": "iPhone 6",
    /* iPhone 6 Plus */
    "iPhone7,1": "iPhone 6 Plus",
    /* iPhone 6S */
    "iPhone8,1": "iPhone 6S",
    /* iPhone 6S Plus */
    "iPhone8,2": "iPhone 6S Plus",
    /* iPhone 7 */
    "iPhone9,1": "iPhone 7",
    "iPhone9,3": "iPhone 7",
    /* iPhone 7 Plus */
    "iPhone9,2": "iPhone 7 Plus",
    "iPhone9,4": "iPhone 7 Plus",
    /* iPhone SE */
    "iPhone8,4": "iPhone SE",
    /* iPhone 8 */
    "iPhone10,1": "iPhone 8",
    "iPhone10,4": "iPhone 8",
    /* iPhone 8 Plus */
    "iPhone10,2": "iPhone 8 Plus",
    "iPhone10,5": "iPhone 8 Plus",
    /* iPhone X */
    "iPhone10,3": "iPhone X",
    "iPhone10,6": "iPhone X",
    /* iPhone XS */
    "iPhone11,2" : "iPhone XS",
    /* iPhone XS Max */
    "iPhone11,4" : "iPhone XS Max",
    "iPhone11,6" : "iPhone XS Max",
    /* iPhone XR */
    "iPhone11,8" : "iPhone XR",
    /* iPad 2 */
    "iPad2,1": "iPad 2",
    "iPad2,2": "iPad 2",
    "iPad2,3": "iPad 2",
    "iPad2,4": "iPad 2",
    /* iPad 3 */
    "iPad3,1": "iPad 3",
    "iPad3,2": "iPad 3",
    "iPad3,3": "iPad 3",
    /* iPad 4 */
    "iPad3,4": "iPad 4",
    "iPad3,5": "iPad 4",
    "iPad3,6": "iPad 4",
    /* iPad Air */
    "iPad4,1": "iPad Air",
    "iPad4,2": "iPad Air",
    "iPad4,3": "iPad Air",
    /* iPad Air 2 */
    "iPad5,3": "iPad Air 2",
    "iPad5,4": "iPad Air 2",
    /* iPad Mini */
    "iPad2,5": "iPad Mini",
    "iPad2,6": "iPad Mini",
    "iPad2,7": "iPad Mini",
    /* iPad Mini 2 */
    "iPad4,4": "iPad Mini 2",
    "iPad4,5": "iPad Mini 2",
    "iPad4,6": "iPad Mini 2",
    /* iPad Mini 3 */
    "iPad4,7": "iPad Mini 3",
    "iPad4,8": "iPad Mini 3",
    "iPad4,9": "iPad Mini 3",
    /* iPad Mini 4 */
    "iPad5,1": "iPad Mini 4",
    "iPad5,2": "iPad Mini 4",
    /* iPad 5 */
    "iPad6,11": "iPad 5",
    "iPad6,12": "iPad 5",
    /* iPad Pro */
    "iPad6,3": "iPad Pro",
    "iPad6,4": "iPad Pro",
    "iPad6,7": "iPad Pro",
    "iPad6,8": "iPad Pro",
    "iPad7,1": "iPad Pro",
    "iPad7,2": "iPad Pro",
    "iPad7,3": "iPad Pro",
    "iPad7,4": "iPad Pro",
    /* AppleTV */
    "AppleTV5,3": "AppleTV",
    /* Simulator */
    "x86_64": "Simulator",
    "i386": "Simulator"
    
]


enum PhoneScreenType: Float {
    case iPhone4 = 3.5
    case iPhone5 = 4.0
    case iPhone6 = 4.7
    case iPhone6PLUS = 5.5
    case iPhoneX = 5.8
}

extension UIDevice {
    
    public class func idForVendor() -> String {
        let uuid = UIDevice.current.identifierForVendor?.uuidString
//        guard let identifierForVendor = KeyChainManager.shared.identifierForVendor else {
//            KeyChainManager.shared.identifierForVendor = uuid
//            return uuid ?? ""
//        }
//        return identifierForVendor
        return uuid ?? ""
    }
    
    public class func systemName() -> String {
        return UIDevice.current.systemName
    }
    
    public class func systemVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    public class func systemFloatVersion() -> Float {
        return (systemVersion() as NSString).floatValue
    }
    
    public class func deviceName() -> String {
        return UIDevice.current.name
    }
    
    public class func deviceLanguage() -> String {
        return Bundle.main.preferredLocalizations[0]
    }
    
    public class func deviceModelReadable() -> String {
        return DeviceList[deviceModel()] ?? deviceModel()
    }
    
    public class func isIphoneX() -> Bool {
        _ = deviceModel()
        
//        #if targetEnvironment(simulator) && os(iOS)
        
        if UIScreen.main.bounds.width == 812.0 || UIScreen.main.bounds.height == 812.0 ||   // iPhone X / iPhone XS
            UIScreen.main.bounds.width == 896.0 || UIScreen.main.bounds.height == 896.0 {   // iPhone XS Max / iPhone XR
            return true
        }
        return false
        
//        #else
//
//        return model == "iPhone10,3" || model == "iPhone10,6"
//        #endif
    }
    
    /// IphoneXR IphoneXSMax
    public class func isIphoneXROrIphoneXSMax() -> Bool {
        if UIScreen.main.bounds.width == 896.0 || UIScreen.main.bounds.height == 896.0 {   // iPhone XS Max / iPhone XR
            return true
        }
        return false
    }
    
    /// 6P 6sP 7P 8P
    public class func isIphonePlus() -> Bool {
        if UIScreen.main.bounds.width == 736.0 || UIScreen.main.bounds.height == 736.0 {   // iPhone XS Max / iPhone XR
            return true
        }
        return false
    }
    
    public class func isPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.phone
    }
    
    public class func isPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
    }
    
    public class func deviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let machine = systemInfo.machine
        var identifier = ""
        let mirror = Mirror(reflecting: machine)
        
        for child in mirror.children {
            let value = child.value
            
            if let value = value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        
        return identifier
    }
    
    
    public enum Versions: Float {
        case five = 5.0
        case six = 6.0
        case seven = 7.0
        case eight = 8.0
        case nine = 9.0
        case ten = 10.0
        case eleven = 11.0
    }
    
    public class func isVersion(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue && systemFloatVersion() < (version.rawValue + 1.0)
    }
    
    public class func isVersionOrLater(_ version: Versions) -> Bool {
        return systemFloatVersion() >= version.rawValue
    }
    
    public class func isVersionOrEarlier(_ version: Versions) -> Bool {
        return systemFloatVersion() < (version.rawValue + 1.0)
    }
    
    public class var CURRENT_VERSION: String {
        return "\(systemFloatVersion())"
    }
    
    // MARK: iOS 5 Checks
    
    public class func is_OS_5() -> Bool {
        return isVersion(.five)
    }
    
    public class func is_OS_5_OR_LATER() -> Bool {
        return isVersionOrLater(.five)
    }
    
    public class func is_OS_5_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.five)
    }
    
    // MARK: iOS 6 Checks
    
    public class func is_OS_6() -> Bool {
        return isVersion(.six)
    }
    
    public class func is_OS_6_OR_LATER() -> Bool {
        return isVersionOrLater(.six)
    }
    
    public class func is_OS_6_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.six)
    }
    
    // MARK: iOS 7 Checks
    
    public class func is_OS_7() -> Bool {
        return isVersion(.seven)
    }
    
    public class func is_OS_7_OR_LATER() -> Bool {
        return isVersionOrLater(.seven)
    }
    
    public class func is_OS_7_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.seven)
    }
    
    // MARK: iOS 8 Checks
    
    public class func is_OS_8() -> Bool {
        return isVersion(.eight)
    }
    
    public class func is_OS_8_OR_LATER() -> Bool {
        return isVersionOrLater(.eight)
    }
    
    public class func is_OS_8_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.eight)
    }
    
    // MARK: iOS 9 Checks
    
    public class func is_OS_9() -> Bool {
        return isVersion(.nine)
    }
    
    public class func is_OS_9_OR_LATER() -> Bool {
        return isVersionOrLater(.nine)
    }
    
    public class func is_OS_9_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.nine)
    }
    
    // MARK: iOS 10 Checks
    
    public class func is_OS_10() -> Bool {
        return isVersion(.ten)
    }
    
    public class func is_OS_10_OR_LATER() -> Bool {
        return isVersionOrLater(.ten)
    }
    
    public class func is_OS_10_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.ten)
    }
    
    
    // MARK: iOS 11 Checks
    
    public class func is_OS_11() -> Bool {
        return isVersion(.eleven)
    }
    
    public class func is_OS_11_OR_LATER() -> Bool {
        return isVersionOrLater(.eleven)
    }
    
    public class func is_OS_11_OR_EARLIER() -> Bool {
        return isVersionOrEarlier(.eleven)
    }
    
    public class func isSystemVersionOver(_ requiredVersion: String) -> Bool {
        switch systemVersion().compare(requiredVersion, options: NSString.CompareOptions.numeric) {
        case .orderedSame, .orderedDescending:
            //println("iOS >= 8.0")
            return true
        case .orderedAscending:
            //println("iOS < 8.0")
            return false
        }
    }
}

// MARK: - 屏幕旋转
extension UIDevice {
    static func rotateTo(_ orientation: UIDeviceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
        // 解决当开启屏幕旋转，并且屏幕方向和设备方向不一致时，上面的强制旋转有时无效的问题
        UIViewController.attemptRotationToDeviceOrientation()
    }
}

#endif
