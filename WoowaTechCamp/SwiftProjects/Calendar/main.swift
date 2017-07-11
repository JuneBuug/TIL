//
//  main.swift
//  calendarExample
//
//  Created by woowabrothers on 2017. 7. 11..
//  Copyright © 2017년 woowabrothers. All rights reserved.
//

import Foundation


let testCalendar = MyCalendar()


let todayDate = testCalendar.getTodayInNumber()


print("현재는 \(todayDate.year) 년 \(todayDate.month) 월 \(todayDate.day) 일, \(todayDate.hour) 시 \(todayDate.minute) 분  \(todayDate.second) 초 입니다. ")

print(testCalendar.getDatefromString(yearMonthDay: "2016/04/16"))

let test = testCalendar.getDatefromInt(year: 1998, month: 12, day: 25)

print(test)

print(testCalendar.getKoreanDatefromDate(inputDate: test))

print(testCalendar.getFirstDayWeekDay(year: 2010, month: 1))

print(testCalendar.getCalendarFromYearMonth(year: 2010, month: 4))
