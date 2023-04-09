//
//  TeamModel.swift
//  MultiSport
//
//  Created by Витя Рябко on 09/04/23.
//


import UIKit

struct TeamModel {
    let teamName: String
    let teamLogo: UIImage?
    
    static func createData() -> [TeamModel] {
        let a1 = TeamModel(teamName: "Peters", teamLogo: UIImage(named: "team1"))
        let a2 = TeamModel(teamName: "Peters", teamLogo: UIImage(named: "team2"))
        let a3 = TeamModel(teamName: "Peters", teamLogo: UIImage(named: "team3"))
        let a4 = TeamModel(teamName: "Peters", teamLogo: UIImage(named: "team4"))
        let a5 = TeamModel(teamName: "Peters", teamLogo: UIImage(named: "team5"))
        let a6 = TeamModel(teamName: "Peters", teamLogo: UIImage(named: "team6"))
        return [a1,a2,a3,a4,a5,a6,a2,a3,a4,a5,a6]
    }
}
