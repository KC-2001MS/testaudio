//
//  ContentView.swift
//  Shared
//
//  Created by 茅根啓介 on 2022/04/13.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    var body: some View {
        
        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
            let synthesizer = AVSpeechSynthesizer()
            let utterance = AVSpeechUtterance(string: "test 123")
            utterance.voice = AVSpeechSynthesisVoice(language: "en")
            var output: AVAudioFile?

            synthesizer.write(utterance) { (buffer: AVAudioBuffer) in
               guard let pcmBuffer = buffer as? AVAudioPCMBuffer else {
                  fatalError("unknown buffer type: \(buffer)")
               }
               if pcmBuffer.frameLength == 0 {
                 // done
               } else {
                 // append buffer to file
                 if output == nil {
                   output = try? AVAudioFile(
                     forWriting: URL(fileURLWithPath: NSHomeDirectory() + "test.caf"),
                     settings: pcmBuffer.format.settings,
                     commonFormat: .pcmFormatInt16,
                     interleaved: false)
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
