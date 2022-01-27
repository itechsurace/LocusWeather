//
//  NSObject+Extension.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import Foundation

extension NSObject {
    
    static func name() -> String{
        return String(describing: self)
    }
}
