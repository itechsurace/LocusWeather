//
//  GlobalConstants.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import Foundation

struct GlobalConstants {
    
    struct apiConstants {
        static let apiKey: String = "d64a77680e4db43a8f87472701560129"
        static let apiTimeout = 60.0
        static let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q="
        static let keyAppender = "&units=metric&appid=" + apiKey
        static let httpMethod = "GET"
    }
    
    struct uiConstants {
        static let alertDismissDurarion = 4.0
        static let spinnerTitle = "Please, wait"
        static let imageSquare = "square.grid.2x2"
        static let imageList = "list.bullet"
    }
    
    struct storyboardConstants {
        static let mainStoryboardName = "Main"
    }
}
