//
//  GameView.swift
//  WordsGame
//
//  Created by Денис Александров on 18.10.2022.
//

import SwiftUI

struct GameView: View {
    
    @State private var word = ""
    var viewModel: GameViewModel
    @State private var confirmPresent = false
    @State private var isAlertPresent = false
    @State var alertText = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        VStack(spacing: 16) {
            HStack {
                Button {
                    
                    confirmPresent.toggle()
                    
                } label: {
                    Text("Выход")
                        .padding(6)
                        .padding(.horizontal)
                        .background(Color("Oranje"))
                        .cornerRadius(20)
                        .padding(6)
                        .foregroundColor(.white)
                        .font(.custom("AvrnirNext-Bold",
                                      size: 20))
                }
                
                Spacer()
            }
            
            Text(viewModel.word)
                .font(.custom("AvrnirNext-Bold",
                              size: 30))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                
                VStack {
                    Text("\(viewModel.player1.score)")
                        .font(.custom("AvrnirNext-Bold",
                                      size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player1.name)")
                        .font(.custom("AvrnirNext-Bold",
                                      size: 24))
                        .foregroundColor(.white)
                    
                }.padding(20)
                    .frame(width: screen.width / 2.2,
                           height: screen.width / 2.2)
                    .background(Color("FirstPlayer"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .blue : .clear,
                            radius: 4,
                            x: 0,
                            y: 0)
                
                VStack {
                    Text("\(viewModel.player2.score)")
                        .font(.custom("AvrnirNext-Bold",
                                      size: 60))
                        .foregroundColor(.white)
                    Text("\(viewModel.player2.name)")
                        .font(.custom("AvrnirNext-Bold",
                                      size: 24))
                        .foregroundColor(.white)
                    
                }.padding(20)
                    .frame(width: screen.width / 2.2,
                           height: screen.width / 2.2)
                    .background(Color("SecondColor"))
                    .cornerRadius(26)
                    .shadow(color: viewModel.isFirst ? .clear : .purple,
                            radius: 4,
                            x: 0,
                            y: 0)
                
            }
            
            WordTextField(word: $word,
                          placeholder: "Ваше слово ...")
                .padding(.horizontal)
            
            Button {
                
                var score = 0
                
                do{
                    try score = viewModel.chek(word: word)
                } catch WordError.beforWord {
                    alertText = "Ваше слово"
                    isAlertPresent.toggle()
                } catch WordError.litleWord {
                    alertText = "Слишком короткое слово"
                    isAlertPresent.toggle()
                } catch WordError.theSameWord {
                    alertText = "Думаешь самый умный? составленное слово не должно быть исходным словом"
                    isAlertPresent.toggle()
                } catch WordError.wrongWord {
                    alertText = "Такое слово не может быть составенно"
                    isAlertPresent.toggle()
                } catch {
                    alertText = "Неизвестная ошибка"
                    isAlertPresent.toggle()
                }
                
                if score > 1 {
                    self.word = ""
                }
                
            } label: {
                Text("Готово!")
                    .padding(12)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .background(Color("Oranje"))
                    .cornerRadius(12)
                    .font(.custom("AvrnirNext-Bold",
                                  size: 26))
                    .padding(.horizontal)
                
            }
            
            List {
                
                ForEach(0 ..< self.viewModel.words.count, id: \.description) { item in
                    WordCell(word: self.viewModel.words[item])
                        .background(item % 2 == 0 ? Color("FirstPlayer")  : Color("SecondColor"))
                        .listRowInsets(EdgeInsets())
                }
                
            }.listStyle(.plain)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }.background(Image("backgroung"))
        
            .confirmationDialog("Вы уверены что хотите завершить игру ?",
                                isPresented: $confirmPresent,
                                titleVisibility: .visible) {
                
                Button(role: .destructive) {
                    self.dismiss()
                } label: {
                    Text("Да")
                }
                Button(role: .cancel) { }  label: {
                    Text("Нет")
                }
            }
                .alert(alertText,
                isPresented: $isAlertPresent) {
                   Text("ok, понял...")
                                }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(viewModel: GameViewModel(player1: Player(name: "Иван"),
                                          player2: Player(name: "Федя"),
                                          word: "Эпидемия"))
    }
}















