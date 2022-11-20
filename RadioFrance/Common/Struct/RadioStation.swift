//
//  RadioStation.swift
//  RadioFrance
//
//  Created by Loic D on 15/11/2022.
//

import Foundation

// Une station de radio
class RadioStation: Identifiable, ObservableObject {
    let id = UUID()
    let stationId: String
    let stationName: String
    let stationDescription: String
    let stationImageName: String
    @Published var shows: [Show]
    
    init(stationId: String, stationName: String, stationDescription: String, stationImageName: String, shows: [Show] = []) {
        self.stationId = stationId
        self.stationName = stationName
        self.stationDescription = stationDescription
        self.stationImageName = stationImageName
        self.shows = shows
    }
}
