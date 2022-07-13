//
//  DetailViewModel.swift
//  MixTwoApps(MVVM)
//
//  Created by саргашкаева on 13.07.2022.
//

import Foundation

protocol DetailViewModelProtocol {
   
    var task: TaskModel? {get set}
    var descText: String {get set}
}

class DetailViewModel: DetailViewModelProtocol {
    
    var task: TaskModel?
    var descText: String = "Описание"
}
