//
//  Photo.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 24.12.2022.
//

import Foundation

struct PhotoSet: Codable {
    let data: [Photo]
}

struct Photo: Codable {
    
    let title: String?
    let date: String?
    let description: String?
    let photoUrl: String?
  
    init?(photoData: PhotoData) {
        
        if let titleData = photoData.title {
            title = titleData
        } else { title = nil }
        if let dateData = photoData.date {
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "yyyy-MM-dd"
            let dateToFormat = dateformatter.date(from: dateData)
            dateformatter.dateFormat = "MMMM d, yyyy"
            dateformatter.locale = Locale(identifier: "en_us")
            date = dateformatter.string(from: dateToFormat!)
        } else { date = nil}
        if let descriptionData = photoData.explanation {
            description = descriptionData
        } else { description = nil}
        if let photoUrlString = photoData.url {
            photoUrl = photoUrlString
        } else { photoUrl = nil }
    }
    
}


//
//init?(photoData: PhotoSetData) {
//    var tempTitleArray: [String] = []
//    var tempDateArray: [String] = []
//    var tempDescriptionArray: [String] = []
//    var tempPhotoUrlArray: [String] = []
//    for photo in photoData {
//        if let photoTitle = photo.title {
//            tempTitleArray.append(photoTitle)
//        }
//        if let photoDate = photo.date {
//            tempDateArray.append(photoDate)
//        }
//        if let photoDescription = photo.explanation {
//            tempDescriptionArray.append(photoDescription)
//        }
//        if let photoUrl = photo.url {
//            tempPhotoUrlArray.append(photoUrl)
//        }
//    }
//    titleArray = tempTitleArray
//    dateArray = tempDateArray
//    descriptionArray = tempDescriptionArray
//    photoUrlArray = tempPhotoUrlArray
