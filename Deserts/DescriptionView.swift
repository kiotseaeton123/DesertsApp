//
//  DescriptionView.swift
//  Deserts
//
//  Created by zhongyuan liu on 5/2/23.
//

import SwiftUI

struct DescriptionView: View {
    let id: String
    var body: some View {
        Text(id)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(id: "test")
    }
}
