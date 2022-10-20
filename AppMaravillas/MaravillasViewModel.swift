//
//  MaravillasViewModel.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 27/09/22.
//

import Foundation
import SwiftUI

class MaravillasViewModel : ObservableObject{
    
      @Published var arrMaravillas = [MaravillasModel]()
      
      init(){
          getMaravillas()
      }
      
      
      func getMaravillas() {
          
          var maravilla : MaravillasModel
          
          
          maravilla = MaravillasModel(titulo: "  Dodge Challenger", descripcion: "The Dodge Challenger is the name of three different generations of automobiles (two of those being pony cars) produced by American automobile manufacturer Dodge.", urlVideo: "https://www.youtube.com/watch?v=cKx-cb0fzeo", latitud: 20.6666700, longitud: -88.5666700, nombreImagen: "Challenger")
          arrMaravillas.append(maravilla)
          
          maravilla = MaravillasModel(titulo: "Jeep Sahara ", descripcion: "Está hermosura de vehiculo se descrive por si mismo....", urlVideo: "https://www.youtube.com/watch?v=TVvu7SmD4zg", latitud: 18.9216900, longitud:  72.8331200, nombreImagen: "Jeep")
          arrMaravillas.append(maravilla)
          
          maravilla = MaravillasModel(titulo: "Ford mustang ", descripcion: "Auto leyenda de los Muscle Cars que equipa gran Tecnología y monta un potente Motor de hasta 450HP y 410 lb-pie de Torque.", urlVideo: "https://www.youtube.com/watch?v=46rGK-zrw8Y", latitud: 44.4168600, longitud:  12.2100000, nombreImagen: "Mustang")
          arrMaravillas.append(maravilla)
          
      }
}
