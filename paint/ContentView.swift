//
//  ContentView.swift
//  paint
//
//  Created by userext on 19/05/23.
//

import SwiftUI
import UIKit

struct Stroke: Identifiable {
    let id = UUID()
    let points: [CGPoint]
    let color: Color
    let wdPen: CGFloat
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var strokes: [Stroke] = []
    @State private var currentStroke: [CGPoint] = []
    @State private var isDrawing: Bool = false
    @State private var isEraser: Bool = false
    @State private var selectedColor: Color = .black
    @State private var widthPen: CGFloat = 2
    @State private var position: CGPoint = .zero
    
    public var colors1: [Color] = [.red, .blue, .green, .gray, .brown]
    public var colors2: [Color] = [.yellow, .black, .purple, .cyan]
    
    
    var body: some View {
        ZStack{
            VStack {
                DrawView(
                    strokes: $strokes,
                    widthPen: $widthPen,
                    selectedColor: $selectedColor,
                    currentStroke: $currentStroke,
                    isDrawing: $isDrawing,
                    isEraser: $isEraser,
                    position: $position
                )
                AcoesView(strokes: $strokes, widthPen: $widthPen, isEraser: $isEraser)
                
            }
            VStack{
                ColorsView(selectedColor: $selectedColor).frame(maxWidth: .infinity).edgesIgnoringSafeArea(.all).padding(.top, 5)
                Spacer()
            }
            
            
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
