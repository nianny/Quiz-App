//
//  ContentView.swift
//  Quiz
//
//  Created by JiaChen(: on 1/6/21.
//

import SwiftUI

struct ContentView: View {
    
    var questions = [Question(title: "What day is it?",
                              option1: "Monday",
                              option2: "Friday",
                              option3: "Wednesday",
                              option4: "Saturday"),
                     Question(title: "What framework are we using?",
                              option1: "UIKit",
                              option2: "SwiftUI",
                              option3: "React Native",
                              option4: "Flutter"),
                     Question(title: "Which company created Swift?",
                              option1: "Apple",
                              option2: "Orange",
                              option3: "Google",
                              option4: "Tinkercademy")]
    
    @State var currentQuestion = 0
    @State var correctAnswers = 0
    
    @State var isAlertPresented = false
    @State var isCorrect = false
    
    @State var isModalPresented = false
    
    var body: some View {
        VStack {
            Text(questions[currentQuestion].title)
                .padding()
            
            HStack {
                VStack {
                    Button(questions[currentQuestion].option1) {
                        didTapOption(optionNumber: 1)
                    }
                    Button(questions[currentQuestion].option2) {
                        didTapOption(optionNumber: 2)
                    }
                }
                .padding()
                VStack {
                    Button(questions[currentQuestion].option3) {
                        didTapOption(optionNumber: 3)
                    }
                    Button(questions[currentQuestion].option4) {
                        didTapOption(optionNumber: 4)
                    }
                }
                .padding()
            }
            .padding()
        }
        .alert(isPresented: $isAlertPresented) {
            
            Alert(title: Text(isCorrect ? "Correct" : "Wrong"),
                  message: Text(isCorrect ? "Congrats, you are kinda smart." : "This is outrageous, with such easy questions, how can you be getting this wrong?!"),
                  dismissButton: .default(Text("OK")) {
                    currentQuestion += 1
                    
                    if currentQuestion == questions.count {
                        isModalPresented = true
                        currentQuestion = 0
                    }
                  })
        }.sheet(isPresented: $isModalPresented) {
            ResultsScreen(score: correctAnswers, totalQuestions: questions.count)
        }
    }
    
    func didTapOption(optionNumber: Int) {
        if optionNumber == 2 {
            print("Correct!")
            isCorrect = true
            correctAnswers += 1
        } else {
            print("Wrong!")
            isCorrect = false
        }
        isAlertPresented = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
