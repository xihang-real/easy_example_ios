//
//  CallViewController.swift
//  ZegoExpressDemo
//
//  Created by Larry on 2022/3/26.
//

import UIKit
import ZegoExpressEngine

class CallViewController: UIViewController {
    
    @IBOutlet weak var speakerButton: UIButton!
    @IBOutlet weak var micButton: UIButton!
    @IBOutlet weak var callIUserIDLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGray
        // configUI
        speakerButton.setImage(UIImage(named: "call_audio_voice_close"), for: .selected)
        speakerButton.setImage(UIImage(named: "call_audio_voice_open"), for: .normal)
        micButton.setImage(UIImage(named: "call_mic_close"), for: .selected)
        micButton.setImage(UIImage(named: "call_mic_open"), for: .normal)
    }
    
    @IBAction func pressHangUpButton(_ sender: UIButton) {
        ZegoExpressManager.shared.leaveRoom()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressSpeakerButton(_ sender: UIButton) {
        ZegoExpressManager.shared.enableSpeaker(enable: sender.isSelected)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func pressMicButton(_ sender: UIButton) {
        ZegoExpressManager.shared.enableMic(enable: sender.isSelected)
        sender.isSelected = !sender.isSelected
    }
}

extension CallViewController: ZegoExpressManagerHandler {
    func onRoomExtraInfoUpdate(_ roomExtraInfoList: [ZegoRoomExtraInfo], roomID: String) {
        
    }
    
    func onRoomStateUpdate(_ state: ZegoRoomState, errorCode: Int32, extendedData: [AnyHashable : Any]?, roomID: String) {
        
    }
    
    func onRoomUserUpdate(udpateType: ZegoUpdateType, userList: [String], roomID: String) {
        for userID in userList {
            self.callIUserIDLabel.text = String(format: "user_%@", userID)
        }
    }
    
    func onRoomUserDeviceUpdate(updateType: ZegoDeviceUpdateType, userID: String, roomID: String) {
        
    }
    
    func onRoomTokenWillExpire(_ remainTimeInSecond: Int32, roomID: String) {
        
    }
    
}
