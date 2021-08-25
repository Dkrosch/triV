//
//  ChatPersonalViewController.swift
//  GConnect
//
//  Created by Michael Tanakoman on 22/08/21.
//

import UIKit
import InputBarAccessoryView
import Firebase
import MessageKit
import FirebaseFirestore
import SDWebImage


class ChatPersonalViewController: MessagesViewController, InputBarAccessoryViewDelegate, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {

    var currentUser: User = Auth.auth().currentUser!
    private var docReference: DocumentReference?
    private var collectionRef: CollectionReference?
    var messages: [Message] = []
    var targetedUser: String = ""
    var idPersonalChat: String = ""
    var nameTargetedUser: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
        
        self.title = nameTargetedUser
        
        navigationItem.largeTitleDisplayMode = .never
        maintainPositionOnKeyboardFrameChanged = true
        scrollsToLastItemOnKeyboardBeginsEditing = true
        
        messageInputBar.inputTextView.tintColor = .systemBlue
        messageInputBar.sendButton.setTitleColor(.systemTeal, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        print("ini idRoom di dalem chat", idPersonalChat)
        
        loadChat()
    }
    
    func loadChat() {
        let db = Firestore.firestore().collection("ChatPersonal").document(idPersonalChat).collection("chats")
        
        db.getDocuments { snapshot, error in
            if error != nil{
                print(error as Any)
            }else{
                for document in (snapshot?.documents)!{
                    self.docReference = document.reference
                    document.reference.collection("thread").order(by: "created", descending: false).addSnapshotListener(includeMetadataChanges: true, listener: { threadQuery, error in
                        
                        if let error = error {
                            print("Error: \(error)")
                            return
                        } else {
                            self.messages.removeAll()
                            for message in threadQuery!.documents {
                                let msg = Message(dictionary: message.data())
                                self.messages.append(msg!)
                            }
                            self.messagesCollectionView.reloadData()
                            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
                        }
                    })
                    return
                }
            }
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        messages.append(message)
        messagesCollectionView.reloadData()
            
        DispatchQueue.main.async {
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        }
    }
    
    private func save(_ message: Message) {
            
        let data: [String: Any] = [
            "content": message.content,
            "created": message.created,
            "id": message.id,
            "senderID": message.senderID,
            "senderName": message.senderName,
            "imageProfile": message.imageProfile
        ]
        
        docReference?.collection("thread").addDocument(data: data, completion: { (error) in
            if let error = error {
                print("Error Sending message: \(error)")
                return
            }
            self.messagesCollectionView.scrollToLastItem(at: .bottom, animated: true)
        })
    }
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String){
        
        Firestore.firestore().collection("users").document(currentUser.uid).getDocument { (document, error) in
            if error != nil{
                print(error as Any)
            }else if let document = document, document.exists{
                let username = document.get("username") as! String
                let imageProfile = document.get("imageProfile") as! String
                
                let message = Message(id: UUID().uuidString, content: text, created: Timestamp(), senderID: self.currentUser.uid, senderName: username, imageProfile: imageProfile)
                self.insertNewMessage(message)
                self.save(message)
            }
        }
            
        inputBar.inputTextView.text = ""
        messagesCollectionView.reloadData()
        messagesCollectionView.scrollToLastItem(animated: true)
    }
    
    func currentSender() -> SenderType {
        return Sender(senderId: Auth.auth().currentUser!.uid, displayName: Auth.auth().currentUser?.email ?? "Name not found", imageProfile: "")
    }
        
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
          string: name,
          attributes: [
            .font: UIFont.preferredFont(forTextStyle: .caption1),
            .foregroundColor: UIColor.black
          ]
        )
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        if messages.count == 0 {
            print("No messages to display")
            return 0
        } else {
            return messages.count
        }
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
        
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? #colorLiteral(red: 0.2381618619, green: 0.2898079157, blue: 0.4220144749, alpha: 1): .lightGray
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        DispatchQueue.global().async {
//            if let url = URL(string: message.sender.imageProfile){
//                do{
//                    let data = try Data(contentsOf: url)
//                    avatarView.image = UIImage(data: data)
//                } catch let err{
//                    print("error")
//                }
//            }
//        }
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner =
            isFromCurrentSender(message: message) ? .bottomRight: .bottomLeft
        return .bubbleTail(corner, .curved)
    }
}
