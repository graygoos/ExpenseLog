//
//  ToggleView.swift
//  ExpenseLog
//
//  Created by Femi Aliu on 23/03/2024.
//

import SwiftUI

struct ToggleView: View {
    @State private var isOn: Bool = false
    var key: SettingKeys
    
    var body: some View {
        Toggle(key.title, isOn: $isOn)
            .onAppear {
                self.isOn = self.key.value
            }
            .onChange(of: isOn) {
                self.key.assign(isOn)
            }
    }
}

#Preview {
    ToggleView(key: .location)
}
