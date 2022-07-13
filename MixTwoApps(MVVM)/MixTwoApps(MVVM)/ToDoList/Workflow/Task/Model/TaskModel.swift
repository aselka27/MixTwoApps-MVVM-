//
//  TaskModel.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import Foundation

class TaskModel {
    var taskName: String = ""
    var taskDescription: String
    var isClicked: Bool
    
    init(taskName: String, taskDescription: String, isClicked: Bool) {
        self.taskName = taskName
        self.taskDescription = taskDescription
        self.isClicked = isClicked
    }
}

extension TaskModel: Equatable {
    static func == (lhs: TaskModel, rhs: TaskModel) -> Bool {
        lhs.isClicked == rhs.isClicked &&
        lhs.taskName == rhs.taskName &&
        lhs.taskDescription == rhs.taskDescription
    }
}
