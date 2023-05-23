//
//  ContentView.swift
//  paint
//
//  Created by userext on 19/05/23.
//

import SwiftUI
import UIKit
import CoreData

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
    @State private var selectedColor: Color = .black
    @State private var widthPen: CGFloat = 2
    
    var colors1: [Color] = [.red, .blue, .green, .gray, .brown]
    var colors2: [Color] = [.yellow, .black, .purple, .cyan]
    
    
    var body: some View {
        VStack {
            HStack {
                ForEach(colors1, id: \.self) { color in
                    Circle()
                        .frame(height: 50)
                        .foregroundColor(color)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            HStack {
                ForEach(colors2, id: \.self) { color in
                    Circle()
                        .frame(height: 50)
                        .foregroundColor(color)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            GeometryReader { geometry in
                ZStack {
                    ForEach(strokes) { stroke in
                        Path { path in
                            for (index, point) in stroke.points.enumerated() {
                                if index == 0 {
                                    path.move(to: point)
                                } else {
                                    path.addLine(to: point)
                                }
                            }
                        }
                        .stroke(style: StrokeStyle(lineWidth: stroke.wdPen))
                        .foregroundColor(stroke.color)
                    }
                    
                    Path { path in
                        for (index, point) in currentStroke.enumerated() {
                            if index == 0 {
                                path.move(to: point)
                            } else {
                                path.addLine(to: point)
                            }
                        }
                    }
                    .stroke(style: StrokeStyle(lineWidth: widthPen))
                    .foregroundColor(selectedColor)
                }
                .background(Color.white)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let location = value.location
                            if !isDrawing {
                                currentStroke = [location]
                                isDrawing = true
                            } else {
                                currentStroke.append(location)
                            }
                        }
                        .onEnded { value in
                            isDrawing = false
                            let stroke = Stroke(points: currentStroke, color: selectedColor, wdPen: widthPen)
                            strokes.append(stroke)
                            currentStroke = []
                        }
                )
            }
            HStack{
                Circle().frame(height: 50).overlay(Image(systemName: "eraser.fill").font(.system(size: 20)).foregroundColor(.white)).onTapGesture {
                    strokes = []
                }
                Circle()
                    .frame(height: 50)
                    .overlay(Image(systemName: "pencil.tip.crop.circle.badge.plus")
                        .font(.system(size: 30))
                        .foregroundColor(.white))
                    .onTapGesture {
                        widthPen+=1
                    }
                Circle()
                    .frame(height: 50)
                    .overlay(Image(systemName: "pencil.tip.crop.circle.badge.minus")
                        .font(.system(size: 30))
                        .foregroundColor(.white))
                    .onTapGesture {
                        widthPen-=1
                    }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
