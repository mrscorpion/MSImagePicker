/**
 *  ImageManager
 *  唯一import了<AssetsLibrary/AssetsLibrary.h>和<Photos/Photos.h>的类，向外界提供有获取相册/照片/视频资源的接口，在里面每个方法内部会判断系统版本，从而选择是从AssetsLibrary库「iOS9以前可用」还是从Photos库里获取照片资源「iOS8以后可用」。
 */
//
//  TZImageManager.h
//  TZImagePickerController
//
//  Created by mr.scorpion on 16/1/4.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@class TZAlbumModel,TZAssetModel;
@interface TZImageManager : NSObject
@property (nonatomic, strong) PHCachingImageManager *cachingImageManager;
@property (nonatomic, assign) BOOL shouldFixOrientation; // 修正方向Orientation

+ (instancetype)manager;

/// Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized;

/// Get Album 获得相册/相册数组
- (void)getCameraRollAlbum:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(TZAlbumModel *model))completion;
- (void)getAllAlbums:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAlbumModel *> *models))completion;

/// Get Assets 获得Asset数组
- (void)getAssetsFromFetchResult:(id)result allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(NSArray<TZAssetModel *> *models))completion;
- (void)getAssetFromFetchResult:(id)result atIndex:(NSInteger)index allowPickingVideo:(BOOL)allowPickingVideo allowPickingImage:(BOOL)allowPickingImage completion:(void (^)(TZAssetModel *model))completion;

/// Get photo 获得照片
- (void)getPostImageWithAlbumModel:(TZAlbumModel *)model completion:(void (^)(UIImage *postImage))completion;
- (void)getPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (void)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isDegraded))completion;
- (void)getOriginalPhotoWithAsset:(id)asset completion:(void (^)(UIImage *photo,NSDictionary *info))completion;

/// Save photo 保存照片
- (void)savePhotoWithImage:(UIImage *)image completion:(void (^)())completion;

/// Get video 获得视频
- (void)getVideoWithAsset:(id)asset completion:(void (^)(AVPlayerItem * playerItem, NSDictionary * info))completion;

/// Export video 导出视频
- (void)getVideoOutputPathWithAsset:(id)asset completion:(void (^)(NSString *outputPath))completion;

/// Get photo bytes 获得一组照片的大小
- (void)getPhotosBytesWithArray:(NSArray *)photos completion:(void (^)(NSString *totalBytes))completion;

/// Judge is a assets array contain the asset 判断一个assets数组是否包含这个asset
- (BOOL)isAssetsArray:(NSArray *)assets containAsset:(id)asset;
@end
