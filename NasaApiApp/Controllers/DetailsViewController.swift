//
//  DetailsViewController.swift
//  NasaApiApp
//
//  Created by Gosha Bondarev on 24.12.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailDescriptionTextView: UITextView!
    
    
    var photoManager = PhotoManager()
    var nameLabel: String?
    var dateLabel: String?
    var spaceImageString: String?
    var photoDescription: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let spaceImageString = spaceImageString {
            detailImageView.setImageFrom(spaceImageString)
        }
        detailDateLabel.text = dateLabel
        detailNameLabel.text = nameLabel
        detailDescriptionTextView.text = photoDescription

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

