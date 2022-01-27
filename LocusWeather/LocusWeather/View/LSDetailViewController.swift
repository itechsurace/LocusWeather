//
//  LSDetailViewController.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import UIKit

class LSDetailViewController: UIViewController {

    var viewModel = LSWeatherViewModel()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelingLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    var selectedIndex: Feature = Feature(rawValue: 0)!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = viewModel.cityName
        
        switch self.selectedIndex {
        case Feature.Weather:
            imageView.image = UIImage(named: ImageIcons.cloud.rawValue)
            nameLabel.text = FeatureStr.Weather.rawValue
            descriptionLabel.text = viewModel.weatherDescription
        case Feature.Temperature:
            imageView.image = UIImage(named: ImageIcons.temperature.rawValue)
            nameLabel.text = FeatureStr.Temperature.rawValue
            descriptionLabel.text = viewModel.temperature
        case Feature.Wind:
            imageView.image = UIImage(named: ImageIcons.wind.rawValue)
            nameLabel.text = FeatureStr.Wind.rawValue
            descriptionLabel.text = viewModel.windSpeed
        }
        tempLabel.text = (viewModel.temperature ?? "0") + " º"
        feelingLabel.text = (viewModel.feelsLike ?? "0") + " º"
        humidityLabel.text = viewModel.humidity
        pressureLabel.text = viewModel.pressure
        windSpeedLabel.text = viewModel.windSpeed
        windDirectionLabel.text = (viewModel.windDirection ?? "0") + " º"
    }
}
