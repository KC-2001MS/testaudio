//
//  ContentView.swift
//  Shared
//
//  Created by 茅根啓介 on 2022/04/13.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    let synthesizer = AVSpeechSynthesizer()
    var body: some View {
        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
            let utterance = AVSpeechUtterance(string: "test 123")
            utterance.voice = AVSpeechSynthesisVoice(language: "en")
            var output: AVAudioFile?

            synthesizer.write(utterance) { (buffer: AVAudioBuffer) in
                print("closure called")
                guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                fatalError("フォルダURL取得エラー")
                }
                
                let fileURL = dirURL.appendingPathComponent("test.caf")
               guard let pcmBuffer = buffer as? AVAudioPCMBuffer else {
                  fatalError("unknown buffer type: \(buffer)")
               }
               if pcmBuffer.frameLength == 0 {
               } else {
                 if output == nil {
                     let bufferSettings = utterance.voice?.audioFileSettings
                   output = try? AVAudioFile(
                     forWriting: fileURL,
                     settings: bufferSettings!)
                 }
                   try? output?.write(from: pcmBuffer)
               }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
