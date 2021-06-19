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
                              option4: "Saturday",
                              correctOption: 4),
                     Question(title: "What framework are we using?",
                              option1: "UIKit",
                              option2: "SwiftUI",
                              option3: "React Native",
                              option4: "Flutter",
                              correctOption: 2),
                     Question(title: "Which company created Swift?",
                              option1: "Apple",
                              option2: "Orange",
                              option3: "Google",
                              option4: "Tinkercademy",
                              correctOption: 1)]
    //Celeste: tried to do something here
    @State var currentQuestion = 0
    @State var correctAnswers = 0
    
    @State var isAlertPresented = false
    @State var isCorrect = false
    
    @State var isModalPresented = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                VStack {
                    Text(questions[currentQuestion].title)
                        .padding()
                        .foregroundColor(.white)
                    
                    VStack {
                        ProgressView(value: Double(currentQuestion),
                                             total: Double(questions.count))
                                    .padding()

                        HStack {
                            
                            Button{
                                didTapOption(optionNumber: 1)
                            } label: {
    //                            Image(systemName: "star.fill")
                                Text(questions[currentQuestion].option1)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.red)
    //                        .padding()
                            .cornerRadius(10)
                            Button(questions[currentQuestion].option2) {
                                didTapOption(optionNumber: 2)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .background(Color.blue)
    //                        .padding()
                            .cornerRadius(10)
                        }
                        .padding()
                        HStack {
                            Button(questions[currentQuestion].option3) {
                                didTapOption(optionNumber: 3)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellow)
                            .foregroundColor(.white)
    //                        .padding()
                            .cornerRadius(10)
                            Button(questions[currentQuestion].option4) {
                                didTapOption(optionNumber: 4)
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
    //                        .padding()
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Question \(currentQuestion+1)", displayMode: .large)
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
        }.sheet(isPresented: $isModalPresented, onDismiss: {
            correctAnswers = 0
        }) {
            ResultsScreen(score: correctAnswers, totalQuestions: questions.count)
//            correctAnswers = 0
        }
            
    }
    
    func didTapOption(optionNumber: Int) {
        if optionNumber == questions[currentQuestion].correctOption {
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
