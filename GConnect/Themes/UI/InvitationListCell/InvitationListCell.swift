//
//  InvitationListCell.swift
//  GConnect
//
//  Created by Kevin Rivaldo  on 20/08/21.
//

import UIKit

class InvitationListCell: UICollectionViewCell {
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var userRoleLabel: UILabel!
    @IBOutlet weak var loungeMemberqtyLbl: UILabel!
    @IBOutlet weak var loungeDescLabel: UILabel!
    @IBOutlet weak var labelListRequirements: UILabel!
    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var labelLoungeTitle: UILabel!
    
    static func nib() -> UINib{
        return UINib(nibName: "InvitationListCell", bundle: nil)
    }
    
    static let identifier = "cellInvitationList"
    var dataLoungeUser: GetDataLoungeUser?
    var invitationListVM = InvitationListViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        viewBackground.layer.cornerRadius = 10
        viewBackground.layer.borderWidth = 1
        viewBackground.layer.borderColor = #colorLiteral(red: 0.9866532683, green: 0.5863298774, blue: 0.4647909403, alpha: 1)
        
        rejectBtn.layer.cornerRadius = 10
        acceptBtn.layer.cornerRadius = 10
    }
    
    func configureCell(dataLoungeUser: GetDataLoungeUser){
        self.dataLoungeUser = dataLoungeUser
        
        var num = 10

        for member in dataLoungeUser.idMemberLounge{
            if member == ""{
                num -= 1
            }
        }
        loungeMemberqtyLbl.text = "\(num)/10"
        
        var req: [String] = []
        if dataLoungeUser.idRequirementsLounge[0] == true { req.append("Defensive") }
        if dataLoungeUser.idRequirementsLounge[1] == true { req.append("Recon") }
        if dataLoungeUser.idRequirementsLounge[2] == true { req.append("Support") }
        if dataLoungeUser.idRequirementsLounge[3] == true { req.append("Offensive") }
        
        labelListRequirements.text = "\(dataLoungeUser.rank) | \(req.joined(separator: " | "))"
    }
    
    @IBAction func btnAcceptTapped(_ sender: Any) {
        invitationListVM.acceptInvitation(idLounge: dataLoungeUser?.idLounge ?? "", idInvitation: dataLoungeUser?.idInvite ?? "")
    }
    
    @IBAction func btnRejectTapped(_ sender: Any) {
        invitationListVM.deleteInvitation(idInvitation: dataLoungeUser?.idInvite ?? "")
    }
}
