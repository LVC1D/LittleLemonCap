//
//  MenuItem.swift
//  LittleLemonCap
//
//  Created by Illia Berezovskyi on 16/10/2023.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    var id = UUID()
    let title: String
    let image: String
    let price: String
    let category: String
}

