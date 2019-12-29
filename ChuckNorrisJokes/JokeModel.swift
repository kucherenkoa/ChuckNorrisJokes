//
//  JokeModel.swift
//  ChuckNorrisJokes
//
//  Created by Andrei Kucherenko on 29.12.2019.
//  Copyright © 2019 Andrei Kucherenko. All rights reserved.
//

import Foundation

struct JokesResponse: Decodable {
    let type: String
    let value: [JokeModel]
}

struct  JokeModel: Decodable {
    let id: Int
    let joke: String
    let categories: [String]
}
