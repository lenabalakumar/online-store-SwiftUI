//
//  FullButtonStyle.swift
//  online-store
//
//  Created by Lenabalakumar Subbarayan on 23/10/2023.
//

import SwiftUI

struct FullButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
