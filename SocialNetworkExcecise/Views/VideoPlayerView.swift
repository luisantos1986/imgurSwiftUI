//
//  VideoPost.swift
//  SocialNetworkExcecise
//
//  Created by Luis Eugenio Santos Gonzalez on 28/12/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {

    private var videoURL : URL?
    var loadedVideo: AVAsset?
    @State private var player: AVPlayer?
    @Binding var loadedPost: LoadedPost
    @State private var isMuted: Bool = true
    var showMuteButton: Bool
    var namespace: Namespace.ID
    let paused: Bool

    init(url: URL? = nil, 
         loadedVideo: AVAsset? = nil,
         showMuteButton: Bool = true,
         loadedPost: Binding<LoadedPost>,
         namespace: Namespace.ID,
         paused: Bool) {
        self.loadedVideo = loadedVideo
        self.showMuteButton = showMuteButton
        self._loadedPost = loadedPost
        self.videoURL = url
        self.namespace = namespace
        self.paused = paused
    }

    var body: some View {
        VideoPlayer(player: player)
            .matchedGeometryEffect(id: loadedPost.id, in: namespace)
            .onFirstAppear {
                Task {
                    player = AVPlayer()
                    if let asset = loadedVideo {
                        let item = AVPlayerItem(asset: asset)
                        player?.replaceCurrentItem(with: item)
                    }
                    if let videoURL = self.videoURL {
                        await loadPlayerItem(videoURL)
                    }
                    await playPlayer()

                }//: Task
            }//: onFirstAppear
            .onDisappear() {
                Task {
                    // Stop the player when the view disappears
                    await MainActor.run { player?.pause() }
                }
            }
            .overlay(alignment: .topTrailing) {
                if showMuteButton {
                    Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                        .font(.footnote)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.gray.opacity(0.3))
                        .clipShape(Circle())
                        .padding()
                        .onTapGesture {
                            player?.isMuted.toggle()
                            self.isMuted = player?.isMuted ?? false
                        }
                }
            }
    }

    func playPlayer() async {
        await MainActor.run {
            player?.isMuted = self.isMuted
            self.isMuted = player?.isMuted ?? false
            
            self.player?.play()
            if paused {
                self.player?.pause()
            }
            
            if let currentItem = player?.currentItem {
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: currentItem, queue: .main) { _ in
                    self.player?.seek(to: .zero)
                    self.player?.play()
                }
            }
        }
    }

    func loadPlayerItem(_ videoURL: URL) async {
        let asset = AVAsset(url: videoURL)
        do {
            let (_, _, _) = try await asset.load(.tracks, .duration, .preferredTransform)
        } catch let error {
            print(error.localizedDescription)
        }
        let item = AVPlayerItem(asset: asset)
        loadedPost.loadedVideo = asset
        player?.replaceCurrentItem(with: item)
    }
}

