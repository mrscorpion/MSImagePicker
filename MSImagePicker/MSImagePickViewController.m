//
//  MSImagePickViewController.m
//  MSImagePicker
//
//  Created by mr.scorpion on 16/5/20.
//  Copyright © 2016年 mr.scorpion. All rights reserved.
//

#import "MSImagePickViewController.h"
#import "TZImagePickerController.h"
#import "TZImageManager.h"
#import "TZTestCell.h"

@interface MSImagePickViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *models;
@end

@implementation MSImagePickViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor blackColor];
    [self.collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    
    
    TZImagePickerController *tzImagePickerVc = (TZImagePickerController *)self.navigationController;
    tzImagePickerVc.allowPickingOriginalPhoto = YES;
    tzImagePickerVc.allowPickingImage = YES;
    tzImagePickerVc.allowPickingVideo = YES;
    [[TZImageManager manager] getCameraRollAlbum:tzImagePickerVc.allowPickingVideo allowPickingImage:tzImagePickerVc.allowPickingImage completion:^(TZAlbumModel *model) {
        
        [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:tzImagePickerVc.allowPickingVideo allowPickingImage:tzImagePickerVc.allowPickingImage completion:^(NSArray<TZAssetModel *> *models) {
            [tzImagePickerVc hideProgressHUD];
            
            self.models = models;
            [self.collectionView reloadData];
//            TZAssetModel *model = [models lastObject];
//            [_models addObject:model];
//            if (tzImagePickerVc.selectedModels.count < tzImagePickerVc.maxImagesCount) {
//                model.isSelected = YES;
//                [tzImagePickerVc.selectedModels addObject:model];
//                [self refreshBottomToolBarStatus];
//            }
//            [_collectionView reloadData];
//            _shouldScrollToBottom = YES;
//            [self scrollCollectionViewToBottom];
        }];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
//    if (indexPath.row == _selectedPhotos.count) {
//        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
//        cell.deleteBtn.hidden = YES;
//    } else {
        cell.imageView.image = self.models[indexPath.row];
        cell.deleteBtn.hidden = NO;
//    }
//    cell.deleteBtn.tag = indexPath.row;
//    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
