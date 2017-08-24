//
//  Settings.swift
//  Joyup
//
//  Created by Meniny on 2017-08-24.
//  Copyright © 2017年 Meniny. All rights reserved.
//

import Foundation

public class Settings {
    
    public enum Path: String {
        case about = "General&path=About"
        case accessibility = "General&path=ACCESSIBILITY"
        case airplaneModeOn = "AIRPLANE_MODE"
        case autoLock = "General&path=AUTOLOCK"
        case brightness = "Brightness"
        case bluetooth = "General&path=Bluetooth"
        case dateAndTime = "General&path=DATE_AND_TIME"
        case faceTime = "FACETIME"
        case general = "General"
        case keyboard = "General&path=Keyboard"
        case iCloud = "CASTLE"
        case iCloudStorageAndBackup = "CASTLE&path=STORAGE_AND_BACKUP"
        case international = "General&path=INTERNATIONAL"
        case locationServices = "LOCATION_SERVICES"
        case music = "MUSIC"
        case musicEqualizer = "MUSIC&path=EQ"
        case musicVolumeLimit = "MUSIC&path=VolumeLimit"
        case network = "General&path=Network"
        case nikeiPod = "NIKE_PLUS_IPOD"
        case notes = "NOTES"
        case notification = "NOTIFICATIONS_ID"
        case phone = "Phone"
        case photos = "Photos"
        case profile = "General&path=ManagedConfigurationList"
        case reset = "General&path=Reset"
        case safari = "Safari"
        case siri = "General&path=Assistant"
        case sounds = "Sounds"
        case softwareUpdate = "General&path=SOFTWARE_UPDATE_LINK"
        case store = "STORE"
        case twitter = "TWITTER"
        case usage = "General&path=USAGE"
        case vPN = "General&path=Network/VPN"
        case wallpaper = "Wallpaper"
        case wiFi = "WIFI"
        case privacy = "Privacy"
        //case PrivacyPhotos = "Privacy&path=Photos"
        case root = "root"
        
        public var afteriOS10: String {
            return Settings.Path.mix(rawValue, iOS10: true)
        }
        
        public var beforeiOS10: String {
            return Settings.Path.mix(rawValue, iOS10: false)
        }
        
        public var path: String {
            if UIDevice.aboveiOS10 {
                return afteriOS10
            }
            return beforeiOS10
        }
        
        fileprivate static func mix(_ raw: String, iOS10: Bool) -> String {
            var path = (iOS10 ? "App-Prefs:" : "prefs:") + Settings.Path.root.rawValue
            if raw != Settings.Path.root.rawValue && !raw.isEmpty {
                path.append("=" + raw)
            }
            
            return path
        }
    }
    
    public var path: String
    
    public init(path: String) {
        if let pe = Settings.Path(rawValue: path) {
            self.path = pe.path
        } else {
            self.path = path
        }
    }
    
    public init(_ path: Settings.Path) {
        self.path = path.path
    }
    
    public init(bundleIdentifier: String) {
        path = Settings.Path.mix(bundleIdentifier, iOS10: UIDevice.aboveiOS10)
    }
    
    public class var currentApp: Settings {
        let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String
        return Settings(bundleIdentifier: bundleIdentifier ?? "")
    }
    
    public class func canOpen(settings: Settings) -> Bool {
        return settings.canOpen
    }
    
    public var canOpen: Bool {
        guard let url = URL(string: path) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }
    
    @discardableResult
    public func open() -> Bool {
        if canOpen {
            if let url = URL(string: path) {
                return UIApplication.shared.openURL(url)
            }
        }
        return false
    }
    
    @discardableResult
    public class func open(settings: Settings) -> Bool {
        return settings.open()
    }
}

/// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
///
/// - Parameters:
///   - lhs: First version string
///   - rhs: Second version string
/// - Returns: Compare result
fileprivate func Compare(version lhs: String, with rhs: String) -> ComparisonResult {
    guard !lhs.isEmpty else {
        if rhs.isEmpty {
            return .orderedSame
        }
        return .orderedAscending
    }
    guard !rhs.isEmpty else {
        return .orderedDescending
    }
    
    return lhs.compare(rhs, options: .numeric, range: rhs.range(of: rhs), locale: nil)
}

/// Compare tow version string (eg: `1.0.0`, `2.0.1`, `3.0`)
///
/// - Parameters:
///   - lhs: First version string
///   - rhs: Second version string
/// - Returns: If `lhs` is greater than or equal to `rhs`
fileprivate func SystemVersion(_ version: String, greaterThanOrEqualTo rhs: String) -> Bool {
    return Compare(version: version, with: rhs) != .orderedAscending
}

fileprivate extension UIDevice {
    fileprivate static var aboveiOS10: Bool {
        return SystemVersion(UIDevice.current.systemVersion, greaterThanOrEqualTo: "10")
    }
}

public typealias SettingsPath = Settings.Path

