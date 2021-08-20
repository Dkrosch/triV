//
//  CollectionViewCell.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 19/08/21.
//

import SwiftUI

struct CollectionViewCell: View {
    static let coulmn = 1
    static let row = 9
    let width = (UIScreen.main.bounds.width/3) - 20
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 12).frame(width: /*@START_MENU_TOKEN@*/328/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/217/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(Color.init("Rhino")).border(Color.init("Vivid Tangerine"), width: 3).cornerRadius(10)
        }
       
    }
}

struct CollectionViewCell_Previews: PreviewProvider {
    static var previews: some View {
        CollectionViewCell()
    }
}
