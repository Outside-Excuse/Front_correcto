//
//  PerfilView.swift
//  AppMaravillas
//
//  Created by Alejandro Hidalgo Badillo on 11/10/22.
//

import SwiftUI

struct PerfilView: View {
    private let data: [Int] = Array(1...20)
    private let colors: [Color] = [.red, .green, .blue, .yellow]
    
    // Flexible, custom amount of columns that fill the remaining space
    private let numberColumns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    // Adaptive, make sure it's the size of your smallest element.
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    // Fixed, creates columns with fixed dimensions
    private let fixedColumns = [
        GridItem(.fixed(200)),
        GridItem(.fixed(200))
    ]
    
    @StateObject var maravillasVM = MaravillasViewModel()

    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(data, id: \.self) { number in
                        ZStack {
                            Rectangle()
                                .frame(width: 170, height: 170)
                                .foregroundColor(colors[number%4])
                                .cornerRadius(30)
                            Text("\(number)")
                                .foregroundColor(.white)
                                .font(.system(size: 70, design: .rounded))
                        }
                    }
                }
            }
            .navigationTitle("Mis obras")
            .padding()
        }
    }    
}

struct PerfilView_Previews: PreviewProvider {
    static var previews: some View {
        PerfilView()
    }
}
