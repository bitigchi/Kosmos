//
//  Photo.swift
//  Kosmos
//
//  Created by Emir SARI on 4.10.2019.
//  Copyright © 2019 Emir SARI. All rights reserved.
//

import Foundation

struct Photo: Codable {
    var id = UUID()
    var title: String
    var date: Date
    var explanation: String
    var hdurl: String
}
