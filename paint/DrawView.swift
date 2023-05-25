//
//  DrawView.swift
//  paint
//
//  Created by userext on 25/05/23.
//

import SwiftUI

struct DrawView: View {
    @Binding var strokes: [Stroke]
    @Binding var widthPen: CGFloat
    @Binding var selectedColor: Color
    @Binding var currentStroke: [CGPoint]
    @Binding var isDrawing: Bool
    @Binding var position: CGPoint
    
    var body: some View {
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
                    Circle()
                        .frame(height: 3*widthPen)
                        .foregroundColor(selectedColor)
                        .offset(x: position.x - 180, y: position.y - 280)
                
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
                        position = location
                    }
                    .onEnded { value in
                        isDrawing = false
                        let stroke = Stroke(points: currentStroke, color: selectedColor, wdPen: widthPen)
                        strokes.append(stroke)
                        currentStroke = []
                    }
            )
        }
    }
}

struct DrawView_Previews: PreviewProvider {
    static var previews: some View {
        DrawView(
            strokes: .constant([]),
            widthPen: .constant(0),
            selectedColor: .constant(.black),
            currentStroke: .constant([]),
            isDrawing: .constant(false),
            position: .constant(.zero)
        )
    }
}
