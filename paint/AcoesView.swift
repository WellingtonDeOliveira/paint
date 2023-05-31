//
//  AcoesView.swift
//  paint
//
//  Created by userext on 25/05/23.
//

import SwiftUI

struct AcoesView: View {
    @Binding var strokes: [Stroke]
    @Binding var widthPen: CGFloat
    @Binding var isEraser: Bool
    
    func prinT(){
        print(isEraser)
    }
    
    var body: some View {
        HStack{
            Circle()
                .frame(height: 50)
                .overlay(Image(systemName: "eraser.fill")
                .font(.system(size: 20))
                .foregroundColor(.white))
                .onTapGesture {
                    isEraser = !isEraser
            }
            Circle().frame(height: 50).overlay(Image(systemName: "xmark")
                .font(.system(size: 20)).foregroundColor(.white))
                .onTapGesture {
                strokes = []
            }
            Circle()
                .frame(height: 50)
                .overlay(Image(systemName: "pencil.tip.crop.circle.badge.plus")
                    .font(.system(size: 30))
                    .foregroundColor(.white))
                .onTapGesture {
                    if(!(widthPen >= 10)){
                        widthPen+=1
                    }
                }
            Circle()
                .frame(height: 50)
                .overlay(Image(systemName: "pencil.tip.crop.circle.badge.minus")
                    .font(.system(size: 30))
                    .foregroundColor(.white))
                .onTapGesture {
                    if(!(widthPen <= 1)){
                        widthPen-=1
                    }
                }
        }
    }
}

struct AcoesView_Previews: PreviewProvider {
    static var previews: some View {
        AcoesView(strokes: .constant([]), widthPen: .constant(0), isEraser: .constant(false))
    }
}
