//
//  Theme.swift
//  Notice
//
//  Created by 김민성 on 12/18/23.
//

import SwiftUI

protocol Theme {
    var background: Color { get }
    var container: Color { get }
    var primary: Color { get }
    var secondary: Color { get }
    var accent: Color { get }
}
