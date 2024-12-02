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
    let cases: [String: CaseData]  // Diccionario de fechas con los datos de casos
}

/// Detalle de casos en una fecha específica
struct CaseData: Decodable {
    let total: Int
    let new: Int
}
