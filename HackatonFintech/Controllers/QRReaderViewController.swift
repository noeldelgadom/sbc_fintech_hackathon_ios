//
//  QRReaderViewController.swift
//  HackatonFintech
//
//  Created by Victor Manuel Castillo Torres on 1/27/18.
//  Copyright © 2018 HackatonFintech. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class QRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate{
    
    @IBOutlet weak var qrFrameView: UIView!
    var captureSession: AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    @IBOutlet weak var scanningAnimationView: UIView!
    var originalAnimationFrame: CGRect?
    
    
    @objc func cameBackFromSleep(sender : AnyObject) {
        // Restart animation here or resume?
        resetAnimation()
        animateQrView()
    }

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(cameBackFromSleep), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        let input : AnyObject! = try? AVCaptureDeviceInput.init(device: captureDevice!)
        
        if(input == nil){
            return
        }
        captureSession = AVCaptureSession.init()
        
        captureSession?.addInput(input as! AVCaptureInput)
        
        let captureMetadataOutput = AVCaptureMetadataOutput.init()
        captureSession?.addOutput(captureMetadataOutput)
        
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer.init(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = self.qrFrameView.layer.bounds
        self.qrFrameView.layer.addSublayer(videoPreviewLayer!)
        
        
        captureSession?.startRunning()
        
        
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor  = UIColor.green.cgColor
        qrCodeFrameView?.layer.borderWidth = 2
        self.qrFrameView.addSubview(qrCodeFrameView!)
        self.qrFrameView.bringSubview(toFront: qrCodeFrameView!)
        self.qrFrameView.bringSubview(toFront: self.scanningAnimationView)
        originalAnimationFrame = self.scanningAnimationView.frame
    }
    
    func animateQrView () {
        UIView.animate(withDuration: 2.0, delay: 0, options: [.repeat, .autoreverse],   animations: {
            self.scanningAnimationView.frame = CGRect.init(x: self.scanningAnimationView.frame.origin.x, y: self.scanningAnimationView.frame.origin.y + (self.qrFrameView.frame.height - 4), width: self.scanningAnimationView.frame.width, height: self.scanningAnimationView.frame.height)
        }, completion: { finished in
            self.scanningAnimationView.frame = CGRect.init(x: self.scanningAnimationView.frame.origin.x, y: self.scanningAnimationView.frame.origin.y - (self.qrFrameView.frame.height + 4), width: self.scanningAnimationView.frame.width, height: self.scanningAnimationView.frame.height)
        })
    }
    
    func resetAnimation(){
        self.scanningAnimationView.frame = originalAnimationFrame!
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects == nil || metadataObjects.count == 0{
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        let metadataObj =  metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr{
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            
        }
    }
}
