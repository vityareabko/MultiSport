//
//  getApiKey.swift
//  MultiSport
//
//  Created by Витя Рябко on 13/04/23.
//

import Foundation


func getApiKey() -> [String:String] {
    let headers = [
        "X-RapidAPI-Key": "f8eab9684dmsh800d7d7caeb90fap1a653ajsn3ee17faa2cfe",
        "X-RapidAPI-Host": "api-football-v1.p.rapidapi.com"  
    ]
    
    return headers
}

