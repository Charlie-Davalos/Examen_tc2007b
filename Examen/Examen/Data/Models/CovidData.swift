//
//  CovidData.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation

struct CovidData: Decodable {
    let country: String
    let region: String
    let cases: [String: CaseData] // Diccionario con las fechas como claves
}

struct CaseData: Decodable {
    let total: Int
    let new: Int
}
