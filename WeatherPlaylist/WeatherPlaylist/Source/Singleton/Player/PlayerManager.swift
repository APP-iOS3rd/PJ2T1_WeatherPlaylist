//
//  PlayerManager.swift
//  WeatherPlaylist
//
//  Created by 이명섭 on 12/12/23.
//

import Foundation
import AVFoundation
//
class PlayerManager: ObservableObject {
    static var shared: PlayerManager = .init()
    var player: AVQueuePlayer = .init(items: [])
    @Published var isLoading = false
}

extension PlayerManager {
    // 재생
    func playTrack(url: String) {
        guard let url = URL(string: url) else { return }
        let item = AVPlayerItem(url: url)

        player.insert(item, after: nil)
    }
    // 정지
    func pause() {
        player.pause()
    }
    // 다음 트랙으로 이동
    func goNextTrack() {
        guard let first = player.items().first, player.items().count > 1 else {
            return
        }
        player.seek(to: .zero)
        player.advanceToNextItem()
        player.insert(first, after: nil)
    }
    // 이전 트랙으로 이동
    func goPrevTrack() {
        guard let last = player.items().last, let first = player.items().first, player.items().count > 1 else {
            return
        }
        player.seek(to: .zero)
        player.remove(last)
        player.insert(last, after: first)
        player.remove(first)
        player.insert(first, after: last)
    }
    // 플레이리스트 내 에서 재생버튼을 눌렀을 때 사용 : AVQueuePlayer에 AVPlayerItem을 추가합니다.
    func playTrackList(tracklist: [PlaylistTrackModel]) {
        if player.items().isEmpty {
            tracklist.forEach {
                if let url = URL(string: $0.url) {
                    Task {
                        await makeAVPlayerItem(url: url)
                    }
                }
            }
        }
        player.volume = 0.05
        player.play()
    }
    
    private func makeAVPlayerItem(url: URL) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let avAsset = AVURLAsset(url: url)
        do {
            let isPlayable = try await avAsset.load(.isPlayable)
            if isPlayable {
                let item = AVPlayerItem(asset: avAsset)
                player.insert(item, after: nil)
            }
        } catch {
            print(error.localizedDescription)
        }
        
        DispatchQueue.main.async {
            self.isLoading = false
        }
    }
}
