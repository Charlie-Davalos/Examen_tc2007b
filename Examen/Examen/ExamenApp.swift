//
//  ExamenApp.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import SwiftUI
import SwiftData

@main
struct ExamenApp: App {
    @StateObject private var viewModel = CovidViewModel()  // Inicializamos el ViewModel aquí

    var body: some Scene {
        WindowGroup {
            CovidView(viewModel: viewModel)  // Pasamos el ViewModel a la vista
        }
    }
}
