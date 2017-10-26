//
//  Player.swift
//  Ratings
//
//  Created by tibin on 16/03/17.
//  Copyright © 2017 tibin. All rights reserved.
//




struct Player {
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int) {
        self.name = name
        self.game = game
        self.rating = rating
    }
}