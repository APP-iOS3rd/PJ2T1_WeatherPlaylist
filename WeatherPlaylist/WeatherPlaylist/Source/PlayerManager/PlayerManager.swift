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
//    var player: AVQueuePlayer = .init(items: [])
    var player: AVPlayer?
    @Published var isPlaying = false
    @Published var isLoading = false
    @Published var isRepeating = false
    @Published var isShuffling = false
    @Published var songTime = 0.0
    @Published var track: PlaylistTrackModel?
    private var tracks: [PlaylistTrackModel]?
    private var currentPlaylistID: String = ""
    private var currentIndex = 0
    private var playerItems: [AVPlayerItem] = []
}

extension PlayerManager {
    // 재생
    func play() {
        guard let player = self.player else { return }
        setTimeChecker()
        player.play()
        self.isPlaying = true
    }
    func playTrack(track: PlaylistTrackModel, playlistID: String, tracklist: [PlaylistTrackModel]) {
        if let player = self.player {
            self.pause()
            player.seek(to: .zero)
            setTimeChecker()
            if currentPlaylistID == playlistID {
                setSyncSameTrackListWithPlayer(player: player, track: track)
            } else {
                setSyncOtherTrackListWithPlayer(player: player, track: track, tracklist: tracklist)
            }
        } else {
            playTrackList(tracklist: tracklist, playlistID: playlistID)
            guard let player = self.player else { return }
            setSyncSameTrackListWithPlayer(player: player, track: track)
        }
    }
    // MARK: AVQueuePlayer와 TrackList간의 동기화를 위한 함수
    // 같은 플레이리스트 내에서 한 트랙을 선택(듣기)했을 경우
    private func setSyncSameTrackListWithPlayer(player: AVPlayer, track: PlaylistTrackModel) {
        guard let trackIndex = self.tracks?.firstIndex(of: track) else { return }
        self.track = track
        self.currentIndex = trackIndex
        player.replaceCurrentItem(with: playerItems[currentIndex])
        self.play()
    }
    // 다른 플레이리스트 내에서 한 트랙을 선택(듣기)했을 경우
    private func setSyncOtherTrackListWithPlayer(player: AVPlayer, track: PlaylistTrackModel, tracklist: [PlaylistTrackModel]) {
        self.track = track
        self.tracks = tracklist
        self.playerItems = []
        tracklist.forEach {
            if let url = URL(string: $0.url) {
                self.playerItems.append(AVPlayerItem(url: url))
            }
        }
        guard let trackIndex = self.tracks?.firstIndex(of: track) else { return }
        self.currentIndex = trackIndex
        player.replaceCurrentItem(with: playerItems[currentIndex])
        self.play()
    }
    // 플레이리스트 내 에서 재생버튼을 눌렀을 때 사용 : AVQueuePlayer에 AVPlayerItem을 추가합니다.
    func playTrackList(tracklist: [PlaylistTrackModel], playlistID: String) {
        self.tracks = tracklist
        self.track = tracklist[currentIndex]
        
        if self.currentPlaylistID != playlistID {
            self.currentPlaylistID = playlistID
            self.currentIndex = 0
            tracklist.forEach {
                if let url = URL(string: $0.url) {
                    let item = AVPlayerItem(url: url)
                    NotificationCenter.default.addObserver(self,
                                                           selector: #selector(playerDidFinishPlaying),
                                                           name: AVPlayerItem.didPlayToEndTimeNotification,
                                                           object: item)
                    self.playerItems.append(item)
                }
            }
            createPlayer()
            self.player = .init(playerItem: self.playerItems[self.currentIndex])
        } else {
            
        }
        self.play()
    }
    
    @objc private func playerDidFinishPlaying(sender: Notification){
        goNextTrack()
    }
    // 정지
    func pause() {
        guard let player = self.player else { return }
        player.pause()
        self.isPlaying = false
    }
    // 다음 트랙으로 이동
    func goNextTrack() {
        guard let player = self.player else { return }
        player.pause()
        player.seek(to: .zero)
        if let tracks = tracks {
            let trackIndex = goNextIndex()
            track = tracks[trackIndex]
        }
        let item = playerItems[currentIndex]
        player.replaceCurrentItem(with: item)
        player.play()
    }
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
    // 이전 트랙으로 이동
    func goPrevTrack() {
        guard let player = self.player else { return }
        player.pause()
        player.seek(to: .zero)
        if let tracks = tracks {
            let trackIndex = goPrevIndex()
            track = tracks[trackIndex]
        }
        let item = playerItems[currentIndex]
        player.replaceCurrentItem(with: item)
        player.play()
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
    
    // MARK: AVQueuePlayer와 TrackList간의 동기화를 위한 함수
    func changeTime(time: Double) {
        guard let player = self.player else { return }
        let seekTime = CMTime(value: CMTimeValue(time), timescale: 1)
        player.seek(to: seekTime)
    }
    
    private func updateTime(currentTime: CMTime) {
        guard let player = self.player else { return }
        if let song = player.currentItem {
            let duration = song.duration
            if CMTIME_IS_INVALID(duration) {
                return
            }
            self.songTime = Double(CMTimeGetSeconds(currentTime))
        }
    }
    
    func getTime(songDuration : Double) -> String {
        let seconds : Int = Int(songDuration) % 60
        let minutes : Int = Int(songDuration) / 60
        var returnSeconds : String = ""
        var returnMinutes : String = ""
        var myTime : String = ""
        if seconds >= 10 {
            returnSeconds = ":\(seconds)"
        } else {
            returnSeconds = ":0\(seconds)"
        }
        returnMinutes = "\(minutes)"
        myTime = returnMinutes + returnSeconds
        
        return myTime
    }
    
    private func createPlayer() {
        DispatchQueue.main.async { [weak self] in
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback,
                                                                mode: .default,
                                                                options:[.allowAirPlay, .defaultToSpeaker, .mixWithOthers, .duckOthers])
                try AVAudioSession.sharedInstance().setActive(true)
            } catch {
                print(error)
            }
        }
    }
    
    private func setTimeChecker() {
        guard let player = self.player else { return }
        let check = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        player.addPeriodicTimeObserver(forInterval: check, queue: DispatchQueue.main, using: {[weak self] Time in
            self?.updateTime(currentTime: Time)
        })
    }
}
