//
//  PlayerManager.swift
//  WeatherPlaylist
//
//  Created by 이명섭 on 12/12/23.
//

import Foundation
import AVFoundation

class PlayerManager: ObservableObject {
    static var shared: PlayerManager = .init()
    var player: AVQueuePlayer = .init(items: [])
    @Published var isPlaying = false
    @Published var isLoading = false
    @Published var track: PlaylistTrackModel?
    private var tracks: [PlaylistTrackModel]?
    private var currentPlaylistId: String?
    private var currentIndex = 0
}

extension PlayerManager {
    // 재생
    func playTrack(url: String, playlistId: String) {
        guard let url = URL(string: url) else { return }
        let item = AVPlayerItem(url: url)
        player.insert(item, after: nil)
    }
    // 정지
    func pause() {
        player.pause()
        self.isPlaying = false
    }
    // 다음 트랙으로 이동
    func goNextTrack() {
        guard let first = player.items().first, player.items().count > 1 else {
            return
        }
        player.seek(to: .zero)
        player.advanceToNextItem()
        player.insert(first, after: nil)
        if let tracks = tracks {
            let trackIndex = goNextIndex()
            track = tracks[trackIndex]
        }
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
        if let tracks = tracks {
            let trackIndex = goPrevIndex()
            track = tracks[trackIndex]
        }
    }
    // 플레이리스트 내 에서 재생버튼을 눌렀을 때 사용 : AVQueuePlayer에 AVPlayerItem을 추가합니다.
    func playTrackList(tracklist: [PlaylistTrackModel], playlistId: String) {
        self.tracks = tracklist
        self.track = tracklist[currentIndex]
        
        if currentPlaylistId != playlistId {
            Task {
                DispatchQueue.main.async {
                    self.isLoading = true
                }
                player.removeAllItems()
                currentPlaylistId = playlistId
                
                let tracksURL = tracklist.compactMap { return URL(string: $0.url) }
                
                do {
                    try await tracksURL.asyncForeach { try await makeAVPlayerItem(url: $0) }
                } catch {
                    self.tracks = nil
                }
                DispatchQueue.main.async {
                    self.isLoading = false
                }
            }
        }
        
        player.play()
        self.isPlaying = true
    }
    
    private func makeAVPlayerItem(url: URL) async throws {
        let avAsset = AVURLAsset(url: url)
        do {
            let isPlayable = try await avAsset.load(.isPlayable)
            if isPlayable {
                enqueue(asset: avAsset)
            }
        } catch {
            print(error.localizedDescription)
            fatalError("error")
        }
    }
    
    private func enqueue(asset: AVURLAsset) {
        let item = AVPlayerItem(asset: asset)
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
                                               name: AVPlayerItem.didPlayToEndTimeNotification,
                                               object: item)
        player.insert(item, after: nil)
        player.volume = 0.2
    }
    
    @objc private func playerDidFinishPlaying(sender: Notification){
        goNextTrack()
    }
    // MARK: AVQueuePlayer와 TrackList간의 동기화를 위한 함수
    // 다음 트랙으로 넘어갈 때
    private func goNextIndex() -> Int {
        guard let tracks = tracks else {
            return currentIndex
        }
        // 플레이리스트의 마지막 순서인 경우 첫 트랙으로 이동
        if self.currentIndex == (tracks.count - 1) {
            self.currentIndex = 0
        // 아닌 경우 다음곡으로
        } else {
            currentIndex += 1
        }
        
        return currentIndex
    }
    // 이전 트랙으로 돌아갈 때
    private func goPrevIndex() -> Int {
        guard let tracks = tracks else {
            return currentIndex
        }
        // 플레이리스트의 첫 순서인 경우 마지막 트랙으로 이동
        if self.currentIndex == 0 {
            self.currentIndex = (tracks.count - 1)
        // 아닌 경우 이전 곡으로
        } else {
            currentIndex -= 1
        }
        
        return currentIndex
    }
}
