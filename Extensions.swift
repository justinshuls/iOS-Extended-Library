//
//  Extensions.swift
//  Extentions Master
//
//  Created by Justin Shulman on 10/1/18.
//

import Foundation

extension String {
    
    func isBackspace() -> Bool {
        
        let  char = self.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        return isBackSpace == -92
    }
    
    func trimmed() {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var filterNumbers: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var filterPhoneDigit: String {
        
        let including = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "+:;"))
        
        return components(separatedBy: including.inverted)
            .joined()
    }
    
    func filterSpaces() -> String {
        return self.replacingOccurrences(of: " ", with: "")
    }
}
