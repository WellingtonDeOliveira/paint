//
//  ColorsView.swift
//  paint
//
//  Created by userext on 25/05/23.
//

import SwiftUI

struct ColorsView: View {
    
    @Binding var selectedColor: Color

    var body: some View {
        VStack{
            HStack {
                ForEach(ContentView().colors1, id: \.self) { color in
                    Circle()
                        .frame(height: 50)
                        .foregroundColor(color)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            HStack {
                ForEach(ContentView().colors2, id: \.self) { color in
                    Circle()
                        .frame(height: 50)
                        .foregroundColor(color)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        }
    }
}

struct ColorsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorsView(selectedColor: .constant(.black))
    }
}
