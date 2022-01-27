//
//  LSForecastCell.swift
//  LocusWeather
//
//  Created by Suresh D on 27/01/22.
//

import UIKit

protocol LSForecastCellDelegate: AnyObject {
    func viewTapped(_ indexPath : IndexPath?)
}

class LSForecastCell: UICollectionViewCell, UIGestureRecognizerDelegate {
  
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    weak var delegate : LSForecastCellDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.5
        self.temp.font = UIFont.boldSystemFont(ofSize: 12.0)
        self.layer.borderColor = UIColor.black.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        tapGesture.delegate = self
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(recognizer:UITapGestureRecognizer) {
        delegate?.viewTapped(self.indexPath)
    }
}
