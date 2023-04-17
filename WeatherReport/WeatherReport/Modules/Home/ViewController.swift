//
//  ViewController.swift
//  WeatherReport
//
//  Created by Harish Kumar on 15/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textFieldCity : UITextField!
    @IBOutlet weak var tableViewCity : UITableView!
    @IBOutlet weak var imageViewWeather : UIImageView!
    @IBOutlet weak var heightConstraintTableView: NSLayoutConstraint!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherTempMax: UILabel!
    @IBOutlet weak var weatherTempMin: UILabel!
    @IBOutlet weak var weatherHumidity: UILabel!
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!

    // Bool: for hide and show dropdown
    private var isDropDown: Bool = false

    private var weatherViewModel : WeatherViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialUI()
        callToViewModelForUIUpdate()
        fetchPreviousLocationData()
    }
    
    private func setUpInitialUI() {
        heightConstraintTableView.constant = 0
        customTableView()
    }
    
    private func customTableView() {
        self.tableViewCity.register(UINib(nibName: Constants.CellIdentifier.cityTableViewCell,
                                          bundle: nil),
                                    forCellReuseIdentifier: Constants.CellIdentifier.cityTableViewCell)
    }
    
    private func callToViewModelForUIUpdate() {
        self.weatherViewModel =  WeatherViewModel()
        self.weatherViewModel.bindWeatherViewModelToController = {
            self.updateDataSource()
        }
    }
    
    // Updating UI after get selected location data from weather api
    private func updateDataSource() {

        updateWeatherImage()
        
        // Updating UI on main thread
        DispatchQueue.main.async { [weak self] in
            self?.weatherDescription.text = self?.weatherViewModel.weatherData.weather?.first?.description ?? Constants.emptyString
            self?.weatherTempMin.text =  String(self?.weatherViewModel.weatherData.main?.tempMin ?? 0.00)
            self?.weatherTempMax.text = String(self?.weatherViewModel.weatherData.main?.tempMax ?? 0.00)
            self?.weatherHumidity.text = String(self?.weatherViewModel.weatherData.main?.humidity ?? 0)
            self?.latitude.text = String(self?.weatherViewModel.weatherData.coord?.lat ?? 0.00)
            self?.longitude.text = String(self?.weatherViewModel.weatherData.coord?.lon ?? 0.00)
            self?.tableViewCity.reloadData()
        }
    }
    
    @IBAction func showDropDown() {
        isDropDown = !isDropDown
        heightConstraintTableView.constant = isDropDown ? 200 : 0
    }
}

// MARK:  - Extension - ViewController Methods
private extension ViewController {
    
    // Fetch and Show weather image
    private func updateWeatherImage() {
        if let url = URL(string: Constants.Url.baseUrlImage + (self.weatherViewModel.weatherData.weather?.first?.icon ?? Constants.emptyString) + Constants.imageExtension) {
            imageViewWeather.downloadImage(from: url)
        }
    }
    
    // Fetch previous selected data on next launch
    // Fetching data from UserDefaults
    private func fetchPreviousLocationData() {
        guard let city = UserDefaults.standard.string(forKey: Constants.UserDefaults.selectedCity) else { return }
        textFieldCity.text = city
        self.weatherViewModel.getCityWeatherData(city: city)
    }
}

// MARK:  - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherViewModel.getCityList().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        getCityTableViewCell(indexPath: indexPath)
    }
    
    func getCityTableViewCell(indexPath: IndexPath) -> CityTableViewCell {
        let cell = tableViewCity.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.cityTableViewCell,
                                                     for: indexPath) as! CityTableViewCell
        let city = self.weatherViewModel.getCityList()[indexPath.row]
        cell.updateUI(city: city)
        return cell
    }
}

// MARK:  - UITableViewDelegates
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // selected city from dropdown
        let selectedCity = self.weatherViewModel.getCityList()[indexPath.row]
        
        // Saving selected city in UserDefaults
        // We will show this city on next app launch
        UserDefaults.standard.set(selectedCity, forKey: Constants.UserDefaults.selectedCity)
        
        // Showing selected city into textfield
        textFieldCity.text = selectedCity
        
        // Weather api calling based on selected city
        self.weatherViewModel.getCityWeatherData(city: selectedCity)
        
        isDropDown = false // Assigning default value to isDropDown
        
        // tableView height constant value 0
        // for hide dropdown after select city
        heightConstraintTableView.constant = 0
    }
}
