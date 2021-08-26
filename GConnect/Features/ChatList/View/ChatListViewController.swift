//
//  ChatListViewController.swift
//  GConnect
//
//  Created by vincent meidianto on 06/08/21.
//

import UIKit

class ChatListViewController: UIViewController {

    @IBOutlet weak var scChat: UISegmentedControl!
    @IBOutlet weak var loungeChatView: UIView!
    @IBOutlet weak var personalChatView: UIView!
    
    var chatListVM = ChatListViewModel()
    var dataLounge = [DetailLounge]()
    var statusView: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if statusView == nil{
            statusView = 0
        }
        
        if statusView == 0{
            loungeChatView.alpha = 1
            personalChatView.alpha = 0
            statusView = 0
        }else if statusView == 1{
            loungeChatView.alpha = 0
            personalChatView.alpha = 1
            statusView = 1
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            loungeChatView.alpha = 1
            personalChatView.alpha = 0
            statusView = 0
        }else if sender.selectedSegmentIndex == 1 {
            loungeChatView.alpha = 0
            personalChatView.alpha = 1
            statusView = 1
        }
    }
    
    @IBAction func buttonInvitationTapped(_ sender: Any) {
        goToInvitation()
    }
    
    func goToInvitation(){
        let showInvitation = UIStoryboard(name: "InvitationList", bundle: nil)
        let vc = showInvitation.instantiateViewController(identifier: "InvitationList") as! InvitationListViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
