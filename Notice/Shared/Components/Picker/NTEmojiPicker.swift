//
//  NTEmojiPicker.swift
//  Notice
//
//  Created by 김민성 on 1/19/24.
//

import SwiftUI

struct NTEmojiPicker: View {
    @Binding var emoji: Int
    let selectColor: Color
    private let emojies: [Int] = [
        0x1F3C6, // 트로피
        0x1F393, // 학사모
        0x1F451, // 왕관
        0x1F525, // 불꽃
        0x1F4BC, // 서류가방
        0x1F436, // 강아지
        0x1F335, // 선인장
        0x1F331, // 새싹
        0x1F337, // 튤립
        0x1F30E, // 지구
        0x1F30A, // 파도
        0x1F3C0, // 농구공
        0x1F6F9, // 스케이트 보드
        0x1FA82, // 낙하산
        0x1F3C4, // 서핑
        0x1F947, // 금메달
        0x1F3AB, // 티켓
        0x1F3A8, // 팔레트
        0x1F3AC, // 크래퍼보드
        0x1F3A4, // 마이크
        0x1F3B9, // 건반
        0x1F3B8, // 기타
        0x1F3AF, // 과녁 명중
        0x1F4F1, // 스마트폰
        0x1F4F7, // 카메라
        0x23F0, // 알람시계
        0x1F4A1, // 전구
        0x1F4B5, // 달러
        0x1F48A, // 알약
        0x1F52D, // 망원경
        0x1F4C8, // 상승차트
        0x1F4DA, // 책
        0x1F4DD, // 메모
        0x1F9E1, // 주황색 하트
        0x1F4AF, // 100점
        0x1F6EB, // 이륙하는 비행기
        0x1F680, // 로켓
        0x1F5FD, // 자유의 여신상
    ]
    let rows: [GridItem] = Array(repeating: .init(), count: 5)
    
    var body: some View {
        LazyVGrid(columns: rows, spacing: 20) {
            ForEach(emojies, id: \.self) { emoji in
                let unicode = UnicodeScalar(emoji)!
                Text(String(unicode))
                    .font(.title3)
                    .padding(10)
                    .onTapGesture {
                        self.emoji = emoji
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(selectColor, lineWidth: self.emoji == emoji ? 1 : 0)
                    )
            }
        }
    }
}
