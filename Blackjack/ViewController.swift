//
//  ViewController.swift
//  Blackjack
//
//  Created by Max Ong on 5/05/2016.
//  Copyright © 2016 Max Ong. All rights reserved.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {
    var PlayerView = UIView()
    var DealerView = UIView()
    var deck = ["Hearts01", "Hearts02", "Hearts03", "Hearts04", "Hearts05", "Hearts06", "Hearts07", "Hearts08", "Hearts09", "Hearts10", "HeartsJ10", "HeartQ10", "HeartsK10", "Diamonds01", "Diamonds02", "Diamonds03", "Diamonds04", "Diamonds05", "Diamonds06", "Diamonds07", "Diamonds08", "Diamonds09", "Diamonds10", "DiamondsJ10", "DiamondsQ10", "DiamondsK10", "Spades01", "Spades02", "Spades03", "Spades04", "Spades05", "Spades06", "Spades07", "Spades08", "Spades09", "Spades10", "SpadesJ10", "SpadesQ10", "SpadesK10", "Clubs01", "Clubs02", "Clubs03", "Clubs04", "Clubs05", "Clubs06", "Clubs07", "Clubs08", "Clubs09", "Clubs10", "ClubsJ10", "ClubsQ10", "ClubsK10"]
    var gameover = false
    var newDeck = [String]()
    var Playerhand = [String]()
    var Dealerhand = [String]()
    var PlayerX = 10
    var PlayerY = 10
    var DealerX = 10
    var Playertotal = 0
    var Dealertotal = 0
    var counter1 = 2
    var counter2 = 2
    var pScore = UILabel(frame: CGRect(x: 100, y: 30, width: 200, height: 21))
    var dScore = UILabel(frame: CGRect(x: 100, y: 30, width: 200, height: 21))


    override func viewDidLoad() {
        initDeck()
        createViews()
    }
    func createViews() {
        initPlayerHand()
        self.view.backgroundColor = UIColor.redColor()
        PlayerView.frame = CGRect(x: 10, y: 15, width: 300, height: 200)
        PlayerView.backgroundColor=UIColor.grayColor()
        PlayerView.layer.cornerRadius=1
        PlayerView.layer.borderWidth=0
        self.view.addSubview(PlayerView)
        createHitButton()
        createStandButton()
        PlayerScore()
        createPlayerImgHolders()

        createNewGameButton()

        initDealerHand()
        DealerView.frame = CGRect(x: 10, y: 325, width: 300, height: 200)
        DealerView.backgroundColor=UIColor.grayColor()
        DealerView.layer.cornerRadius=1
        DealerView.layer.borderWidth=0
        self.view.addSubview(DealerView)
        createDealerImgHolders()
    }
    func makePImageHolder(xPos: Int, yPos: Int, imgName: String) {
        let img = UIImageView()
        img.frame = CGRectMake(CGFloat(xPos), CGFloat(yPos), 65, 100)
        img.image = UIImage(named: imgName)
        self.PlayerView.addSubview(img)
    }
    func makeDImageHolder(xPos: Int, yPos: Int, imgName: String) {
        let img = UIImageView()
        img.frame = CGRectMake(CGFloat(xPos), CGFloat(yPos), 65, 100)
        img.image = UIImage(named: imgName)
        self.DealerView.addSubview(img)

    }
    func createPlayerImgHolders() {
        let card1 = String(Playerhand[0])
        let card2 = String(Playerhand[1])
        PlayerX = 10
        makePImageHolder(PlayerX, yPos: 10, imgName: card1)
        PlayerX += 20
        makePImageHolder(PlayerX, yPos: 10, imgName: card2)

    }
    func createDealerImgHolders() {
        makeDImageHolder(DealerX, yPos: 10, imgName: "cardback")
        DealerX += 20
        makeDImageHolder(DealerX, yPos: 10, imgName: "cardback")

    }
    func initPlayerHand() {
        Playerhand.append(newDeck.removeFirst())
        Playerhand.append(newDeck.removeFirst())
        Playertotal = Int(String(Playerhand[0].characters.suffix(2)))! + Int(String(Playerhand[1].characters.suffix(2)))!
    }

    func initDealerHand() {
        Dealerhand.append(newDeck.removeFirst())
        Dealerhand.append(newDeck.removeFirst())

        Dealertotal = Int(String(Dealerhand[0].characters.suffix(2)))! + Int(String(Dealerhand[1].characters.suffix(2)))!
    }

    func initDeck() {
        //shuffle the deck using GameplayKit
        let shuffledDeck = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(deck)
        //append the items from the shuffled deck and force them to become Strings (they were Objects)
        for item in shuffledDeck {
            newDeck.append(item as! String)
        }
    }
    func FlipDealerCards() {
        DealerX = 10
        let card1 = String(Dealerhand[0])
        let card2 = String(Dealerhand[1])

        makeDImageHolder(DealerX, yPos: 10, imgName: card1)
        DealerX += 20
        makeDImageHolder(DealerX, yPos: 10, imgName: card2)

        DealerScore()
    }
    func createHitButton() {
        let button = UIButton()
        button.frame = CGRect(x: 10, y: 115, width: 34, height: 20)
        button.backgroundColor = UIColor.blackColor()
        button.layer.cornerRadius=1
        button.setTitle("Hit", forState: UIControlState.Normal)
        button.titleLabel!.font =  UIFont(name: "Helvetica Neue", size: 10)
        button.addTarget(self, action:Selector("hitButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)

        self.PlayerView.addSubview(button)
    }
    func createStandButton() {
        let button = UIButton()
        button.frame = CGRect(x: 50, y: 115, width: 50, height: 20)
        button.backgroundColor = UIColor.blackColor()
        button.layer.cornerRadius=10
        button.setTitle("Stand", forState: UIControlState.Normal)
        button.titleLabel!.font =  UIFont(name: "Helvetica Neue", size: 10)
        button.addTarget(self, action:Selector("standButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)

        self.PlayerView.addSubview(button)
    }
    func createNewGameButton() {
        let button = UIButton()
        button.frame = CGRect(x: 10, y: 275, width: 60, height: 20)
        button.backgroundColor = UIColor.blackColor()
        button.layer.cornerRadius=1
        button.setTitle("New Game", forState: UIControlState.Normal)
        button.titleLabel!.font =  UIFont(name: "Helvetica Neue", size: 10)
        button.addTarget(self, action:Selector("NGButtonAction"), forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(button)

    }
    func DealerTotal() {
        while Dealertotal < 17 {
            DealerX += 20
            Dealerhand.append(newDeck.removeFirst())
            makeDImageHolder(DealerX, yPos: PlayerY, imgName:String(Dealerhand[counter2]))
            Dealertotal += Int(String(Dealerhand[counter2].characters.suffix(2)))!
            counter2 += 1
            dScore.text = String("Your total: \(Dealertotal)")
        }
    }
    func checkWinner() {
        if Dealertotal > 21 {
            Winfunc()
        } else if Dealertotal >= Playertotal {
            Losefunc()
        } else if Dealertotal < Playertotal {
            Winfunc()
        } else if Dealertotal == 21 {
            Losefunc()
        }
    }
    func standButtonAction() {
        FlipDealerCards()
        DealerTotal()
        checkWinner()
    }

    func NGButtonAction() {
        PlayerView.removeFromSuperview()
        DealerView.removeFromSuperview()
        pScore.removeFromSuperview()
        dScore.removeFromSuperview()
        initallVariables()
        initDeck()
        createViews()

    }
    func initallVariables() {
        PlayerView = UIView()
        DealerView = UIView()
        gameover = false
        newDeck = [String]()
        Playerhand = [String]()
        Dealerhand = [String]()
        PlayerX = 10
        PlayerY = 10
        DealerX = 10
        Playertotal = 0
        Dealertotal = 0
        counter1 = 2
        counter2 = 2
        pScore = UILabel(frame: CGRect(x: 100, y: 30, width: 200, height: 21))
        dScore = UILabel(frame: CGRect(x: 100, y: 30, width: 200, height: 21))
    }

    func hitButtonAction() {
        PlayerX += 20
        Playerhand.append(newDeck.removeFirst())
        makePImageHolder(PlayerX, yPos: PlayerY, imgName:String(Playerhand[counter1]))
        Playertotal += Int(String(Playerhand[counter1].characters.suffix(2)))!
        counter1 += 1
        if Playertotal > 21 {
            Losefunc()
        } else if Playertotal == 21 {
            Winfunc()
        }
        pScore.text = String("Your total: \(Playertotal)")

    }
    func DealerScore() {
        dScore.center = CGPoint(x: 43, y: 120)
        dScore.font = UIFont(name: dScore.font.fontName, size: 10)
        dScore.textAlignment = NSTextAlignment.Center
        dScore.text = String("Dealer total: \(Dealertotal)")
        self.DealerView.addSubview(dScore)
    }
    func PlayerScore() {
        pScore.center = CGPoint(x: 43, y: 150)
        pScore.font = UIFont(name: pScore.font.fontName, size: 10)
        pScore.textAlignment = NSTextAlignment.Center
        pScore.text = String("Your total: \(Playertotal)")
        self.PlayerView.addSubview(pScore)
    }
    func Winfunc() {
        FlipDealerCards()
        let WinMsg = "You win"
        let Winalert = UIAlertController(title:"YOU GOT \(Playertotal)!!", message: WinMsg, preferredStyle:.Alert)
        let action = self.okAction()
        Winalert.addAction(action)
        presentViewController(Winalert, animated: true, completion: nil)
    }
    func Losefunc() {
        FlipDealerCards()
        let myMsg = "You lose!"
        let alert = UIAlertController(title:"YOUR RESULT:\(Playertotal)", message: myMsg, preferredStyle:.Alert)
        let action = self.okAction()
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    }
    func okAction() -> UIAlertAction {
        let action = UIAlertAction(title: "OK", style: .Default) { (action) in
            //if you were doing something that took a bit of time you could start a spinner here
            self.NGButtonAction()
            //and then remove it here
        }
        return action
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
