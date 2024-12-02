//
//  CovidView.swift
//  Examen
//
//  Created by Carlos Octavio Dávalos Batres on 25/11/24.
//

import SwiftUI

struct CovidView: View {
    @ObservedObject var viewModel: CovidViewModel
    @State private var selectedCountry: String?

    var body: some View {
        NavigationView {
            ZStack {
                // Imagen de fondo
                Image("covid_background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.3) // Reducimos la opacidad para que el contenido sea más visible

                VStack {
                    if viewModel.covidData.isEmpty {
                        ProgressView("Cargando datos...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .padding()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(12)
                    } else {
                        ScrollView {
                            VStack(spacing: 15) {
                                ForEach(viewModel.covidData.sorted(by: { $0.country < $1.country }), id: \.country) { covidData in
                                    NavigationLink(
                                        destination: CountryDetailsView(country: covidData.country, cases: covidData.cases),
                                        tag: covidData.country,
                                        selection: $selectedCountry
                                    ) {
                                        HStack {
                                            // Bandera del país
                                            Text(countryFlagEmoji(for: covidData.country))
                                                .font(.system(size: 30)) // Tamaño de la bandera

                                            // Nombre del país
                                            Text(covidData.country)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                                .padding(.leading, 10)
                                        }
                                        .padding()
                                        .frame(maxWidth: 300) // Limitar el ancho de las filas
                                        .background(LinearGradient(
                                            colors: [Color.blue, Color.purple],
                                            startPoint: .leading,
                                            endPoint: .trailing)
                                        )
                                        .cornerRadius(12)
                                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            .padding(.vertical)
                        }
                    }
                }
            }
            .onAppear {
                viewModel.loadCovidData()
            }
            .navigationBarTitle("Seleccionar país", displayMode: .inline)
        }
    }

    // Función para generar el emoji de la bandera a partir del nombre del país
    func countryFlagEmoji(for countryName: String) -> String {
        let isoCountryCode = getCountryCode(for: countryName)
        let base: UInt32 = 127397 // Base para generar banderas
        var emoji = ""
        for scalar in isoCountryCode.unicodeScalars {
            emoji.unicodeScalars.append(UnicodeScalar(base + scalar.value)!)
        }
        return emoji
    }

    // Función para obtener el código ISO del país
    func getCountryCode(for countryName: String) -> String {
        let countryMapping: [String: String] = [
            "Mexico": "MX",
            "United States": "US",
            "Canada": "CA",
            "India": "IN",
            "Brazil": "BR",
            "Germany": "DE",
            "Croatia": "HR",
            "Argentina": "AR",
            "Russia": "RU",
            "France": "FR",
            "Spain": "ES",
            "China": "CN",
            "Japan": "JP",
            "Nicaragua": "NI",
            "Italy": "IT",
            "Colombia": "CO"
        ]
        return countryMapping[countryName] ?? "XX" // Devuelve "XX" si no se encuentra
    }
}

struct CountryDetailsView: View {
    var country: String
    var cases: [String: CaseData]

    var body: some View {
        VStack {
            Text("Datos de COVID para \(country)")
                .font(.title)
                .padding()

            List(cases.sorted(by: { $0.key < $1.key }), id: \.key) { date, caseData in
                VStack(alignment: .leading) {
                    Text("Fecha: \(date)")
                        .font(.headline)
                    Text("Total: \(caseData.total)")
                    Text("Nuevo: \(caseData.new)")
                }
                .padding(.vertical, 5)
            }
        }
        .navigationBarTitle(country, displayMode: .inline)
    }
}

struct CovidView_Previews: PreviewProvider {
    static var previews: some View {
        CovidView(viewModel: CovidViewModel())
    }
}
