//
//  LSHomeViewController.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import UIKit
import SPAlert

class LSHomeViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bgView: UIImageView!
    
    var viewModel = LSWeatherViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Setup Textfield Border
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.white.cgColor
        textField.tintColor = .yellow
    }
    
    @IBAction func submitDidPress(_ sender: UIButton) {
        guard let cityName = textField.text else {
            return
        }
        let spinner = AlertView.showSpinner(title: GlobalConstants.uiConstants.spinnerTitle)
        self.viewModel.loadForecasts(cityName: cityName) { [unowned self] result in
            DispatchQueue.main.async {
                AlertView.hideSpinner(alertView: spinner)
            }
            switch result {
            case .success( _):
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: GlobalConstants.storyboardConstants.mainStoryboardName, bundle: nil)
                    if let listViewController = storyboard.instantiateViewController(withIdentifier: LSListViewController.name()) as? LSListViewController {
                        listViewController.viewModel = viewModel
                        listViewController.inputCityName = cityName
                        self.navigationController?.pushViewController(listViewController, animated: true)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    AlertView.showAlert(title: error.localizedDescription)
                    print("ERROR: On loadForecasts - \(error.localizedDescription)")
                }
            }
        }
        
       
    }
}
