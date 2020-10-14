//
//  DownsamplingImageProcessor+CE.swift
//  Movies
//
//  Created by Carlos Villamizar on 13/10/20.
//  Copyright © 2020 Carlos Villamizar. All rights reserved.
//

import Foundation
import Kingfisher

/// Processor for downsampling an image. Compared to `ResizingImageProcessor`, this processor
/// does not render the images to resize. Instead, it downsample the input data directly to an
/// image. It is a more efficient than `ResizingImageProcessor`.
///
/// Only CG-based images are supported. Animated images (like GIF) is not supported.
public struct MODownsamplingImageProcessor: ImageProcessor {

    /// Target size of output image should be. It should be smaller than the size of
    /// input image. If it is larger, the result image will be the same size of input
    /// data without downsampling.
    public let size: CGSize

    /// Identifier of the processor.
    /// - Note: See documentation of `ImageProcessor` protocol for more.
    public let identifier: String

    /// Creates a `DownsamplingImageProcessor`.
    ///
    /// - Parameter size: The target size of the downsample operation.
    /// - Parameter subIdentifier: The processor identifier used as part of the image cached key
    public init(size: CGSize, subIdentifier: String) {
        self.size = size
        self.identifier = "com.onevcat.Kingfisher.DownsamplingImageProcessor" + subIdentifier
    }

    /// Processes the input `ImageProcessItem` with this processor.
    ///
    /// - Parameters:
    ///   - item: Input item which will be processed by `self`.
    ///   - options: Options when processing the item.
    /// - Returns: The processed image.
    ///
    /// - Note: See documentation of `ImageProcessor` protocol for more.
    public func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> KFCrossPlatformImage? {
        switch item {
        case .image(let image):
            guard let data = image.kf.data(format: .unknown) else {
                return nil
            }
            return KingfisherWrapper.downsampledImage(data: data, to: size, scale: options.scaleFactor)
        case .data(let data):
            return KingfisherWrapper.downsampledImage(data: data, to: size, scale: options.scaleFactor)
        }
    }
}
