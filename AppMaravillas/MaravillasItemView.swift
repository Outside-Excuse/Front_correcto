//
//  MaravillasItemView.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 27/09/22.
//

import SwiftUI

struct MaravillaItemView: View {
    
    let maravilla : MaravillasModel

    
    var body: some View {
       
        Image(maravilla.nombreImagen)
            .resizable()
            .scaledToFit()
            .cornerRadius(40)
            .frame(width: 300)
            .overlay(alignment: .topLeading, content: {
                Text(maravilla.titulo)
                    .foregroundColor(.white)
                    .font(.title)
                    .padding([.top, .leading], 10.0)
            })
            .padding()
    }
}

struct MaravillaItemView_Previews: PreviewProvider {
    static var previews: some View {
        MaravillaItemView(maravilla: MaravillasModel.defaultMaravilla)
    }
}
