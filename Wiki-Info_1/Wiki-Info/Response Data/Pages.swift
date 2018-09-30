//
//  Pages.swift
//  Wiki-Info
//
//  Created by Sanket on 30/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import Foundation
struct Pages : Decodable {
    let pageid : Int?
    let ns : Int?
    let title : String?
    let index : Int?
    let thumbnail : Thumbnail?
    let terms : Terms?

}
