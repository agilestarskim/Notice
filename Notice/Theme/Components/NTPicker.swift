//
//  NTPicker.swift
//  Notice
//
//  Created by 김민성 on 1/6/24.
//

import SwiftUI

struct NTPicker<SelectionValue: Hashable, Data: RandomAccessCollection>: View where Data.Element == SelectionValue {
    @Binding var selection: SelectionValue
    let data: Data
    let theme: Theme
    
    init(
        _ selection: Binding<SelectionValue>,
        _ data: Data,
        theme: Theme
    ) {
        self._selection = selection
        self.data = data
        self.theme = theme
    }
    
    var body: some View {
        HStack {
            ForEach(data, id: \.self) { element in
                if selection == element {
                    Button {
                        withAnimation(.bouncy) {
                            selection = element
                        }
                    } label: {
                        Text(String(describing: element))
                            .foregroundStyle(theme.primary)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(theme.container)
                    .transition(.scale)
                } else {
                    Button {
                        withAnimation(.bouncy) {
                            selection = element
                        }
                    } label: {
                        Text(String(describing: element))
                            .foregroundStyle(theme.primary)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                    
                }
            }
        }
    }
}
