//
//  Stadium.swift
//  MLB
//
//  Created by Avery Merlo on 4/23/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Stadium: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
    var builtIn = ""
    var capacity = ""
    var city = ""
    var state = ""
    var priceOfBeer = 0
    var team = ""
    var image = ""
    var left = 0
    var center = 0
    var right = 0
    var longestHR = ""
    
    var dictionary: [String: Any] {
        return ["name": name, "address": address, "builtIn": builtIn, "capacity": capacity, "city": city, "state": state, "priceOfBeer": priceOfBeer, "team": team, "image": image, "left": left, "center": center, "right": right, "longestHR": longestHR]
    }
}
