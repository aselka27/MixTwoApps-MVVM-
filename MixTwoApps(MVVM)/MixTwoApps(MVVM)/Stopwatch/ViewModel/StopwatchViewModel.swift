//
//  StopwatchViewModel.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import Foundation

protocol StopwatchViewModelProtocol {
    var seconds: Int { get set }
    var minutes: Int { get set }
    var hours: Int { get set }
    var isRunning: Bool { get set }
    var counter: Int { get set }
    var timer: Timer { get set }
    
    func getHour(hour: Int) -> String
    func getMinute(minute: Int) -> String
    func getSecond(second:Int) -> String
    func getTime(hour:Int, minute: Int, second: Int) -> String
    func timerRun()
    func setRow(component: Int, row: Int)
}

class StopwatchViewModel: StopwatchViewModelProtocol {
    var seconds = 0
    var minutes = 0
    var hours = 0
    var isRunning = false
    var counter = 0
    var timer = Timer()
    
    func getHour(hour: Int) -> String {
        hours = hour
        hours = counter / 3600
        var hourString = "\(hours)"
        if (hours < 10) {
            hourString = "0\(hours)"
        }
        return hourString
    }
    
    func getMinute(minute: Int) -> String {
        minutes = minute
        minutes = (counter % 3600) / 60
        var minuteString = "\(minutes)"
        if (minutes < 10) {
            minuteString = "0\(minutes)"
        }
        return minuteString
    }
    
    func getSecond(second:Int) -> String {
        seconds = second
        seconds = (counter % 3600) % 60
        var secondString = "\(seconds)"
        if (seconds < 10) {
            secondString = "0\(seconds)"
        }
        return secondString
    }
    
    func getTime(hour:Int, minute: Int, second: Int) -> String {
        let h = getHour(hour: hours)
        let m = getMinute(minute: minutes)
        let s = getSecond(second: seconds)
        return "\(h):\(m):\(s)"
    }
    
    func timerRun() {
        if seconds == 0 && minutes != 0 {
            minutes -= 1
            seconds = 59
        } else if minutes == 0 && hours != 0 {
            hours -= 1
            minutes = 59
            seconds = 59
        } else if minutes == 0 && hours == 0 && seconds == 0 {
            timer.invalidate()
            
        } else {
            seconds -= 1
        }
    }
    
    func setRow(component: Int, row: Int) {
        if component == 0{
            hours = row
        } else if component == 1 {
            minutes = row
        } else {
            seconds = row + 1
        }
    }
}
