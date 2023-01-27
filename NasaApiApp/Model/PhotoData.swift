//
//  PhotoData.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 24.12.2022.
//

import Foundation

struct PhotoData: Codable {
    let date: String?
    let explanation: String?
    let title: String?
    let url: String?
}

typealias PhotoSetData = [PhotoData]
