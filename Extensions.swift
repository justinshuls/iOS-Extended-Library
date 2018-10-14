//
//  Extensions.swift
//  Extentions Master
//
//  Created by Justin Shulman on 10/1/18.
//

import Foundation

//MARK:- string

extension String {
    
    var isBackspace: Bool {
        
        let  char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        return isBackSpace == -92
    }
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var filteredNumbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var filteredPhoneDigit: String {
        
        let including = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+:;"))
        
        return components(separatedBy: including.inverted)
            .joined()
    }
    
    var filteredSpaces: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
    UINotificationFeedbackGenerator().notificationOccurred(type)
}

func haptic(intensity: UIImpactFeedbackGenerator.FeedbackStyle) {
    let generator = UIImpactFeedbackGenerator(style: intensity)
    generator.impactOccurred()
}
