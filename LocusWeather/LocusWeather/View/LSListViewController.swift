//
//  LSListViewController.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import UIKit

enum ImageIcons: String {
    case cloud = "cloud"
    case mist = "mist"
    case temperature = "temperature"
    case wind = "wind"
}

enum Feature: Int {
    case Weather
    case Temperature
    case Wind
}

enum FeatureStr: String {
    case Weather = "Weather"
    case Temperature = "Temperature"
    case Wind = "Wind"
}

class LSListViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = LSWeatherViewModel()
    var inputCityName: String = ""
    let numberOfMaxItem = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension LSListViewController {
    fileprivate func setup() {
        self.title = self.inputCityName
        collectionView.isUserInteractionEnabled = true

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: GlobalConstants.uiConstants.imageSquare),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(layoutToggleTapped))
        
        collectionView.collectionViewLayout = viewModel.listFlowLayout
    }
}

extension LSListViewController {
    @objc func layoutToggleTapped() {
        viewModel.isGridLayout = viewModel.isGridLayout ? false : true
        navigationItem.rightBarButtonItem!.image = viewModel.isGridLayout ? UIImage(systemName: GlobalConstants.uiConstants.imageList) : UIImage(systemName: GlobalConstants.uiConstants.imageSquare)
        
        UIView.animate(withDuration: 0.5) { [unowned self] () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            let chosenLayout = self.viewModel.isGridLayout ? self.viewModel.gridFlowLayout : self.viewModel.listFlowLayout
            self.collectionView.setCollectionViewLayout(chosenLayout, animated: true)
        }
    }
}

extension LSListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfMaxItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LSForecastCell.self), for: indexPath) as! LSForecastCell
        
        cell.delegate = self
        cell.indexPath = indexPath
        
        let index = indexPath.row % numberOfMaxItem

        switch index {
        case Feature.Weather.rawValue:
            //Weather
            return self.configureCell(title: FeatureStr.Weather.rawValue, desc: viewModel.weatherDescription ?? "", bgColor: .systemPink.withAlphaComponent(0.5), imageName: ImageIcons.cloud.rawValue, cell: cell)
        case Feature.Temperature.rawValue:
            // Temperature
            return self.configureCell(title: FeatureStr.Temperature.rawValue, desc: (viewModel.temperature ?? "0") + " º", bgColor: self.adjustColor(Double(viewModel.temperature ?? "0") ?? 0).withAlphaComponent(0.5), imageName: ImageIcons.temperature.rawValue, cell: cell)
        case Feature.Wind.rawValue:
            // Wind
            return self.configureCell(title: FeatureStr.Wind.rawValue, desc: (viewModel.windSpeed ?? "0") + " º", bgColor: .lightGray.withAlphaComponent(0.5), imageName: ImageIcons.wind.rawValue, cell: cell)
        default:
            return cell
        }
    }
    
    fileprivate func configureCell(title: String?, desc: String?, bgColor: UIColor = .white, imageName: String = "", cell: LSForecastCell) -> LSForecastCell {
            cell.city.text = title
            cell.imageView.image = UIImage(named: imageName)
            cell.imageView.contentMode = .scaleAspectFit
            cell.temp.text = desc
            cell.backgroundColor = bgColor
        return cell
    }
    
    fileprivate func adjustColor(_ temp: Double) -> UIColor {
        switch temp {
            case ..<0: return UIColor.systemBlue
            case 0..<19: return UIColor.systemTeal
            case 19..<26: return UIColor.systemYellow
            case 26..<35: return UIColor.systemOrange
            case 35..<60: return UIColor.systemRed
            default: return UIColor.white
        }
    }
}

extension LSListViewController : LSForecastCellDelegate {
    func viewTapped(_ indexPath : IndexPath?) {
        if let row = indexPath?.row {
            let index = row % numberOfMaxItem
            let storyboard = UIStoryboard(name: GlobalConstants.storyboardConstants.mainStoryboardName, bundle: nil)
            if let LSDetailViewController = storyboard.instantiateViewController(withIdentifier: LSDetailViewController.name()) as? LSDetailViewController {
                LSDetailViewController.selectedIndex = Feature(rawValue: index) ?? .Weather
                LSDetailViewController.viewModel = viewModel
                self.navigationController?.pushViewController(LSDetailViewController, animated: true)
            }
        }
    }
}
