//
//  GrassView.swift
//  Notice
//
//  Created by 김민성 on 1/8/24.
//

import SwiftUI

struct GrassView: View {
    private let performedDate: Set<String>
    private let rowCount: Int
    private let colCount: Int
    private let cellColor: Color
    
    private let calendar = Calendar.shared
    
    public init (
        _ performedDate:[String] = [],
        row: Int, col: Int,
        cellColor: Color
    ) {
        self.performedDate = Set(performedDate)
        self.rowCount = row
        self.colCount = col
        self.cellColor = cellColor
    }
    
    var body: some View {
        VStack {
            ForEach(0..<rowCount, id: \.self){ row in
                HStack{
                    ForEach(0..<colCount, id: \.self){ col in
                        GrassCellView(
                            isPerformed: isPerformed(cellDate: getDate(row: row, col: col)),
                            cellColor: self.cellColor
                        )
                    }
                }
            }
        }        
    }
    
    func isPerformed(cellDate: String) -> Bool {
        performedDate.contains(cellDate)
    }
    
    func getDate(row:Int, col: Int) -> String {
        let diff = -1 * ( (rowCount - row - 1) + (colCount - col - 1) * rowCount )
        let date = calendar.date(byAdding: .day, value: diff, to: .now) ?? .now
        let dateString = DateFormatter.string(date, style: .performedDate)
        return dateString
    }
}

struct GrassCellView: View {
    let isPerformed: Bool
    let cellColor: Color
    
    var body: some View {
        GeometryReader { geo in
           RoundedRectangle (
               cornerSize: CGSize(width: geo.size.width / 5, height: geo.size.height / 5), style: .continuous
           )
           .fill(isPerformed ? cellColor : cellColor.opacity(0.2))
       }
       .aspectRatio(1.0, contentMode: .fit)       
    }
}
