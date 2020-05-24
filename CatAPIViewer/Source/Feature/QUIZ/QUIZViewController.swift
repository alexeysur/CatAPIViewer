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
    
    @IBOutlet weak var toolButtonReset: UIBarButtonItem!
    @IBOutlet weak var toolButtonNext: UIBarButtonItem!
    @IBOutlet weak var activityIndecator: UIActivityIndicatorView!
    
    private var currentBreed = (breedID: 0 , breedShotName: "", breedName: "")
    private var scoreCount = 0
    private var questionCount = 0
    private var countPossibleVariant = 4
    private var quizEnded = false
    
    private var breeds = [Breed]()
    private let jsonParser = JSONParser()
    private let apiConfig = APIConfig()
    private let breedService = BreedService()
    
    private var indexRight: Int = 0
    private var urlImageBreed = String()
    
    private var currentAnswers = [Answer]()
    private var arrayBreed: [String] = []
    private var breedID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        breeds = BreedService.breeds
        resetQuiz()
    }

    // setup init paramenters of QUIZ
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
  
        setupViewProperties()
   
        scoreCount = 0
        questionCount = 1
            
        randomBreed()
        getImagefromURL(from: currentBreed.breedShotName)
        showPossibleAnswer(isRightBreed: (self.currentBreed.breedName))
                                               
        anwButton1.isEnabled = true
        anwButton2.isEnabled = true
        anwButton3.isEnabled = true
        anwButton4.isEnabled = true
                                        
        toolButtonReset.isEnabled = true
        toolButtonNext.isEnabled = true
    }
    
    // setup View's properties
    func setupViewProperties() {
          imgCat.image = UIImage(named: "catPlaceholder")
          lblScoreCount.text = "0"
          lblQuestionCount.text = "1"
        
          anwButton1.layer.borderColor = Color.borderColorButton.cgColor
          anwButton1.layer.borderWidth = 1
          anwButton1.layer.cornerRadius = 5
          anwButton1.layer.backgroundColor = UIColor.white.cgColor
          
          anwButton2.layer.borderColor = Color.borderColorButton.cgColor
          anwButton2.layer.borderWidth = 1
          anwButton2.layer.cornerRadius = 5
          anwButton2.layer.backgroundColor = UIColor.white.cgColor
          
          anwButton3.layer.borderColor = Color.borderColorButton.cgColor
          anwButton3.layer.borderWidth = 1
          anwButton3.layer.cornerRadius = 5
          anwButton3.layer.backgroundColor = UIColor.white.cgColor
          
          anwButton4.layer.borderColor = Color.borderColorButton.cgColor
          anwButton4.layer.borderWidth = 1
          anwButton4.layer.cornerRadius = 5
          anwButton4.layer.backgroundColor = UIColor.white.cgColor
        
          anwButton1.isEnabled = false
          anwButton2.isEnabled = false
          anwButton3.isEnabled = false
          anwButton4.isEnabled = false

          activityIndecator.centerXAnchor.constraint(equalTo: imgCat.centerXAnchor).isActive = true
          activityIndecator.centerYAnchor.constraint(equalTo: imgCat.centerYAnchor).isActive = true
          activityIndecator.isHidden = false
          activityIndecator.startAnimating()
        
    }
    
    
    // get random breed of cat
    func randomBreed()  {
        let id = Int.random(in: 0..<breeds.count-1)
        
        currentBreed.breedID = id
        currentBreed.breedShotName = breeds[id].id
        currentBreed.breedName = breeds[id].name
    }
    
    func randomBreedFromList() -> String {
        let number = Int.random(in: 0...breeds.count)
        return arrayBreed[number]
    }
    
    func randomArrayID() -> Int {
        let arrID = Int.random(in: 0..<countPossibleVariant-1)
        return arrID
    }
    
    // choose four possible variants of answer
    func showPossibleAnswer(isRightBreed: String) {
        var currAnswers: [String] = ["","","",""]
        var currAnswer = Answer()
        
        indexRight = randomArrayID()
  
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
     
        anwButton1.layer.backgroundColor = Color.lightRed.cgColor
        anwButton2.layer.backgroundColor = Color.lightRed.cgColor
        anwButton3.layer.backgroundColor = Color.lightRed.cgColor
        anwButton4.layer.backgroundColor = Color.lightRed.cgColor

        if currentAnswers[answerId].isRight == true {
              scoreCount += 3
              lblScoreCount.text = String(scoreCount)
        } else {
            if scoreCount >= 3 {
                scoreCount -= 3
                lblScoreCount.text = String(scoreCount)
            }
        }
            
        switch indexRight {
         case 0: anwButton1.layer.backgroundColor = Color.salad.cgColor
         case 1: anwButton2.layer.backgroundColor = Color.salad.cgColor
         case 2: anwButton3.layer.backgroundColor = Color.salad.cgColor
         case 3: anwButton4.layer.backgroundColor = Color.salad.cgColor
         default:
             return
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
        
        
        activityIndecator.isHidden = false
        activityIndecator.startAnimating()
        
        randomBreed()
        getImagefromURL(from: currentBreed.breedShotName)
        showPossibleAnswer(isRightBreed: currentBreed.breedName)
        
        anwButton1.isEnabled = true
        anwButton2.isEnabled = true
        anwButton3.isEnabled = true
        anwButton4.isEnabled = true

        toolButtonNext.isEnabled = true
    }
    
    func resetQuiz() {
        toolButtonReset.isEnabled = false
        toolButtonNext.isEnabled = false
   
        setup()

         anwButton1.isEnabled = true
         anwButton2.isEnabled = true
         anwButton3.isEnabled = true
         anwButton4.isEnabled = true
                                           
         toolButtonReset.isEnabled = true
         toolButtonNext.isEnabled = true
    }
    
    @IBAction func pressToolReset(_ sender: UIBarButtonItem) {
        resetQuiz()
   }
    
    func getImagefromURL(from breedID: String?) {
        let jsonURL = apiConfig.fetchURL(with: .images, parameters: [apiConfig.breed_ids: breedID!])
      
      jsonParser.downloadData(of: BreedDetail.self, from: jsonURL!) { (result) in
                  switch result {
                  case .failure(let error):
                      if error is DataError {
                          print("DataError = \(error)")
                      } else {
                          print(error.localizedDescription)
                      }
                  case .success(let breedDetail):
                   DispatchQueue.main.sync {
                         
                    self.setImageToImageView(from: (breedDetail[0].url)!)
                    
                    self.toolButtonReset.isEnabled = true
                    self.toolButtonNext.isEnabled = true
                   }
                      
                  }
                  
              }
     }

      func setImageToImageView(from urlImage: String) {
          jsonParser.fetchImage(from: urlImage) { (imageData, error) in
              if let data = imageData {
                  DispatchQueue.main.async {
                      self.imgCat.image = data
   
                      self.activityIndecator.stopAnimating()
                      self.activityIndecator.isHidden = true
                  }
              } else {
                  print("Error loading image!")
              }
          }
      }
    
}
