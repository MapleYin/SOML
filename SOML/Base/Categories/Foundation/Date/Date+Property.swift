//
//  Date+Property.swift
//  SOML
//
//  Created by Maple Yin on 2019/1/5.
//  Copyright © 2019 Maple.im. All rights reserved.
//

import Foundation

private let calendar = Calendar.autoupdatingCurrent
private let dateComponent: Set<Calendar.Component> = [.year, .month, .day, .weekday, .weekOfMonth, .weekOfYear, .hour, .minute, .second]
private let weekName = ["周一"]

extension Date {
    var st_hour: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.hour!
    }
    
    var st_minute: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.minute!
    }
    
    var st_second: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.second!
    }
    
    var st_day: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.day!
    }
    
    var st_month: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.month!
    }
    
    var st_weekday: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.weekday!
    }
    
    var st_weekYear: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.weekOfYear!
    }
    
    var st_year: Int {
        let components = calendar.dateComponents(dateComponent, from: self)
        return components.year!
    }
    
    var st_weekdayDescribe: String {
        
        return ""
    }
}
