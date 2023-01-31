//
//  ViewController.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 22.12.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let dateFormatter = DateFormatter()
    let photoManager = PhotoManager()
    let datesManager = DatesManager()
    var currentSpacePhoto = [Photo]()
    var autoEnabledAlertAction: UIAlertAction?
    var firstMonthPhotos = [Photo]()
    var secondMonthPhotos = [Photo]()
    var thirdMonthPhotos = [Photo]()
    
    @IBOutlet weak var lastThreeMonthButton: UIButton!
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet weak var aboutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lastThreeMonthButton.alpha = 0.5
        lastThreeMonthButton.isEnabled = false
        
        for button in allButtons {
            button.layer.cornerRadius = 8
        }
        aboutButton.layer.borderWidth = 2
        aboutButton.layer.borderColor = UIColor.white.cgColor
        
        let threeMonthsArray = datesManager.getLastThreeMonths()
        updateMonthArrays(dates: threeMonthsArray)
        
    }
    
    @IBAction func todaysPicturePressed(_ sender: UIButton) {
        let today = datesManager.getTodaysDate()
        updateArrayWithTwoDates(startDate: today, endDate: today)
    }
    
    @IBAction func randomPicturePressed(_ sender: Any) {
        let randomDay = datesManager.getRandomDay()
        updateArrayWithTwoDates(startDate: randomDay, endDate: randomDay)
    }
    
    @IBAction func chooseOneDatePressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose a date", message: "Format: YYYY-MM-DD", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let textField = ac.textFields?[0]
            if let date = textField?.text {
                self.updateArrayWithTwoDates(startDate: date, endDate: date)
                print("currentSpacePhoto = \(self.currentSpacePhoto)")
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        autoEnabledAlertAction = ok
        ok.isEnabled = false
        ac.addTextField { textField in
            textField.keyboardType = .numbersAndPunctuation
            textField.addTarget(self, action: #selector(self.checkTextFieldText(_:)), for: .editingChanged)
        }
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    
    @IBAction func lastThreeWeeksPressed(_ sender: UIButton) {
        let date = Date()
        let todayAndThreeWeeksAgo = datesManager.getLastThreeWeeks(forDate: date)
        updateArrayWithTwoDates(startDate: todayAndThreeWeeksAgo[0], endDate: todayAndThreeWeeksAgo[1])
        
    }
    
    @IBAction func lastThreeMonthPressed(_ sender: UIButton) {
        firstMonthPhotos = photoManager.currentPhotoArray[0]
        secondMonthPhotos = photoManager.currentPhotoArray[1]
        thirdMonthPhotos = photoManager.currentPhotoArray[2]
    
        performSegue(withIdentifier: "ShowMonths", sender: self)
    }
    
    @IBAction func randomSetPressed(_ sender: UIButton) {
        let randomDateData = datesManager.getRandomDay()
        print("RANDOM DATE = \(randomDateData)")
        dateFormatter.dateFormat = "YYYY-MM-DD"
        if let randomDate = dateFormatter.date(from: randomDateData) {
            let randomThreeWeeks = datesManager.getLastThreeWeeks(forDate: randomDate)
            updateArrayWithTwoDates(startDate: randomThreeWeeks[0], endDate: randomThreeWeeks[1])
        }
    }
    
    @IBAction func chooseDatesPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Choose dates", message: "Format: YYYY-MM-DD", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            let fromTextField = ac.textFields?[0]
            let tillTextField = ac.textFields?[1]
            if let dateFrom = fromTextField?.text {
                if let dateTill = tillTextField?.text {
                    guard self.dateFormatter.date(from: dateFrom)! < self.dateFormatter.date(from: dateTill)! else {
                        return
                    }
                    self.updateArrayWithTwoDates(startDate: dateFrom, endDate: dateTill)
                    print("currentSpacePhoto = \(self.currentSpacePhoto)")
                }
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        autoEnabledAlertAction = ok
        ok.isEnabled = false
        ac.addTextField { textField in
            textField.keyboardType = .numbersAndPunctuation
            textField.addTarget(self, action: #selector(self.checkTextFieldText(_:)), for: .editingChanged)
        }
        ac.addTextField { textField in
            textField.keyboardType = .numbersAndPunctuation
            textField.addTarget(self, action: #selector(self.checkTextFieldText(_:)), for: .editingChanged)
        }
        ac.addAction(ok)
        ac.addAction(cancel)
        present(ac, animated: true)
    }
    func updateMonthArrays(dates: [[String]]) {
        photoManager.fetchMultiplePhotos(forDates: dates)
        photoManager.onCompletionMonth = {
            self.lastThreeMonthButton.alpha = 1.0
            self.lastThreeMonthButton.isEnabled = true
        }
    }
    
    func updateArrayWithSetOfPhotos(startDate: String, endDate: String, monthArray: Int) {
        photoManager.fetchPhotos(forStartDate: startDate, andEndDate: endDate)
        photoManager.onCompletion = { [weak self] currentPhoto in
            guard let self = self else {  print("Can't update array"); return }
            switch monthArray {
            case 1:
                self.firstMonthPhotos = currentPhoto
                print(" current = \(currentPhoto.count)")
                print(self.firstMonthPhotos.count)
            case 2:
                self.secondMonthPhotos = currentPhoto
                print(" current = \(currentPhoto.count)")
                print(self.secondMonthPhotos.count)
            case 3:
                self.thirdMonthPhotos = currentPhoto
                print(" current = \(currentPhoto.count)")
                print(self.thirdMonthPhotos.count)
            default:
                return
            }
        }
    }
    
    func updateArrayWithTwoDates(startDate: String, endDate: String) {
        photoManager.fetchPhotos(forStartDate: startDate, andEndDate: endDate)
        //print("Photo array = \(self.photoManager.photosArray)")
        photoManager.onCompletion = { [weak self] currentPhoto in
            guard let self = self else {  print("Can't update array"); return }
            self.currentSpacePhoto = currentPhoto
            //  print("UPDATE currentSpacePhoto = \(self.currentSpacePhoto)")
            if startDate == endDate {
                self.performSegue(withIdentifier: "ShowDetail", sender: self)
            } else {
                self.performSegue(withIdentifier: "ShowPhotoCollection", sender: self)
            }
        }
    }
    
    @objc func checkTextFieldText(_ textField: UITextField) {
        dateFormatter.dateFormat = "YYYY-MM-DD"
        if let _ = dateFormatter.date(from: textField.text ?? "no date") {
            if textField.text! < datesManager.getTodaysDate() && textField.text! > "1995-06-16"{
                autoEnabledAlertAction?.isEnabled = true
            }
        } else {
            autoEnabledAlertAction?.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let destinationVC = segue.destination as? DetailsViewController {
                destinationVC.nameLabel = currentSpacePhoto[0].title
                destinationVC.dateLabel = currentSpacePhoto[0].date
                destinationVC.photoDescription = currentSpacePhoto[0].description
                destinationVC.spaceImageString = currentSpacePhoto[0].photoUrl
                
            }
        } else if segue.identifier == "ShowMonths" {
            if let destinationVC = segue.destination as? MonthsViewController {
                guard !firstMonthPhotos.isEmpty else { return }
                guard !secondMonthPhotos.isEmpty else { return }
                guard !thirdMonthPhotos.isEmpty else { return }
                
                destinationVC.firstMonthPhotosArray = firstMonthPhotos
                destinationVC.secondMonthPhotosArray = secondMonthPhotos
                destinationVC.thirdMonthPhotosArray = thirdMonthPhotos
                destinationVC.firstMonthName = datesManager.shortenDateToMonth(dateString: firstMonthPhotos[0].date ?? "No date")
                destinationVC.secondMonthName = datesManager.shortenDateToMonth(dateString: secondMonthPhotos[0].date ?? "No date")
                destinationVC.thirdMonthName = datesManager.shortenDateToMonth(dateString: thirdMonthPhotos[0].date ?? "No date")
            }
        } else if segue.identifier == "ShowPhotoCollection" {
            if let destinationVC = segue.destination as? PhotoCollectionViewController {
                destinationVC.photos = currentSpacePhoto
            }
        }
    }
}
