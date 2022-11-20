//
//  ViewController.swift
//  RadioFrance
//
//  Created by Loic D on 17/11/2022.
//

import UIKit
import SwiftUI

class ViewController: UITableViewController {
    
    let radioStationVM = RadioStationListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioStationVM.loadRadioStationsList {
            self.tableView.reloadData()
        }
    }
}

extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return radioStationVM.stations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RadioStationTableViewCell
        let station = radioStationVM.stations[indexPath.row]
        cell.titleLabel.text = station.stationName
        cell.subtitleLabel.text = station.stationDescription
        cell.imageLogo.image = UIImage(named: station.stationImageName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = radioStationVM.stations[indexPath.row]
        
        let stationView = RadioStationView(station: station).environmentObject(radioStationVM)
        present(UIHostingController(rootView: stationView), animated: true)
    }
}
