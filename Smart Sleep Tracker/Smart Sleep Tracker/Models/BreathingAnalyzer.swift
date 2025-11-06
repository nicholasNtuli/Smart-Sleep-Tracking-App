//
//  BreathingAnalyzer.swift
//  Smart Sleep Tracker
//
//  Created by Sihle Ntuli on 2025/11/06.
//

import Foundation
import AVFoundation
import Accelerate

public class BreathingAnalyzer {
    private let audioEngine = AVAudioEngine()
    private var breathingReadings: [BreathingReading] = []
    private let frequencyThreshold: Float = 0.05
    
    public func analyzeBreathingPatterns(from audioBuffer: AVAudioPCMBuffer?) -> [BreathingReading] {
        guard let buffer = audioBuffer else { return [] }
        
        guard let channelData = buffer.floatChannelData?.pointee else { return [] }
        let frameLength = Int(buffer.frameLength)
        
        let audioArray = Array(UnsafeBufferPointer(start: channelData, count: frameLength))
        
        let breathingFrequency = extractBreathingFrequency(audioArray)
        let reularity = calculateBreathingRegularity(audioArray)
        let amplitude = calculateAmplitude(audioArray)
        
        let reading = BreathingReading(
            timestamp: Date(),
            frequency: breathingFrequency,
            amplitude: amplitude,
            regularity: reularity
        )
        
        breathingReadings.append(reading)
        return []
    }

    /// Estimates a person’s breathing rate (in breaths per minute)
    /// From a short audio sample by analyzing its dominant low-frequency pattern.
    private func extractBreathingFrequency(_ audioArray: [Float]) -> Double {
        // Make sure the signal length fits an FFT
        let n = audioArray.count
        let log2n = vDSP_Length(floor(log2(Float(n))))
        let fftLength = 1 << log2n
        if fftLength < 32 { return 0 }
        
        // Use only as many samples as needed for the FFT
        var signal = Array(audioArray.prefix(fftLength))
        
        // Normalize the signal to keep values within [-1, 1]
        var maxVal: Float = 0
        vDSP_maxv(signal, 1, &maxVal, vDSP_Length(fftLength))
        
        if maxVal > 0 {
            var scale = max(1.0, maxVal)
            vDSP_vsdiv(signal, 1, &scale, &signal, 1, vDSP_Length(fftLength))
        }
        
        // Prepare FFT setup
        let halfCount = fftLength / 2
        var magnitudeResult: [Float] = []
        
        guard let setup = vDSP_create_fftsetup(log2n, FFTRadix(kFFTRadix2)) else { return 0 }
        defer { vDSP_destroy_fftsetup(setup) }
        
        // Convert the signal into the split-complex format FFT expects
        signal.withUnsafeMutableBufferPointer { signalPtr in
            var tempReal = [Float](repeating: 0, count: halfCount)
            var tempImag = [Float](repeating: 0, count: halfCount)
            
            tempReal.withUnsafeMutableBufferPointer { realPtr in
                tempImag.withUnsafeMutableBufferPointer { imagPtr in
                    var split = DSPSplitComplex(realp: realPtr.baseAddress!,
                                                imagp: imagPtr.baseAddress!)
                    
                    // Convert from interleaved samples to split-complex
                    signalPtr.baseAddress!.withMemoryRebound(to: DSPComplex.self,
                                                             capacity: halfCount) { complexPtr in
                        vDSP_ctoz(complexPtr, 2, &split, 1, vDSP_Length(halfCount))
                    }
                    
                    // Perform the FFT in place
                    vDSP_fft_zrip(setup, &split, 1, log2n, FFTDirection(FFT_FORWARD))
                    
                    // Calculate magnitudes = strength of each frequency
                    var mags = [Float](repeating: 0, count: halfCount)
                    vDSP_zvabs(&split, 1, &mags, 1, vDSP_Length(halfCount))
                    magnitudeResult = mags
                }
            }
        }
        
        // Find the strongest low-frequency peak = breathing rhythm
        let magnitudes = magnitudeResult
        let rangeStart = 10
        let rangeEnd = min(30, magnitudes.count)
        guard rangeEnd > rangeStart else { return 0 }
        
        let range = magnitudes[rangeStart..<rangeEnd]
        guard let maxVal = range.max(),
              let peakIdx = range.firstIndex(of: maxVal) else { return 0 }
        
        // Convert FFT bin index to real-world frequency (Hz)
        let sampleRate: Double = 44100 // Replace with your actual sample rate
        let session = AVAudioSession.sharedInstance()
        print("Current sample rate: \(session.sampleRate)") // need to remove this later
        let frequencyHz = (Double(rangeStart + peakIdx) * sampleRate) / Double(fftLength)
        
        // Convert frequency (Hz) into breaths per minute (BPM)
        let breathsPerMinute = frequencyHz * 60
        return breathsPerMinute
    }
    
    private func calculateBreathingRegularity(_ audioArray: [Float]) -> Double {
        var correlation: [Float] = []
        
        for lag in stride(from: 0, to: audioArray.count / 2, by: 10) {
            var sum: Float = 0
            
            for i in lag..<audioArray.count {
                sum += audioArray[i] * audioArray[i - lag]
            }
            
            correlation.append(sum / Float(audioArray.count - lag))
        }
        
        let maxCorrelation = correlation.max() ?? 1
        let regularityScore = (correlation.filter { $0 > maxCorrelation * 0.7 }.count) / correlation.count
        
        return Double(regularityScore) * 100
    }
    
    private func calculateAmplitude(_ audioArray: [Float]) -> Double {
        guard !audioArray.isEmpty else { return 0 }
        let maxValue = audioArray.map { abs($0) }.max() ?? 0
        return Double(maxValue)
    }
}

