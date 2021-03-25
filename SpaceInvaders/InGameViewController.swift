//
//  InGameViewController.swift
//  SpaceInvaders
//
//  Created by Admin on 08.03.2021.
//  Copyright © 2021 Admin. All rights reserved.
//

import UIKit

class InGameViewController: UIViewController {

    @IBOutlet var InGameView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var GameOverText: UILabel!
    var player: Player? = nil
    var bullet: Bullet? = nil
    var firing: Bool = false
    var asteroids: [Asteroid] = []
    var score: Int = 0
    weak var firingTimer: Timer?
    weak var spawnTimer: Timer?
    weak var asteroidTimer: Timer?
    weak var checkIntersectionTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let playerRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        player = Player(frame: playerRect)
        mainView.addSubview(player!)
        firingTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {_ in
            if let bullet = self.bullet {
                bullet.center.y -= self.mainView.frame.height/50
                if (bullet.center.y <= -50) {
                    bullet.removeFromSuperview()
                    self.bullet = nil
                    self.firing = false
                }
            }
        }
        spawnTimer = Timer.scheduledTimer(withTimeInterval: 7.0, repeats: true){_ in
            let firstPosition = Bool.random()
            let secondPosition = Bool.random()
            let thirdPosition = Bool.random()
            let fourthPosition = Bool.random()
            let fifthPosition = Bool.random()
            let initialAsteroidRect = CGRect(x: 0, y: -100, width: 50, height: 50)
            if (firstPosition) {
                let asteroid = Asteroid(frame: initialAsteroidRect)
                asteroid.center.x = 20
                self.mainView.addSubview(asteroid)
                self.asteroids.append(asteroid)
            }
            if (secondPosition) {
                let asteroid = Asteroid(frame: initialAsteroidRect)
                asteroid.center.x = self.mainView.frame.width / 4
                self.mainView.addSubview(asteroid)
                self.asteroids.append(asteroid)
            }
            if (thirdPosition) {
                let asteroid = Asteroid(frame: initialAsteroidRect)
                asteroid.center.x = self.mainView.frame.width / 2
                self.mainView.addSubview(asteroid)
                self.asteroids.append(asteroid)
            }
            if (fourthPosition) {
                let asteroid = Asteroid(frame: initialAsteroidRect)
                asteroid.center.x = self.mainView.frame.width / 4 * 3
                self.mainView.addSubview(asteroid)
                self.asteroids.append(asteroid)
            }
            if (fifthPosition) {
                let asteroid = Asteroid(frame: initialAsteroidRect)
                asteroid.center.x = self.mainView.frame.width - 20
                self.mainView.addSubview(asteroid)
                self.asteroids.append(asteroid)
            }
        }
        asteroidTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) {_ in
            for asteroid in self.asteroids {
                if (asteroid.center.y >= self.mainView.frame.height + 50) {
                    self.GameOver()
                }
                asteroid.center.y += self.mainView.frame.height/400
            }
        }
        checkIntersectionTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){_ in
            var i = 0;
            for asteroid in self.asteroids {
                if let bullet = self.bullet {
                    if(asteroid.frame.intersects(bullet.frame)) {
                        self.score += 10
                        self.firing = false
                        self.asteroids.remove(at: i)
                        asteroid.removeFromSuperview()
                        bullet.removeFromSuperview()
                        self.bullet = nil
                    }
                }
                if let player = self.player {
                    if (asteroid.frame.intersects(player.frame)) {
                        self.GameOver()
                    }
                }
                i += 1
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let player = player {
            player.center = CGPoint(x: mainView.frame.width/2, y: mainView.frame.height - player.frame.height)
        }
    }
    
    func GameOver() {
        print("START")
        for asteroid in asteroids {
            asteroid.removeFromSuperview()
        }
        GameOverText.text = "GAME OVER\n Your score: \(score)"
        player?.removeFromSuperview()
        bullet?.removeFromSuperview()
        mainView.setNeedsDisplay()
        mainView.setNeedsLayout()
        GameOverText.setNeedsDisplay()
        GameOverText.setNeedsLayout()
        asteroids.removeAll()
        player = nil
        bullet = nil
        score = 0
        firingTimer?.invalidate()
        spawnTimer?.invalidate()
        asteroidTimer?.invalidate()
        checkIntersectionTimer?.invalidate()
        print("FINISH")
        Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) {_ in
            let inGameViewController : InGameViewController = InGameViewController()
            self.show(inGameViewController, sender: self)
        }
    }
    
    @IBAction func FireButtonTouched(_ sender: Any) {
        if (firing) {
            return
        }
        else {
            if let player = player {
                firing = true
                let bulletRect = CGRect(x: 0, y: 0, width: 25, height: 25)
                bullet = Bullet(frame: bulletRect)
                bullet?.center = CGPoint(x: player.center.x, y: player.center.y - 35)
                mainView.addSubview(bullet!)
            }
        }
    }
 
    @IBAction func RightButtonTouched(_ sender: Any) {
        if let player = player {
            if (player.center.x >= mainView.frame.width - player.frame.width/2) {
                return
            }
            else {
                UIView.animate(withDuration: 0.15, animations: { self.player?.center.x += 15})
            }
        }
    }
    
    @IBAction func LeftButtonTouched(_ sender: Any) {
        if let player = player {
            if (player.center.x <= 0 + player.frame.width/2) {
                return
            }
            else {
                UIView.animate(withDuration: 0.15, animations: { self.player?.center.x -= 15})
            }
        }
    }
}
