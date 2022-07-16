//
//  FlagImage.swift
//  GuessTheFlag
//
//  Created by Nicolas Papegaey on 16/07/2022.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
            .scaleEffect()
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(country: "France")
    }
}
