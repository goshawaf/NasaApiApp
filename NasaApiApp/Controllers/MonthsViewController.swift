//
//  MonthsViewController.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 24.12.2022.
//

import UIKit

class MonthsViewController: UIViewController {
    
    @IBOutlet weak var firstMonthCollection: UICollectionView!
    @IBOutlet weak var secondMonthCollection: UICollectionView!
    @IBOutlet weak var thirdMonthCollection: UICollectionView!
    
    @IBOutlet weak var firstMonthLabel: UILabel!
    @IBOutlet weak var secondMonthLabel: UILabel!
    @IBOutlet weak var thirdMonthLabel: UILabel!
    
    var firstMonthName = ""
    var secondMonthName = ""
    var thirdMonthName = ""
    var firstMonthPhotosArray = [Photo]()
    var secondMonthPhotosArray = [Photo]()
    var thirdMonthPhotosArray = [Photo]()
    let photoManager = PhotoManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstMonthCollection.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        secondMonthCollection.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        thirdMonthCollection.register(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCell")
        
        firstMonthLabel.text = firstMonthName
        secondMonthLabel.text = secondMonthName
        thirdMonthLabel.text = thirdMonthName
        
        firstMonthCollection.dataSource = self
        firstMonthCollection.delegate = self
        secondMonthCollection.dataSource = self
        secondMonthCollection.delegate = self
        thirdMonthCollection.dataSource = self
        thirdMonthCollection.delegate = self
        
        
        //print("FIRSTMONTHARRAY = \(firstMonthPhotosArray)")
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let photoVC = segue.destination as? DetailsViewController {
                if let selectedPhoto = sender as? Photo {
                    photoVC.nameLabel = selectedPhoto.title
                    photoVC.dateLabel = selectedPhoto.date
                    photoVC.photoDescription = selectedPhoto.description
                    photoVC.spaceImageString = selectedPhoto.photoUrl
                }
            }
        }
    }
}

//MARK: - Extensions

extension MonthsViewController: UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstMonthCollection {
            return firstMonthPhotosArray.count
        } else if collectionView == secondMonthCollection {
            return firstMonthPhotosArray.count
        } else if collectionView == thirdMonthCollection {
            return firstMonthPhotosArray.count
        } else { return 0 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstMonthCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            if let spaceImageString = firstMonthPhotosArray[indexPath.row].photoUrl {
                photoManager.getImage(urlImage: spaceImageString) { (result) in
                    switch result {
                    case .success(let data):
                        cell.monthPhoto.image = UIImage(data: data)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return cell
        } else if collectionView == secondMonthCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            if let spaceImageString = secondMonthPhotosArray[indexPath.row].photoUrl {
                photoManager.getImage(urlImage: spaceImageString) { (result) in
                    switch result {
                    case .success(let data):
                        cell.monthPhoto.image = UIImage(data: data)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return cell
        } else if collectionView == thirdMonthCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
            if let spaceImageString = thirdMonthPhotosArray[indexPath.row].photoUrl {
                photoManager.getImage(urlImage: spaceImageString) { (result) in
                    switch result {
                    case .success(let data):
                        cell.monthPhoto.image = UIImage(data: data)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            return cell
        }
        
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstMonthCollection {
            let selectedPhoto = firstMonthPhotosArray[indexPath.row]
            self.performSegue(withIdentifier: "ShowDetail", sender: selectedPhoto)
        } else if collectionView == secondMonthCollection {
            let selectedPhoto = secondMonthPhotosArray[indexPath.row]
            self.performSegue(withIdentifier: "ShowDetail", sender: selectedPhoto)
        } else if collectionView == thirdMonthCollection {
            let selectedPhoto = thirdMonthPhotosArray[indexPath.row]
            self.performSegue(withIdentifier: "ShowDetail", sender: selectedPhoto)
        }
    }
}

extension MonthsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 128, height: 128)
    }
}

