//
//  AlertView.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import SPAlert

struct AlertView {
    
    static func showAlert(title: String) {
        let alertView = SPAlertView(title: title, preset: .error)
        alertView.duration = GlobalConstants.uiConstants.alertDismissDurarion
        alertView.dismissByTap = true
        alertView.present()
    }
    
    static func showSpinner(title: String) -> SPAlertView {
        let alertView = SPAlertView(title: title, preset: .spinner)
        alertView.present()
        return alertView
    }
    
    static func hideSpinner(alertView: SPAlertView) {
        alertView.dismiss()
    }
    
}
