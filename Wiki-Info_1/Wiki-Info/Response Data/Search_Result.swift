//
//  Search_Result.swift
//  Wiki-Info
//
//  Created by Sanket on 30/09/18.
//  Copyright © 2018 Developer Sanket. All rights reserved.
//

import Foundation

struct Search_Result:Decodable {
    let batchcomplete : Bool?
    let `continue` : Continue?
    let query : Query?
}
