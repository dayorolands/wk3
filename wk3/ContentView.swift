//
//  ContentView.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/17/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var selectedColor: Color = .blue
    @State private var thickness: Double = 1.0
    
    var body: some View {
        VStack {
            Canvas { context, size in
                for line in lines {
                    var path = Path()
                    path.addLines(line.points)
                    context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
                }
            }
            .frame(minWidth: 400, minHeight: 400)
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onChanged({value in
                    let newPoint = value.location
                    currentLine.points.append(newPoint)
                    self.lines.append(currentLine)
                })
                .onEnded({ value in
                    self.lines.append(currentLine)
                    self.currentLine = Line(points: [], color: selectedColor, lineWidth: thickness)
                    })
            )
            
            VStack {
                HStack {
                    Text("Thickness")
                        .font(.headline)
                        .padding(.trailing, 10)
                    Slider(value: $thickness, in: 1...20)
                        .frame(maxWidth: 200)
                        .onChange(of: thickness) { [thickness] in
                            currentLine.lineWidth = thickness
                        }
                    Divider()
                    ColorPickerView(selectedColor: $selectedColor)
                        .onChange(of: selectedColor) { [selectedColor] in
                            currentLine.color = selectedColor
                        }
                }
                Button(action: {
                    lines.removeAll()
                }) {
                    Text("Clear Drawing")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
        .padding()
    }
}

struct ContentView_Previe: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
