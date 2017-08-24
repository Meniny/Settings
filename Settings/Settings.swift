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
        case about = "prefs:root=General&path=About"
        case accessibility = "prefs:root=General&path=ACCESSIBILITY"
        case airplaneModeOn = "prefs:root=AIRPLANE_MODE"
        case autoLock = "prefs:root=General&path=AUTOLOCK"
        case brightness = "prefs:root=Brightness"
        case bluetooth = "prefs:root=General&path=Bluetooth"
        case dateAndTime = "prefs:root=General&path=DATE_AND_TIME"
        case faceTime = "prefs:root=FACETIME"
        case general = "prefs:root=General"
        case keyboard = "prefs:root=General&path=Keyboard"
        case iCloud = "prefs:root=CASTLE"
        case iCloudStorageAndBackup = "prefs:root=CASTLE&path=STORAGE_AND_BACKUP"
        case international = "prefs:root=General&path=INTERNATIONAL"
        case locationServices = "prefs:root=LOCATION_SERVICES"
        case music = "prefs:root=MUSIC"
        case musicEqualizer = "prefs:root=MUSIC&path=EQ"
        case musicVolumeLimit = "prefs:root=MUSIC&path=VolumeLimit"
        case network = "prefs:root=General&path=Network"
        case nikeiPod = "prefs:root=NIKE_PLUS_IPOD"
        case notes = "prefs:root=NOTES"
        case notification = "prefs:root=NOTIFICATIONS_ID"
        case phone = "prefs:root=Phone"
        case photos = "prefs:root=Photos"
        case profile = "prefs:root=General&path=ManagedConfigurationList"
        case reset = "prefs:root=General&path=Reset"
        case safari = "prefs:root=Safari"
        case siri = "prefs:root=General&path=Assistant"
        case sounds = "prefs:root=Sounds"
        case softwareUpdate = "prefs:root=General&path=SOFTWARE_UPDATE_LINK"
        case store = "prefs:root=STORE"
        case twitter = "prefs:root=TWITTER"
        case usage = "prefs:root=General&path=USAGE"
        case vPN = "prefs:root=General&path=Network/VPN"
        case wallpaper = "prefs:root=Wallpaper"
        case wiFi = "prefs:root=WIFI"
        case privacy = "prefs:root=Privacy"
        //case PrivacyPhotos = "prefs:root=Privacy&path=Photos"
        case root = "prefs:root="
    }
    
    public var path: String
    
    public init(path: String) {
        self.path = path
    }
    
    public init(bundleIdentifier: String) {
        path = Settings.Path.root.rawValue + bundleIdentifier
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
    
    public func open() {
        if canOpen {
            if let url = URL(string: path) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    public class func open(settings: Settings) {
        settings.open()
    }
}

public typealias SettingsPath = Settings.Path

