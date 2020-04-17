//
//  RandomColor.swift
//  drawView
//
//  Created by Tsering Lama on 4/16/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

extension UIColor {
  static func random () -> UIColor {
    return UIColor(
      red: CGFloat.random(in: 0...1),
      green: CGFloat.random(in: 0...1),
      blue: CGFloat.random(in: 0...1),
      alpha: 1.0)
  }
}
