//
//  Message.swift
//  SwiftBot
//
//  Created by Mark on 2/22/25.
//

import Foundation

struct Message: Codable {
    let message_id: Int
    let from: User
    let text: String?
}
