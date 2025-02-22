//
//  User.swift
//  SwiftBot
//
//  Created by Mark on 2/22/25.
//

import Foundation

struct User: Codable {
    let id: Int
    let is_bot: Bool
    let first_name: String
    let last_name: String?
}
