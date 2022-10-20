//
//  MaravillasDetailView.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 28/09/22.
//

import SwiftUI

struct MaravillasDetailView: View {
    
    let maravilla : MaravillasModel
    
    var body: some View {
     
        VStack{
       
            Image(maravilla.nombreImagen)
                .resizable()
                .scaledToFit()
                .frame(width:250)
                .clipShape(Circle())
                .shadow(radius: 7)
                .offset(y:-50)
            VStack{
              
                Text(maravilla.titulo)
                    .font(.custom("Oswald-VariableFont_wght",size: 18))
                    .foregroundColor(.blue)
                    .offset(y:-20)
                
                Text(maravilla.descripcion)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Link(destination: URL(string: maravilla.urlVideo)!, label: {
                    Label("Video", systemImage: "play.tv.fill")
                })
                Spacer()
            }
        }
        
    }
}

struct MaravillaDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MaravillasDetailView(maravilla : MaravillasModel.defaultMaravilla)
    }
}
