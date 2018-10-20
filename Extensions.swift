//
//  Extensions.swift
//  Extentions Master
//
//  Created by Justin Shulman on 10/1/18.
//

import Foundation

//MARK:- string

extension String {
    
    func copyText() {
        UIPasteboard.general.string = self
    }
    
    var isBackspace: Bool {
        
        let  char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        return isBackSpace == -92
    }
    
    var hasText: Bool {
        return !self.isEmpty
    }
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var filteredNumbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var filteredPhoneDigits: String {
        
        let including = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+:;"))
        
        return components(separatedBy: including.inverted)
            .joined()
    }
    
    var filteredSpaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
}

//MARK:- float

extension Float {
    
    func decimialPlaces(count: Int) -> String {
        return String(format: "%.\(count)f", self)
    }
    
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

//MARK:- image

extension UIImage {
    
    func rotate(degrees: CGFloat) -> UIImage {
        
        let rad = degrees/57.2958
        
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(rad)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: rad)
            draw(in: CGRect(x: -origin.x, y: -origin.y,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
    
    func imageSize(size: CGSize) -> UIImage {
        
        let hasAlpha = true
        let scale: CGFloat = 0.0
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        
        let sizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return sizedImage!
        
    }
    
    func imageColor(color: UIColor) -> UIImage {
        self.withRenderingMode(.alwaysTemplate)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            context.setBlendMode(.normal)
            context.translateBy(x: 0, y: self.size.height)
            context.scaleBy(x: 1.0, y: -1.0)
            context.draw(self.cgImage!, in: rect)
            context.clip(to: rect, mask: self.cgImage!)
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }
        
        let colorizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return colorizedImage!
    }
    
}

//MARK:- application

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

//MARK:- haptic

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func haptic(intensity: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: intensity)
    generator.impactOccurred()
}


