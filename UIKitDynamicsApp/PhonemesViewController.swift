//
//  PhonemesViewController.swift
//  UIKitDynamicsApp
//
//  Created by GEORGE QUENTIN on 13/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import CoreMotion
import AVFoundation

class PhonemesViewController: UIViewController {
    
    let speech = AVSpeechSynthesizer()
    var disposeBag = DisposeBag()

    var animationSettings = AnimationSettings()
    
    var animator:UIDynamicAnimator? = nil
    //var gravity: UIGravityBehavior = UIGravityBehavior()
    //var collider: UICollisionBehavior = UICollisionBehavior()
    //var attachBehavior: UIAttachmentBehavior = UIAttachmentBehavior()
    //var itemBehavior: UIDynamicItemBehavior = UIDynamicItemBehavior()
    //var pushBehavior : UIPushBehavior = UIPushBehavior()
    var snapBehavior: UISnapBehavior!
    
    
    let startX : CGFloat = 40
    let startY : CGFloat = 200
    let width : CGFloat = 300
    let phonemesHeight : CGFloat = 40
    
    var wordsLabels = [UILabel]() 
    var snapPoints = [CGPoint]()
    var originPoint = [CGPoint]()
    var phonemesLabels = [UILabel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.randomColor()
        self.animator = UIDynamicAnimator(referenceView:self.view);
        //let viewW = super.view.bounds.size.width;
        //let viewH = super.view.bounds.size.height;
        
        let phonemesLayoutBox = UIView(frame: CGRect(x: startX, y: startY, width: width, height: phonemesHeight))
        phonemesLayoutBox.backgroundColor = UIColor.randomColor()
        self.view.addSubview(phonemesLayoutBox) 
        
        let textLayoutBox = UIView(frame: CGRect(x: startX, y: 400, width: width, height: (phonemesHeight * 3)))
        textLayoutBox.backgroundColor = UIColor.randomColor()
        textLayoutBox.alpha = 0.2
        self.view.addSubview(textLayoutBox) 
        
        let word = "biff got the eggs. she put them in the box"
        
        let wArr = wordList(word)
        //print(wArr)
        //print(wArr.count)
        
        
        for w in 0 ..< wArr.count {
            
            let squareGridNum = 4
            let wLength = Int(self.width) / squareGridNum
            //CGFloat(wordArr[w].characters.count * 10)
           
            let wX = Int(self.startX) + (w % squareGridNum) * (wLength)
            let wY = 400 + Int(w / squareGridNum) * Int(self.phonemesHeight)
            
            let frame = CGRect(x: CGFloat(wX), y: CGFloat(wY), width:CGFloat(wLength), height: self.phonemesHeight)
            self.wordsLabels.append( self.createBox(frame, color: UIColor.randomColor(), text: wArr[w]))
            
        }

//        self.wordsLabels.forEach { wordText in
//            
//            let pressGesture = UILongPressGestureRecognizer()
//            pressGesture.minimumPressDuration = 0.0
//            pressGesture
//                .rx_event
//                .doOnNext { gesture in
//                    
//                    let location = gesture.locationInView(pressGesture.view)
//                    guard let label = gesture.view as? UILabel else { return }
//                   
//                    switch gesture.state {
//                    case .Began: 
//                        
//                        print("first",self.phonemesLabels.count," snap first", self.snapPoints.count)
//                        
//                        self.phonemesLabels.forEach ({ pho in
//                            // if pho is UILabel {
//                            pho.removeFromSuperview()
//                            // }
//                            self.phonemesLabels = []
//                            self.snapPoints = []
//                        })
//                        print("after removed pho", self.phonemesLabels.count, "after removed snappoints", self.snapPoints.count)
//                        
//                        
//                        let wordModel = WordModel()
//                        wordModel.getPho()
//                        let phonemes = wordText.text!.characters
//                            .map { letter -> String in
//                                return String(letter)
//                            }
//                            .map { letter in
//                            
//                            return wordModel.chosenLetter[letter]![Int.random(0, max: (wordModel.chosenLetter[letter]!.count)-1)]
//                        }                 
//                        //print( label.text, phonemes.count, phonemes )
//                        
//                        for letter in 0 ..< phonemes.count {
//                           
//                            let widthOffset = (self.width) / CGFloat(phonemes.count)
//                            let newX = self.startX + (CGFloat(letter) * widthOffset)
//                            
//                            self.snapPoints.append(CGPointMake( newX+(widthOffset/2) , self.startY+(self.phonemesHeight/2) ))
//                            
//                            let frame = CGRect(x: wordText.center.x, y: wordText.center.y, width: widthOffset, height: wordText.frame.size.height)
//                            
//                            self.phonemesLabels.append( self.createBox(frame, color: wordText.backgroundColor!, text: phonemes[letter]))
//                            
//                           // print(phonemes.count)
//                        }
//                        
//                        
//                        print("after added something",self.phonemesLabels.count, "snap added", self.snapPoints.count)
//                        for pho in 0 ..< self.phonemesLabels.count {
//                            
//                            self.snapBehavior = UISnapBehavior(item: self.phonemesLabels[pho], snapToPoint: self.snapPoints[pho])
//                            self.animator?.addBehavior(self.snapBehavior)
//                            
//                        }
//    
//                        
//                       // print("began",location)
//                    case .Changed: 
//                        print("changed",location)
//                    case .Ended: 
//                        print("ended",location)
//                    default:
//                        print("tap ")
//                    }
//                }
////                .doOnNext { tick in
////                    
////                    // fade other out labels
////                    self.wordsLabels.forEach { otherLabel in
////                        if otherLabel != wordText
////                        {
////                            UIView.animateWithDuration(0.5) {
////                                otherLabel.alpha = 0.0
////                            } 
////                        }
////                    }
////                    print("check pho",self.phonemesLabels.count, "check snap", self.snapPoints.count)
////                    
////                }
//                // collapse phonemes
//                .flatMap { gesture -> Observable<Int64> in
//                    // say phoneme
////                    let utt = AVSpeechUtterance(string: self.phonemesLabels[0].text!)
//                    // say word
//                    //let utt = AVSpeechUtterance(string: wordText.text!)
//
//                    //self.speech.speakUtterance(utt)
//                     
//                 
//                    return Observable<Int64>
//                        .timer(4.0, scheduler: MainScheduler.instance)
//                                        
//                }
//                // fade back other labels
////                .doOnNext { tick in 
////
////                    self.wordsLabels.forEach { otherLabel in
////                       
////                        UIView.animateWithDuration(0.5) {
////                                otherLabel.alpha = 1.0
////                        } 
////                        
////                    }
////                    
////                }
//                .subscribeNext { tick in
//                    
//                    print("pho last count", self.phonemesLabels.count, "snap last count",self.snapPoints.count)
//                    
//                    self.phonemesLabels.forEach ({ pho in
//                        
//                        self.snapBehavior = UISnapBehavior(item: pho, snapToPoint: wordText.center)
//                        self.animator?.addBehavior(self.snapBehavior)
//                    
//                       
////                        transform
////                        UIView.animateWithDuration(0.3) {
////                            self.phonemesLabels[pho].alpha = 0.0
////                        }
////                        UIView.animateWithDuration(0.8) {
////                            let layer: CALayer = self.phonemesLabels[pho].layer
////                            layer.transform = 
////                                CATransform3D(
////                                    m11: 10, m12: 0, m13: 0, m14: 0, 
////                                    m21: 0, m22: 10, m23: 0, m24: 0, 
////                                    m31: 0, m32: 0, m33: 1, m34: 0, 
////                                    m41: 0, m42: 0, m43: 0, m44: 1)
////                        }
//                   })
//                }
//                .addDisposableTo(disposeBag)
//                wordText.addGestureRecognizer(pressGesture)
//                wordText.userInteractionEnabled = true
//                //self.view?.addGestureRecognizer(pressGesture)
//            
//        }
    }
    

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let theTouch = touches.first! as? UITouch else {return}
        let location = theTouch.locationInView(self.view)
        
        //let touchCount = touches.count
        //let tapCount = theTouch.tapCount
        
        self.wordsLabels.forEach { w in 
                // Convert the location of the obstacle view to this view controller's view coordinate system
                let objectTouch = self.view.convertRect(w.frame, fromView: w.superview)
                
                // Check if the touch is inside the obstacle view
                if CGRectContainsPoint(objectTouch, location) {
                   
                    print("start", phonemesLabels.count, "snappoint", snapPoints.count)
                    phonemesLabels.forEach ({ pho in
                        pho.removeFromSuperview()
                        
                        phonemesLabels = []
                        snapPoints = []
                    })
                    
                }
            
        }
        
      
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        guard let theTouch = touches.first! as? UITouch else {return}
        let location = theTouch.locationInView(self.view)
        
     
        
        self.wordsLabels.forEach { w in 
            // Convert the location of the obstacle view to this view controller's view coordinate system
            let objectTouch = self.view.convertRect(w.frame, fromView: w.superview)
            
            // Check if the touch is inside the obstacle view
            if CGRectContainsPoint(objectTouch, location) {
                
                w.backgroundColor = UIColor.randomColor()
                
                let wordModel = WordModel()
                wordModel.getPho()
                let phonemes = w.text!.characters
                    .map { letter -> String in
                        return String(letter)
                    }
                    .map { letter in
                    
                    return wordModel.chosenLetter[letter]![Int.random(0, max: (wordModel.chosenLetter[letter]!.count)-1)]
                }                 
                print( w.text, phonemes.count, phonemes )
                
               
                for letter in 0 ..< phonemes.count {
                   
                    let widthOffset = (self.width) / CGFloat(phonemes.count)
                    let newX = self.startX + (CGFloat(letter) * widthOffset)
                    
                    self.snapPoints.append(CGPointMake( newX+(widthOffset/2) , self.startY+(self.phonemesHeight/2) ))
                    
                    let frame = CGRect(x: w.center.x, y: w.center.y, width: widthOffset, height: w.frame.size.height)
                    
                    phonemesLabels.append( self.createBox(frame, color: w.backgroundColor!, text: phonemes[letter]))
                    
                   // print(phonemes.count)
                }
                    
                print("after added something",phonemesLabels.count, "added snappoint", snapPoints.count)
                for pho in 0 ..< phonemesLabels.count {
                    
                    self.snapBehavior = UISnapBehavior(item: phonemesLabels[pho], snapToPoint: self.snapPoints[pho])
                    self.animator?.addBehavior(self.snapBehavior)
                    
                }
                
                wordsLabels.toObservable()
                .doOnNext({ l in
                                  
                    if l != w
                    {
                        UIView.animateWithDuration(0.5) {
                            l.alpha = 0.0
                        } 
                    }
                    
                })
                .flatMap { gesture -> Observable<Int64> in
                    // say phoneme
                    //let utt = AVSpeechUtterance(string: self.phonemesLabels[0].text!)
                   //  say word
                    //let utt = AVSpeechUtterance(string: w.text!)

                    //self.speech.speakUtterance(utt)
                     
                 
                    return Observable<Int64>
                        .timer(1, scheduler: MainScheduler.instance)
                                        
                }
                .doOnNext({ tick in
                    
                    self.wordsLabels.forEach { allLabel in
                        
                        UIView.animateWithDuration(0.5) {
                            allLabel.alpha = 1.0
                        } 
                        
                    }
                })
                .subscribeNext { tick in
                        
                    self.phonemesLabels.forEach ({ pho in
                        
                        self.snapBehavior = UISnapBehavior(item: pho, snapToPoint: w.center)
                        self.animator?.addBehavior(self.snapBehavior)
                    })
                }
                
            
                print("object finish ", objectTouch, phonemesLabels.count,"snap finish", snapPoints.count)
            }
            
        }

    }
    
    func createBox(frame: CGRect, color: UIColor, text: String) -> UILabel {
        
        let newBox = UILabel()
        newBox.frame = frame
        newBox.backgroundColor = color
        newBox.textColor = UIColor.blackColor()
        newBox.textAlignment = .Center        
        newBox.text = text
        newBox.font = newBox.font.fontWithSize(10.0)
        newBox.layer.cornerRadius = 0
        newBox.layer.masksToBounds = true
        
        self.view.addSubview(newBox)
        return newBox
    }
   
    func wordList(word:String) -> [String]
    {
        var wordArr = [String]()
        word.enumerateSubstringsInRange(word.startIndex..<word.endIndex, options: .ByWords) { 
            ss, r, r2, stop in
            wordArr.append(ss!)
        }
        return wordArr
    }
    
}