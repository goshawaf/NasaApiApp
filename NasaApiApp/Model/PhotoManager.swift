//
//  PhotoManager.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 24.12.2022.
//

import Foundation

class PhotoManager {
    
    var onCompletion: (([Photo]) -> Void)?
    var onCompletionMonth: (() -> Void)?
    var photosArray = [Photo]()
    var currentPhotoArray: [[Photo]] = []
    
    func fetchMultiplePhotos(forDates dates: [[String]]) {
        var urlStringArray: [String] = []
        var urlArray: [URL] = []
        
        for date in dates {
            urlStringArray.append("https://api.nasa.gov/planetary/apod?api_key=R2diLGayDwGF85Swb8R8hSZ8vi2Ctb4hETyZ1MFV&start_date=\(date[0])&end_date=\(date[1])")
        }
        for urlString in urlStringArray {
            guard let url = URL(string: urlString) else { return }
            urlArray.append(url)
        }
    
        let session = URLSession(configuration: .default)
        for url in urlArray {
            let task = session.dataTask(with: url) { data, response, error in
                DispatchQueue.main.async {
                    if let data = data {
                        if let currentPhoto = self.parceJSON(forData: data) {
                            self.currentPhotoArray.append(currentPhoto)
                            self.onCompletionMonth?()
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchPhotos(forStartDate startDate: String, andEndDate endDate: String) {
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=R2diLGayDwGF85Swb8R8hSZ8vi2Ctb4hETyZ1MFV&start_date=\(startDate)&end_date=\(endDate)"
        guard let url = URL(string: urlString) else { return }
        print(url)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    if let currentPhoto = self.parceJSON(forData: data) {
                        self.onCompletion?(currentPhoto)
                    }
                }
            }
        }
        task.resume()
    }
    
    fileprivate func parceJSON(forData data: Data) -> [Photo]? {
        photosArray = []
        let decoder = JSONDecoder()
        do {
            let currentPhotoData = try decoder.decode(PhotoSetData.self, from: data)
            //print("currentPhotoData = \(currentPhotoData)")
            for singlePhoto in currentPhotoData {
                guard let photo = Photo(photoData: singlePhoto)
                else {
                    print("Problem with decoding data!")
                    return nil
                }
                photosArray.append(photo)
            }
            return photosArray
        } catch let error as NSError {
            print(error)
        }
        return nil
    }
    
    func getImage(urlImage: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageURL = URL(string: urlImage) else { return }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: imageURL) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
            
        }
        task.resume()
    }
    
    
}
