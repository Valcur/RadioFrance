//
//  Episode.swift
//  RadioFrance
//
//  Created by Loic D on 19/11/2022.
//

import Foundation

// Un épisode d'une émission
struct Episode: Identifiable {
    let id = UUID()
    let title: String
}
