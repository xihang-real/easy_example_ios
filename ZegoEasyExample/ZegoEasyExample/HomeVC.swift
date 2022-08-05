//
//  HomeVC.swift
//  ZegoEasyExample
//
//  Created by zego on 2022/5/9.
//

import UIKit
import ZegoExpressEngine

class HomeVC: UIViewController {
    
    @IBOutlet weak var roomIDTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func joinLiveAsHostClick(_ sender: UIButton) {
        // join room
        joinRoom(true)
        presentLiveVC(true, hostID: ZegoExpressManager.shared.localParticipant?.userID)
        
    }
    
    @IBAction func joinLiveAsAudienceClick(_ sender: UIButton) {
        // join room
        joinRoom(false)
        presentLiveVC(false, hostID: nil)
    }
    
    func joinRoom(_ isHost: Bool) {
        let roomID = roomIDTextField.text ?? ""
        let userID = generateUserID()
        let user = ZegoUser(userID:userID, userName:("\(userID)Test"))
        let option: ZegoMediaOptions = isHost ? [.autoPlayVideo, .autoPlayAudio, .publishLocalAudio, .publishLocalVideo] : [.autoPlayVideo, .autoPlayAudio]
        ZegoExpressManager.shared.joinRoom(roomID: roomID, user: user, options: option)
    }
    
    func presentLiveVC(_ isHost: Bool, hostID: String?){
        let liveVC: LiveRoomVC = LiveRoomVC.loadLiveRoomVC(isHost ? .host : .listener, hostID: hostID) as! LiveRoomVC
        self.modalPresentationStyle = .fullScreen
        liveVC.modalPresentationStyle = .fullScreen
        
        // set handler
        ZegoExpressManager.shared.handler = liveVC
        self.present(liveVC, animated: true, completion: nil)
    }
    
    
    func generateUserID() -> String {
        let timeInterval:TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return String(format: "%d", timeStamp)
    }

}
