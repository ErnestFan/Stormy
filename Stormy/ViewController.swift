//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 2/15/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currentPlacemark: UILabel!
    
    let client = DarkSkyAPIClient()
    
    let location = GeoLocationClient()
    
    let placemark = PlacemarkClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentWeather()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayWeather(using viewModel: CurrentWeatherViewModel) {
        currentTemperatureLabel.text = viewModel.temperature
        currentHumidityLabel.text = viewModel.humidity
        currentPrecipitationLabel.text = viewModel.precipitationProbablity
        currentSummaryLabel.text = viewModel.summary
        currentWeatherIcon.image = viewModel.icon
    }
    
    func displayPlacemark(with name: String, and city: String) {
        if(name != "" && city != "") {
            currentPlacemark.text = "\(name),\(city)"
        } else {
            currentPlacemark.text = "\(name)"
        }
        
    }
    
    @IBAction func getCurrentWeather() {
        
        toggleRefreshAnimation(on: true)
        
        
        DispatchQueue.main.async {
            self.location.getLocation()
            self.placemark.getPlacemark(coordinate: self.location.coordinate)
        }
    
        client.getCurrentWeather(at: location.coordinate) { [unowned self] currentWeather, error in
            if let currentWeather = currentWeather {
                let viewModel = CurrentWeatherViewModel(model: currentWeather)
                self.displayWeather(using: viewModel)
                self.displayPlacemark(with: self.placemark.name, and: self.placemark.city)
                self.toggleRefreshAnimation(on: false)
            } else if error != nil {
                let alertController = UIAlertController(title: "Error Found", message: error?.getErrorDetail(), preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(action)
                
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    func toggleRefreshAnimation(on: Bool){
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
















