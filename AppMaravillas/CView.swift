//
//  CView.swift
//  AppMaravillas
//
//  Created by Carlos Milano on 20/10/22.
//

import SwiftUI

struct CView: View {
    var body: some View {
        CamaraView()
    }
}

struct CView_Previews: PreviewProvider {
    static var previews: some View {
        CView()
    }
}

struct CamaraView: View {
    
    @StateObject var camara = CamaraModel()
    
    var body: some View{
        ZStack{
            Color.black
                .ignoresSafeArea(.all, edges:  .all)
            
            VStack{
                
                if camara.isTaken{
                    Button(action: {}, label: {
                        
                        Image
                            
                    })
                    .padding(.trailing,10)
                }
                
                Spacer()
                
                HStack{
                    
                    if camara.isTaken{
                        
                        Button(action: {}, label: {
                            Text("Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(Color.white)
                                .clipShape(Capsule())
                                
                        })
                        .padding(.leading)
                        
                        Spacer()
                    }
                    else{
                        Button(action: {camara.isTaken.toggle()}, label: {
                            
                            ZStack{
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 70, height: 70)
                                
                                Circle()
                                    .stroke(Color.white, lineWidth: 2)
                                    .frame(width: 75, height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
            }
        }
    }
}

class CamaraModel: ObservableObject{
    
    @Published var isTaken = false
}
