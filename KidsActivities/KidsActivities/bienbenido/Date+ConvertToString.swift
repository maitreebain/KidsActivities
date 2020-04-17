//
//  Date+ConvertToString.swift
//  Test
//
//  Created by Bienbenido Angeles on 4/16/20.
//  Copyright © 2020 Bienbenido Angeles. All rights reserved.
//

import Foundation

extension Date{
    
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "EEEE, MM/dd/yyyy HH:mm"
        
        return dateFormatter.string(from: self)
    }
}
