//
//  Activity1Cell.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//
import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func textFieldChanged(cell: Activity1Cell, activity: Activity, text: String)
    
}

class Activity1Cell: UICollectionViewCell {
    
    @IBOutlet weak var personifiedItemImageView: UIImageView!
    
    @IBOutlet weak var itemNameTextField: UITextField!
    
    @IBOutlet weak var personLabel: UILabel!
    
    public weak var delegate: CollectionViewCellDelegate?
    
    public var activity: Activity?
    
    public func configureCell(for activity: Activity){
        
        if let imageData = activity.imageData {
            personifiedItemImageView.image = UIImage(data: imageData)
        }
        
        self.activity = activity
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemNameTextField.delegate = self
    }
    
}

extension Activity1Cell: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty, let selectedActivity = activity else {
            textField.resignFirstResponder()
            return false
        }
        
        personLabel.text = text
        delegate?.textFieldChanged(cell: self, activity: selectedActivity, text: text)
        
        return true
    }
}



