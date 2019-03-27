//
//  Date+Format.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/6.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import Foundation

private let dateFormat = DateFormatter()

extension Date {
    func st_format(_ formatString: String) -> String {
        dateFormat.dateFormat = formatString
        return dateFormat.string(from: self)
    }
}
