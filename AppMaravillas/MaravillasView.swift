//
//  ContentView.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 27/09/22.
//
import SwiftUI

struct MaravillasView: View {
    
    @StateObject var maravillasVM = MaravillasViewModel()
    @Binding var nombre : String
    var body: some View {
            NavigationView{
                ZStack{
                    Color("Fondo")
                        .edgesIgnoringSafeArea(.all)
                    ScrollView(.vertical, showsIndicators: false){
                        Text("Hola \(nombre)")
                        VStack{
                            ForEach(maravillasVM.arrMaravillas) { item in
                                NavigationLink(destination: MaravillasDetailView(maravilla: item),
                                label: { MaravillaItemView(maravilla: item)})
                                
                            } //Foreach
                        } //VStack
                    }//ScrollView
                }//ZStack
                .navigationTitle("Anuncios")
                
                
                
            } //Navigation View
             
            


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MaravillasView(nombre: .constant("Alex"))
    }
}
