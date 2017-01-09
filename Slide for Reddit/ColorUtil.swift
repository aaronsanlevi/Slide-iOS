//
//  ColorUtil.swift
//  Slide for Reddit
//
//  Created by Carlos Crane on 12/29/16.
//  Copyright © 2016 Haptic Apps. All rights reserved.
//

import Foundation
import ChameleonFramework

class ColorUtil{
    static var theme = Theme.DARK
    static func doInit(){
        if let name = UserDefaults.standard.string(forKey: "theme"){
            if let t = Theme(rawValue: name){
                theme = t
            }
        }
        foregroundColor = theme.foregroundColor
        backgroundColor = theme.backgroundColor
        fontColor = theme.fontColor
    }
    static var foregroundColor = UIColor.white
    static var backgroundColor = UIColor.white
    static var fontColor = UIColor.black
    static var baseColor:String = "#03A9F4"
    public static var upvoteColor = UIColor.init(hexString: "#FF9800")
    public static var downvoteColor = UIColor.init(hexString: "#2196F3")
    

    public static func getColorForSub(sub: String) -> UIColor {
        let color = UserDefaults.standard.colorForKey(key: "color+" + sub)
        if(color == nil){
            return UIColor(hexString: baseColor)
        } else {
            return color!
        }
    }
    
    public static func getColorForUser(name: String) -> UIColor {
        let color = UserDefaults.standard.colorForKey(key: "user+" + name)
        if(color == nil){
            return UIColor(hexString: baseColor)
        } else {
            return color!
        }
    }
    
    public static func accentColorForSub(sub: String) -> UIColor {
        let color = UserDefaults.standard.colorForKey(key: "accent+" + sub)
        if(color == nil){
            return UIColor(rgba: MaterialColors.Cyan.A200.HUE)
        } else {
            return color!
        }
    }

    
    enum Theme: String{
        case LIGHT = "light"
        case DARK = "dark"
        case BLACK = "black"
        case BLUE = "blue"
        case SEPIA = "sepia"
        case RED = "red"
        
        public static var cases: [Theme]{
            return [.LIGHT, .DARK, .BLACK, .BLUE, .SEPIA, .RED]
        }
        public var foregroundColor: UIColor {
            switch self {
            case .LIGHT:
                return UIColor.white
            case .DARK:
                return UIColor(hexString: "#303030")
            case .BLUE:
                return UIColor(hexString: "#37474F")
            case .SEPIA:
                return UIColor(hexString: "#e2dfd7")
            case .RED:
                return UIColor(hexString: "#402c2c")
            case .BLACK:
                return UIColor.black
            }
        }
        
        public var backgroundColor: UIColor {
            switch self {
            case .LIGHT:
                return UIColor(hexString: "#e5e5e5")
            case .DARK:
                return UIColor(hexString: "#212121")
            case .BLUE:
                return UIColor(hexString: "#2F3D44")
            case .SEPIA:
                return UIColor(hexString: "#cac5ad")
            case .RED:
                return UIColor(hexString: "#312322")
            case .BLACK:
                return UIColor.black
            }
        }
        
        public var fontColor: UIColor {
            switch self {
            case .LIGHT:
                return UIColor(hexString: "#000000").withAlphaComponent(0.87)
            case .DARK:
                return UIColor(hexString: "#FFFFFF").withAlphaComponent(0.87)
            case .BLUE:
                return UIColor(hexString: "#FFFFFF").withAlphaComponent(0.87)
            case .SEPIA:
                return UIColor(hexString: "#3e3d36").withAlphaComponent(0.87)
            case .RED:
                return UIColor(hexString: "#fff7ed").withAlphaComponent(0.87)
            case .BLACK:
                return UIColor(hexString: "#FFFFFF").withAlphaComponent(0.87)
            }
        }


    }
}
extension UserDefaults {
    
    func colorForKey(key: String) -> UIColor? {
        var color: UIColor?
        if let colorData = data(forKey: key) {
            color = NSKeyedUnarchiver.unarchiveObject(with: colorData) as? UIColor
        }
        return color
    }
    
    func setColor(color: UIColor?, forKey key: String) {
        var colorData: NSData?
        if let color = color {
            colorData = NSKeyedArchiver.archivedData(withRootObject: color) as NSData?
        }
        set(colorData, forKey: key)
    }
    
}

