//
//  QUIZViewController.swift
//  CatAPIViewer
//
//  Created by Alexey on 5/6/20.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class QUIZViewController: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblQuestionCount: UILabel!
    @IBOutlet weak var lblScoreCount: UILabel!
    
    @IBOutlet weak var imgCat: UIImageView!
    
    @IBOutlet weak var anwButton1: UIButton!
    @IBOutlet weak var anwButton2: UIButton!
    @IBOutlet weak var anwButton3: UIButton!
    @IBOutlet weak var anwButton4: UIButton!
    
    @IBOutlet weak var toolButtonQuit: UIBarButtonItem!
    @IBOutlet weak var toolButtonNext: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var currentBreed = (breedID: 0 , breedShotName: "", breedName: "")
    var scoreCount = 0
    var questionCount = 0
    var countPossibleVariant = 4
    var quizEnded = false
    
    var breeds = [Breed]()
 //   private let apiManager = APIManager()
    let jsonParse = JSONParser()
    
    var indexRight: Int = 0
    var urlImageBreed = String()
    
    var currentAnswers = [Answer]()
    var arrayBreed: [String] = []
    var breedID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resetQuiz()
    }
    
    func setup() {
        
        for breed in breeds {
            arrayBreed.append(breed.name)
        }
        
        for i in 0..<countPossibleVariant-1 {
            var newElement = Answer()
            newElement.response = ""
            newElement.isRight = false
            currentAnswers.insert(newElement, at: i)
        }
        
        anwButton1.layer.borderColor = UIColor(red: 227.0/255.0, green: 99.0/255.0, blue: 54.0/255.0, alpha: 1).cgColor
        anwButton1.layer.borderWidth = 1
        anwButton1.layer.cornerRadius = 5

        anwButton2.layer.borderColor = UIColor(red: 227.0/255.0, green: 99.0/255.0, blue: 54.0/255.0, alpha: 1).cgColor
        anwButton2.layer.borderWidth = 1
        anwButton2.layer.cornerRadius = 5

        anwButton3.layer.borderColor = UIColor(red: 227.0/255.0, green: 99.0/255.0, blue: 54.0/255.0, alpha: 1).cgColor
        anwButton3.layer.borderWidth = 1
        anwButton3.layer.cornerRadius = 5

        anwButton4.layer.borderColor = UIColor(red: 227.0/255.0, green: 99.0/255.0, blue: 54.0/255.0, alpha: 1).cgColor
        anwButton4.layer.borderWidth = 1
        anwButton4.layer.cornerRadius = 5


        anwButton1.isEnabled = false
        anwButton2.isEnabled = false
        anwButton3.isEnabled = false
        anwButton4.isEnabled = false
    }
    
    func randomBreed()  {
        let id = Int.random(in: 0..<breeds.count-1)
        
        currentBreed.breedID = id
        currentBreed.breedShotName = breeds[id].id
        currentBreed.breedName = breeds[id].name
        
        print("currentBreed = \(currentBreed)")
    }
    
    func randomBreedFromList() -> String {
        let number = Int.random(in: 0...breeds.count)
        return arrayBreed[number]
    }
    
    func randomArrayID() -> Int {
        let arrID = Int.random(in: 0..<countPossibleVariant-1)
        return arrID
    }
    
    func showPossibleAnswer(isRightBreed: String) {
        var currAnswers: [String] = ["","","",""]
        var currAnswer = Answer()
        
        indexRight = randomArrayID()
        print("indexRight = \(indexRight)")
        currAnswer.response = isRightBreed
        currAnswer.isRight = true
        currentAnswers.insert(currAnswer, at: indexRight)
        currAnswers[indexRight] = isRightBreed
 
        var randomAnswer: String
        var ind: Int = -1
        while (ind < 3) {
            randomAnswer = randomBreedFromList()
            
            if !currAnswers.contains(randomAnswer) {
                ind += 1
                if ind != indexRight {
                    currAnswers[ind] = randomAnswer
                    currentAnswers[ind].response = randomAnswer
                } else {
                    if ind < currAnswers.count-1 {
                        ind += 1
                        currAnswers[ind] = randomAnswer
                        currentAnswers[ind].response = randomAnswer
                        
                    }
                        
                }
            }
        }
        anwButton1.setTitle(currentAnswers[0].response, for: UIControl.State())
        anwButton2.setTitle(currentAnswers[1].response, for: UIControl.State())
        anwButton3.setTitle(currentAnswers[2].response, for: UIControl.State())
        anwButton4.setTitle(currentAnswers[3].response, for: UIControl.State())
    }
    
    
    @IBAction func tooButtonNext(_ sender: Any) {
        nextQuestion()
    }
    
    @IBAction func pressAnsButton1(_ sender: UIButton) {
        selectAnswer(0)
    }
    
    @IBAction func pressAnsButton2(_ sender: UIButton) {
        selectAnswer(1)
    }
    
    @IBAction func pressAnsButton3(_ sender: UIButton) {
        selectAnswer(2)
    }
    
    @IBAction func pressAnsButton4(_ sender: UIButton) {
        selectAnswer(3)
    }
    
    func selectAnswer(_ answerId : Int) -> Void {
     
 anwButton1.layer.backgroundColor = UIColor.red.cgColor
 anwButton2.layer.backgroundColor = UIColor.red.cgColor
 anwButton3.layer.backgroundColor = UIColor.red.cgColor
 anwButton4.layer.backgroundColor = UIColor.red.cgColor
        
        
        if currentAnswers[answerId].isRight == true {
            scoreCount += 3
            lblScoreCount.text = String(scoreCount)
              switch answerId {
                             case 0: anwButton1.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor
                             case 1: anwButton2.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor
                             case 2: anwButton3.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor
                             case 3: anwButton4.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor

                       default:
                           return
                        }
            
            
        } else {
            switch indexRight {
                           case 0: anwButton1.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor
                           case 1: anwButton2.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor
                           case 2: anwButton3.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor
                           case 3: anwButton4.layer.backgroundColor = UIColor(red: 56/255, green: 227/255, blue: 23/255, alpha: 1).cgColor

                    default:
                           return
                    }
            if scoreCount >= 3 {
                scoreCount -= 3
                lblScoreCount.text = String(scoreCount)
                
            }
        }
        
        
        anwButton1.isEnabled = false
        anwButton2.isEnabled = false
        anwButton3.isEnabled = false
        anwButton4.isEnabled = false
    }
    
    func nextQuestion() {
        toolButtonNext.isEnabled = false
        
        anwButton1.layer.backgroundColor = UIColor.white.cgColor
        anwButton2.layer.backgroundColor = UIColor.white.cgColor
        anwButton3.layer.backgroundColor = UIColor.white.cgColor
        anwButton4.layer.backgroundColor = UIColor.white.cgColor
    
        
        questionCount += 1
        lblQuestionCount.text = String(questionCount)
        imgCat.image = UIImage(named: "catPlaceholder")
        
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        randomBreed()
        getImagefromURL(from: currentBreed.breedShotName)
        showPossibleAnswer(isRightBreed: currentBreed.breedName)
        
        anwButton1.isEnabled = true
        anwButton2.isEnabled = true
        anwButton3.isEnabled = true
        anwButton4.isEnabled = true

        
    }
    
    func resetQuiz() {
        toolButtonQuit.isEnabled = false
        toolButtonNext.isEnabled = false
        
               scoreCount = 0
               lblScoreCount.text = "0"
               lblQuestionCount.text = "1"
               questionCount = 1
            
               anwButton1.layer.backgroundColor = UIColor.white.cgColor
               anwButton2.layer.backgroundColor = UIColor.white.cgColor
               anwButton3.layer.backgroundColor = UIColor.white.cgColor
               anwButton4.layer.backgroundColor = UIColor.white.cgColor
               imgCat.image = UIImage(named: "catPlaceholder")
        
               activityIndicator.centerXAnchor.constraint(equalTo: imgCat.centerXAnchor).isActive = true
               activityIndicator.centerYAnchor.constraint(equalTo: imgCat.centerYAnchor).isActive = true
               activityIndicator.isHidden = false
               activityIndicator.startAnimating()
                   
               getBreeds()
        
    }
    
    @IBAction func pressToolQuit(_ sender: UIBarButtonItem) {
        
        resetQuiz()
   }
    
  func getBreeds() {
         apiManager.getBreeds() { [weak self] (breeds, error) in
             if let error = error {
                 print("Get breeds error: \(error.localizedDescription)")
                 return
             }
             
             
             guard let breeds = breeds  else { return }
             DispatchQueue.main.sync {
                self?.breeds = breeds
                self?.setup()
                self?.randomBreed()
               
                self?.getImagefromURL(from: self?.currentBreed.breedShotName)
                self?.showPossibleAnswer(isRightBreed: (self?.currentBreed.breedName)!)
                  
                self?.anwButton1.isEnabled = true
                self?.anwButton2.isEnabled = true
                self?.anwButton3.isEnabled = true
                self?.anwButton4.isEnabled = true
                
                self?.toolButtonQuit.isEnabled = true
                self?.toolButtonNext.isEnabled = true
                
                
            }
    
         }
     }
    
    func getImagefromURL(from breedID: String?) {
              apiManager.getImageBreedForDescription(breedID: breedID!, completion: { [weak self] (imageURL, error) in
                  if let error = error {
                      print("Get url for image of breed error: \(error)")
                      return
                  }
                  guard let breedID = breedID else {return}
                  DispatchQueue.main.sync {
                    self?.urlImageBreed = imageURL!
                    self?.setImageToImageView()
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    self?.toolButtonNext.isEnabled = true
      
                }
              })
      }
    
    func fetchImage(from urlString: String, completion: @escaping (_ data: Data?) -> ()) {
          let session = URLSession.shared
         
          guard let url = URL(string: urlString) else {
              print("Error: Cannot create URL from string")
              return
          }
          let urlRequest = URLRequest(url: url)
          let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
              if error != nil {
                  print("Error fetching the image!")
                  completion(nil)
              } else {
                  completion(data)
              }
              
          }
          dataTask.resume()
      }
      
      func setImageToImageView() {
          fetchImage(from: urlImageBreed) { (imageData) in
              if let data = imageData {
                  
                  DispatchQueue.main.async {
                    self.imgCat.image = UIImage(data: data)
                   
                  }
              } else {
                  print("Error loading image!")
              }
          }
      }
}
