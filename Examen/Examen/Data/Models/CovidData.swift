//
//  CovidData.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import Foundation

/// Representa la estructura de los datos de COVID recibidos de la API
struct CovidData: Decodable {
    let country: String
    let region: String
    let cases: [String: CaseData] // Diccionario con fechas como claves
}

/// Detalle de casos en una fecha específica
struct CaseData: Decodable {
    let total: Int
    let new: Int
}
