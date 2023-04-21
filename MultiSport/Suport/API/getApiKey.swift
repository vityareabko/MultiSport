//
//  getApiKey.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation


func getApiKey() -> [String:String] {
    let headers = [
        "X-RapidAPI-Key": "d174b7ef2dmshff1c00ea363fbb3p1249d0jsne1d8d72fd173",
        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"  
    ]
    
    return headers
}

