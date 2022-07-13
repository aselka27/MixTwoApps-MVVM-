//
//  TaskViewModel.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import Foundation

protocol TaskViewModelProtocol {
    var task: [TaskModel] {get set}
}

class TaskViewModel: TaskViewModelProtocol {
    var task: [TaskModel] = [
        TaskModel(taskName: "Задача1", taskDescription: "Подзадача1", isClicked: false),
        TaskModel(taskName: "Задача2", taskDescription: "Подзадача2", isClicked: false),
        TaskModel(taskName: "Задача3", taskDescription: "Подзадача3", isClicked: false)
    ]
}

