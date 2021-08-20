//
//  InvitationList.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 19/08/21.
//

import SwiftUI

struct InvitationList: View {
    
    let posts = ["1", "2", "3"]
    
    var body: some View {
        NavigationView{
            
            List{
                
//                ForEach(posts.identified(by: \.self)){ post in
//                    Text(post)
//                }
                
            }.navigationBarTitle(Text("Invitation"))
            
        }
       
        
    }
}

struct InvitationList_Previews: PreviewProvider {
    static var previews: some View {
        InvitationList()
    }
}
