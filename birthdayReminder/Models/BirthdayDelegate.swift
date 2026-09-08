//
//  BirthdayDelegate.swift
//  birthdayReminder
//

import Foundation

protocol BirthdayDelegate: AnyObject {
    func didAddBirthday(_ birthday: Birthday)
}
