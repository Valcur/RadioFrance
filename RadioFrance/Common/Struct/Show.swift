//
//  Emission.swift
//  RadioFrance
//
//  Created by Loic D on 15/11/2022.
//

import Foundation

// Une émission d'une station de radio
struct Show: Identifiable {
    let id = UUID()
    let showName: String
    let episodes: [Episode]
    let cursor: String
}
