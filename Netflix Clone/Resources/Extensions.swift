//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Memo Figueredo on 28/1/26.
//

import UIKit

extension String {
  func capitalizeFirstLetter() -> String {
    return self.prefix(1).uppercased() + self.lowercased().dropFirst()
  }
}
