//
//  UserAvatarView.swift
//  SampleForInterview
//
//  Created by Sergey Glushchenko on 25.01.2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserAvatarView: View {
    @StateObject private var imageManager = ImageManager()
    
    let size: CGFloat
    
    private let options: SDWebImageOptions = [.allowInvalidSSLCertificates, .retryFailed]
    
    let url: URL?
    
    private let context : [SDWebImageContextOption : Any]
    
    init(url: URL?, size: CGFloat) {
        self.url = url
        self.size = size
        
        let imageSize = CGSize(width: size * UIScreen.main.scale, height: size * UIScreen.main.scale)
        
        context = [
            .imageTransformer : SDImageResizingTransformer(size: imageSize, scaleMode: .aspectFill),
            .imageCache : SDImageCache.userCache
        ]
    }
    
    var body: some View {
        ZStack {
            if let image = imageManager.image {
                display(image: Image(uiImage: image))
            } else {
                Circle()
                    .foregroundColor(.gray)
                    .frame(width: size, height: size)
                    .onAppear {
                        guard let url = self.url else { return }
                        
                        imageManager.cancel()
                        imageManager.load(url: url, options: options, context: context)
                    }
            }
        }
        .contentShape(Rectangle())
        .onAppear { if url != nil { imageManager.load(url: url, options: options, context: context) } }
        .onDisappear { imageManager.cancel() }
    }
    
    func display(image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(Circle())
            .contentShape(Rectangle())
    }
}

struct UserAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        UserAvatarView(url: nil, size: 64)
    }
}
