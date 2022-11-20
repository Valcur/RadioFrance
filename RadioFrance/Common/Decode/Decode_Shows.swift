//
//  Shows.swift
//  RadioFrance
//
//  Created by Loic D on 15/11/2022.
//

import Foundation

struct Decode_Shows: Codable {
    let data: DataClass
    
    struct DataClass: Codable {
        let shows: Shows
    }

    struct Shows: Codable {
        let edges: [ShowsEdge]
    }

    struct ShowsEdge: Codable {
        let cursor: String
        let node: Node
    }

    struct Node: Codable {
        let id, title: String
        let diffusionsConnection: DiffusionsConnection
    }

    struct DiffusionsConnection: Codable {
        let edges: [DiffusionsConnectionEdge]
    }

    struct DiffusionsConnectionEdge: Codable {
        let node: DiffusionsConnectionNode
    }

    struct DiffusionsConnectionNode: Codable {
        let title: String
    }
}

