//
//  DrawingView.swift
//  wk3
//
//  Created by Dayo Adekoya on 7/21/24.
//

import SwiftUI

struct ColorPickerView: View {
    let color = [Color.red, Color.orange, Color.green, Color.black, Color.purple, Color.blue]
    @Binding var selectedColor: Color
    
    var body: some View {
        HStack {
            ForEach(color, id: \.self) { color in
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 20))
                    .clipShape(Circle())
                    .onTapGesture {
                        selectedColor = color
                    }
            }
            
        }
        
    }
}
