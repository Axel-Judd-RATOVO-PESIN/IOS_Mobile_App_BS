//
//  ProfileViewModel.swift
//  project_test_ios
//
//  Created by RATOVO PESIN Axel Judd on 03/11/2025.
//

import Observation
import DeveloperToolsSupport

@Observable
class ProfileViewModel {
    var nom: String = "OBBER"
    var prenom: String = "Clint"
    var image: ImageResource = .image
    var desc: String = ""
    
    init() {
        self.desc = "My name is \(nom) \(prenom), I'm a software engineer."
    }
}
