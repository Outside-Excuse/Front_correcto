//
//  MainView.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 11/10/22.
//

import SwiftUI

struct MainView: View {
    @State var nombre : String = ""
    
    var body: some View {
        TabView{
            MaravillasView(nombre: $nombre)
                .tabItem{
                    Image(systemName:"house.fill")
                    Text("Menu")
                }
            ARView()
                .tabItem{
                    Image(systemName:"camera.fill")
                    Text("AR art")
                }
      
            FiltrosView()
                .tabItem{
                    Image(systemName:"person.fill")
                    Text("Filtros")
                }
        PerfilView()
                .tabItem{
                Image(systemName: "briefcase.fill")
                Text("obras")
                    
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
