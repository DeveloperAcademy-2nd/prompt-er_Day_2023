//
//  Message.swift
//  WhyFine
//
//  Created by 차차 on 2023/09/03.
//

import Foundation

struct Message: Decodable {
    let id: UUID
    let role: Role
    let content: String
}
