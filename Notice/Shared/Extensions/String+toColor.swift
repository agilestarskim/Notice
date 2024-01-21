//
//  String+toColor.swift
//  Notice
//
//  Created by 김민성 on 1/20/24.
//

import SwiftUI

extension String {
    var toColor: Color {
        switch self {
        case Color.red.description:
            Color.red
        case Color.orange.description:
            Color.orange
        case Color.yellow.description:
            Color.yellow
        case Color.green.description:
            Color.green
        case Color.cyan.description:
            Color.cyan
        case Color.blue.description:
            Color.blue
        case Color.indigo.description:
            Color.indigo
        default:
            Color.red
        }
    }
}
