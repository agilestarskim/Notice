//
//  NTPicker.swift
//  Notice
//
//  Created by 김민성 on 1/6/24.
//

import SwiftUI

struct NTPicker<SelectionValue, Data>: View where
    SelectionValue: Hashable & RawRepresentable,
    SelectionValue.RawValue: StringProtocol,
    Data: RandomAccessCollection,
    Data.Element == SelectionValue
{
    @Binding var selection: SelectionValue
    let data: Data
    let theme: Theme
    let onChange: ((SelectionValue, SelectionValue) -> Void)?
    
    init(
        _ selection: Binding<SelectionValue>,
        _ data: Data,
        theme: Theme,
        onChange: ((SelectionValue, SelectionValue) -> Void)? = nil
    ) {
        self._selection = selection
        self.data = data
        self.theme = theme
        self.onChange = onChange
    }
    
    var body: some View {
        HStack {
            ForEach(data, id: \.self) { element in
                if selection == element {
                    Button {
                        selection = element
                    } label: {
                        Text(element.rawValue)
                            .foregroundStyle(theme.primary)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(theme.container)                    
                } else {
                    Button {
                        onChange?(selection, element)
                        selection = element
                    } label: {
                        Text(element.rawValue)
                            .foregroundStyle(theme.primary)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)                    
                }
            }
        }
    }
}
