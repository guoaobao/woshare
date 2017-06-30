//
//  GeeUpLoadViewController.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/6/22.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeUpLoadViewController.h"
#import "NSString+CaculateSize.h"
#import <MobileCoreServices/UTCoreTypes.h>
#include "ffmpeg.h"
#import "AVFoundation/AVFoundation.h"
#import "GeeUpLoadCollectionCell.h"
#import "RequestManager.h"
#import "GeeUploadParam.h"
#import "InfoListResponse.h"
#import "GeeUploadManager.h"
#import "AppDelegate.h"

#import "GeeSelectEventView.h"

int ffmpegmain(int argc, char **argv);

@interface GeeUpLoadViewController ()
<
UITextViewDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UIAlertViewDelegate,
RequestManagerDelegate,
GeeUploadDelegate
>

@property(nonatomic, strong) UILabel *textViewLabel;

@property(nonatomic, strong) NSMutableArray *collectionArray;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *upLoadArray;

@property(nonatomic, strong) UITextField *titleField;
@property(nonatomic, strong) UITextView *contentTextView;

@property(nonatomic, strong) UploadData *chooseUploadData;
@property(nonatomic, strong) GeeSelectEventView *selectEventView;

@property(nonatomic, strong) UIButton *selectEventButton;
@property(nonatomic, strong) UIImageView *buttonImage;

@end

@implementation GeeUpLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"上传";
    
    [self setNavBackButton];
    [self setnavRightButton];
    
    self.view.backgroundColor = [UIColor colorFromHexRGB:@"f0f0f0"];
    
    [self setupViewOfController];
    
    [self getGeeUploadManager].delegate = self;
    
}

- (NSMutableArray *)collectionArray
{
    if (_collectionArray == nil) {
        _collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}

- (void)setnavRightButton
{
    UIButton *button = [[UIButton alloc]init];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 40, 40);
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [button addTarget:self action:@selector(commitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupViewOfController
{
    UIScrollView *mainScrollView = [[UIScrollView alloc]init];
    mainScrollView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49);
    [self.view addSubview:mainScrollView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesTapped)];
    [mainScrollView addGestureRecognizer:tap];
    
    UITextField *titleField = [[UITextField alloc]init];
    titleField.frame = CGRectMake(10, 10, ScreenWidth-2*10, 40);
    titleField.placeholder = @"请输入视频/图片标题名称";
    titleField.backgroundColor = [UIColor whiteColor];
    [titleField.layer setMasksToBounds:YES];
    [titleField.layer setCornerRadius:2];
    titleField.font = [UIFont systemFontOfSize:14];
    titleField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 1)];
    titleField.leftViewMode = UITextFieldViewModeAlways;
    [mainScrollView addSubview:titleField];
    self.titleField = titleField;
    
    UITextView *contentView = [[UITextView alloc]init];
    [mainScrollView addSubview:contentView];
    contentView.frame = CGRectMake(10, CGRectGetMaxY(titleField.frame)+10, ScreenWidth-2*10, 100);
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView.layer setMasksToBounds:YES];
    [contentView.layer setCornerRadius:2];
    contentView.delegate = self;
    UILabel *tips = [[UILabel alloc]init];
    tips.text = @"请输入视频/图片内容概况100字以内";
    tips.textColor = [UIColor colorFromHexRGB:@"c0c0c0"];
    tips.font = [UIFont systemFontOfSize:14];
    contentView.font = [UIFont systemFontOfSize:14];
    [contentView addSubview:tips];
    CGSize tipsSize = [tips.text caculateSizeByFont:tips.font];
    tips.frame = CGRectMake(5, 8, tipsSize.width, tipsSize.height);
    self.textViewLabel = tips;
    self.contentTextView = contentView;
    
    UIButton *addButton = [[UIButton alloc]init];
    [addButton setTitle:@"➕ 添加视频/图片" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor colorFromHexRGB:@"707070"] forState:UIControlStateNormal];
    addButton.backgroundColor = [UIColor whiteColor];
    [addButton.layer setMasksToBounds:YES];
    [addButton.layer setCornerRadius:2];
    addButton.frame = CGRectMake(10, CGRectGetMaxY(contentView.frame)+10, ScreenWidth-2*10, 40);
    [mainScrollView addSubview:addButton];
    [addButton addTarget:self action:@selector(addButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.view addSubview:collection];
    collection.frame = CGRectMake(10, CGRectGetMaxY(addButton.frame)+10, ScreenWidth-2*10, ScreenHeight-(CGRectGetMaxY(addButton.frame)+10)-10-40-64);
    
    collection.backgroundColor = [UIColor clearColor];
    collection.delegate = self;
    collection.dataSource = self;
    self.collectionView = collection;
    [collection registerClass:[GeeUpLoadCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([GeeUpLoadCollectionCell class])];
    
    if (self.isHideSelectEventBtn) {
        return;
    }
    
    UIButton *selectEventBtn = [[UIButton alloc]init];
    self.selectEventButton = selectEventBtn;
    selectEventBtn.frame = CGRectMake(0, ScreenHeight-64-40, ScreenWidth, 40);
    [selectEventBtn setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateNormal];
    [selectEventBtn setBackgroundImage:[UIImage imageNamed:@"nav_barbackground"] forState:UIControlStateHighlighted];
    [selectEventBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:selectEventBtn];
    UILabel *buttonName = [[UILabel alloc]init];
    buttonName.text = @"选择活动入口";
    buttonName.textColor = [UIColor whiteColor];
    buttonName.font = [UIFont systemFontOfSize:16];
    [selectEventBtn addSubview:buttonName];
    CGSize namerect = [buttonName.text caculateSizeByFont:buttonName.font];
    UIImageView *buttonImage = [[UIImageView alloc]init];
    buttonImage.image = [UIImage imageNamed:@"back-arrow"];
    buttonImage.contentMode = UIViewContentModeScaleAspectFit;
    self.buttonImage = buttonImage;
    [selectEventBtn addSubview:buttonImage];
    buttonName.frame = CGRectMake(selectEventBtn.frame.size.width/2-(namerect.width+2+12)/2, selectEventBtn.frame.size.height/2-namerect.height/2, namerect.width, namerect.height);
    buttonImage.frame = CGRectMake(CGRectGetMaxX(buttonName.frame)+2, selectEventBtn.frame.size.height/2-12/2, 12, 12);
    buttonImage.transform = CGAffineTransformMakeRotation(-M_PI/2);
    [selectEventBtn addTarget:self action:@selector(selectEventBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectEventBtnClicked
{
    if (self.selectEventView == nil) {
        
        self.selectEventView = [[GeeSelectEventView alloc]init];
        [self.view addSubview:self.selectEventView];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.buttonImage.transform = CGAffineTransformMakeRotation(M_PI/2);
        }];
        
        __weak GeeUpLoadViewController *weakself = self;
        self.selectEventView.eventSelectedAtIndex = ^(EventResponse *eventinfo) {
            
            weakself.eventid = eventinfo.eventid;
        };
        
    } else {
        
        [UIView animateWithDuration:0.3 animations:^{
            if (self.selectEventView.hidden) {
                self.buttonImage.transform = CGAffineTransformMakeRotation(M_PI/2);
            } else {
                self.buttonImage.transform = CGAffineTransformMakeRotation(-M_PI/2);
            }
            
        }];
        self.selectEventView.hidden = !self.selectEventView.isHidden;
        
        
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0) {
        self.textViewLabel.hidden = YES;
    } else {
        self.textViewLabel.hidden = NO;
    }

}

- (void)commitButtonClicked
{
    [self.view endEditing:YES];
    
    if ([RequestManager sharedManager].currentReachabilityStatus == NotReachable)
    {
        [self toast:@"没有可用网络"];
        return;
    }
    
    if (self.titleField.text.length == 0) {
        [self toast:@"请输入标题"];
        return;
    }
    
    if (self.contentTextView.text.length == 0) {
        [self toast:@"请输入简介"];
        return;
    }
    
    if (self.collectionArray.count == 0) {
        [self toast:@"你还未添加内容"];
        return;
    }
    
    
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeSetPageVisitLog withData:[NSDictionary dictionaryWithObjectsAndKeys:@"upload",@"module",@"submit",@"action", nil]];
    
    GeeUploadParam* param = [GeeUploadParam alloc];
    param.uid = [RequestManager sharedManager].userInfo.uid;
    param.brief = self.contentTextView.text;
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    param.fileinfos =array;
    param.title = self.titleField.text;
    for (UploadData *data in self.collectionArray) {
        GeeUploadFileInfo *info = [[GeeUploadFileInfo alloc]init];
        info.filename = data.fileName;
        info.image = [UIImage imageWithData:data.fileData];
        info.videourl = data.videoURL;
        [param.fileinfos addObject:info];
    }
//    _type = kInfoTypePicture;
    for (GeeUploadFileInfo *info in param.fileinfos) {
        if (info.videourl.absoluteString.length>0) {
//            _type = kInfoTypeMovie;
            break;
        }
    }
    
    [[self getGeeUploadManager] addTask:param];
    [Config shareInstance].uploadingData = nil;
    
    [self showIndicator];
    
//    if (!hud)
//    {
//        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:[AppDelegate sharedAppDelegate].window];
//        hud = HUD;
//        hud.mode = MBProgressHUDModeAnnularDeterminate;
//    }
//    [self.view addSubview:hud];
//    [hud show:YES];
    
}

- (GeeUploadManager *)getGeeUploadManager
{
    return [AppDelegate sharedAppDelegate].geeUploadManager;
}

- (void)addButtonClicked
{
    UIActionSheet *sheet = [[UIActionSheet alloc]init];
    [sheet setTitle:@"选择"];
    [sheet addButtonWithTitle:@"取消"];
    [sheet addButtonWithTitle:@"拍照"];
    [sheet addButtonWithTitle:@"拍视频"];
    [sheet addButtonWithTitle:@"从相册选取"];
    [sheet addButtonWithTitle:@"本地视频"];
    [sheet setCancelButtonIndex:0];
    sheet.delegate = self;
    
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    
    [self.view endEditing:YES];
}

#pragma mark -- UIActionSheetDelegate代理
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera mediaType:nil];
    }
    if (buttonIndex == 2)
    {
        [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera mediaType:(NSString *)kUTTypeMovie];
    }
    if (buttonIndex == 3)
    {
        [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary mediaType:(NSString*)kUTTypeImage];
    }
    else if(buttonIndex == 4)
    {
        [self getMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary mediaType:(NSString*)kUTTypeMovie];
    }
}

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType mediaType:(NSString *)mediaType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable: sourceType] && [mediaTypes count] > 0)
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        if (mediaType)
        {
            picker.mediaTypes = [NSArray arrayWithObject:mediaType];
        }
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = sourceType;
        picker.videoMaximumDuration = 30;
        picker.videoQuality = UIImagePickerControllerQualityTypeMedium;
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark -- UICollectionViewDelegate代理


#pragma mark -- UICollectionViewDataSource代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GeeUpLoadCollectionCell *cell = [GeeUpLoadCollectionCell cellForCollectionView:collectionView forIndex:indexPath];
    UploadData *data = [self.collectionArray objectAtIndex:indexPath.row];
    [cell setBackImage:data.coverImage isVideo:data.videoURL?YES:NO];
    cell.uploadData = data;
    cell.longPressed = ^(UploadData *data) {
        
        self.chooseUploadData = data;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除" message:@"确定删除吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    };
    return cell;
}

#pragma mark -- UICollectionViewDelegateFlowLayout代理
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((200>collectionView.frame.size.height?200:collectionView.frame.size.height), (200>collectionView.frame.size.height?200:collectionView.frame.size.height));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, (collectionView.frame.size.width-(200>collectionView.frame.size.height?200:collectionView.frame.size.height))/2-1, 0, (collectionView.frame.size.width-(200>collectionView.frame.size.height?200:collectionView.frame.size.height))/2-1);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


#pragma mark -- UIImagePickerViewController代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    UploadData *uploadingData;
    
//    NSString *fileName = nil;
    //取图 取视频 都是有这个URL的
    if ([info objectForKey:UIImagePickerControllerReferenceURL])
    {
//        NSString *url = [[info objectForKey:UIImagePickerControllerReferenceURL] absoluteString];
        
        //ReferenceURL的类型为NSURL 无法直接使用  必须用absoluteString 转换，照相机返回的没有UIImagePickerControllerReferenceURL，会报错
//        fileName = [self createNameByURL:url];
        
        if ([mediaType isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *rotatedImage = [UIImage rotateImage:image];
            NSData *imageData = UIImageJPEGRepresentation(rotatedImage, 0.5);
            uploadingData = [[UploadData alloc] initWithFileData:imageData fileURL:nil fileName:[self createNameByTime:@"jpg"]];
            uploadingData.coverImage = rotatedImage;
        }
        else
        {
            NSURL *fileURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
            NSString *output = [self changeToMp4:fileURL.absoluteString];
            
            uploadingData = [[UploadData alloc] initWithFileData:nil fileURL:[NSURL URLWithString:output] fileName:[self createNameByTime:@"mp4"]];
            NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
            AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:fileURL options:opts];
            AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
            generator.appliesPreferredTrackTransform = YES;
            NSError *error = nil;
            CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
            if (!error)
            {
                UIImage *image = [UIImage rotateImage:[UIImage imageWithCGImage:img]];
                uploadingData.coverImage = image;
            }
        }
    }
    else
    {
        if ([mediaType isEqualToString:@"public.image"])
        {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            UIImage *rotatedImage = [UIImage rotateImage:image];
            NSData *imageData = UIImageJPEGRepresentation(rotatedImage, 0.5);
            uploadingData = [[UploadData alloc] initWithFileData:imageData fileURL:nil fileName:[self createNameByTime:@"jpg"]];
            //保存
            uploadingData.coverImage = rotatedImage;
            [NSThread detachNewThreadSelector:@selector(saveImage:) toTarget:self withObject:image];
        }
        else
        {
            NSURL *fileURL = [info objectForKey:UIImagePickerControllerMediaURL];
            
            NSString *output = [self changeToMp4:fileURL.absoluteString];
            
            uploadingData = [[UploadData alloc] initWithFileData:nil fileURL:[NSURL URLWithString:output] fileName:[self createNameByTime:@"mp4"]];
            
            //保存视频
            BOOL compatible = UIVideoAtPathIsCompatibleWithSavedPhotosAlbum([fileURL path]);
            if (compatible)
            {
                UISaveVideoAtPathToSavedPhotosAlbum([fileURL path], self, nil, NULL);
            }
            
            NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
            AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:fileURL options:opts];
            AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
            generator.appliesPreferredTrackTransform = YES;
            NSError *error = nil;
            CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
            if (!error)
            {
                UIImage *image = [UIImage rotateImage:[UIImage imageWithCGImage:img]];
                uploadingData.coverImage = image;
            }
        }
    }
    if (uploadingData!=nil) {
        [self.collectionArray removeAllObjects];
        [self.collectionArray addObject:uploadingData];
        [self.collectionView reloadData];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)createNameByURL:(NSString *)url
{
    NSArray *temp = [url componentsSeparatedByString:@"&ext="];
    NSString *suffix = [temp lastObject];
    temp = [[temp objectAtIndex:0] componentsSeparatedByString:@"?id="];
    NSString *name = [temp lastObject];
    name = [name stringByAppendingFormat:@".%@",suffix];
    return name;
}

- (NSString *)createNameByTime:(NSString *)ext
{
    NSDate* date = [NSDate date];
    NSString *nowTime = [NSString stringWithDate:date formater:@"yyyyMMddHHmmSS"];
    NSString *fileName = [NSString stringWithFormat:@"%@.%@",nowTime,ext];
    return fileName;
}

- (void)saveImage:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        for (int i = 0; i < self.collectionArray.count; i++) {
            
            UploadData *data = [self.collectionArray objectAtIndex:i];
            if (data == self.chooseUploadData) {
                [self.collectionArray removeObject:data];
                [self.collectionView reloadData];
                break;
            }
            
        }
    }
}

- (NSString *)changeToMp4:(NSString *)path
{
    NSString *outputpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"myVedio.mp4"];
    
    outputpath = [@"file://" stringByAppendingString:outputpath];
    BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:outputpath];
    if (isexist) {
        [[NSFileManager defaultManager] removeItemAtPath:outputpath error:nil];
    }
//        NSString *command_str = [NSString stringWithFormat:@"ffmpeg -i %@ -b:v 400k -s 480x640 %@",path,outputpath];
    
    NSString *command_str = [NSString stringWithFormat:@"ffmpeg -i %@ -acodec copy -vcodec copy %@",path,outputpath];
    
    NSArray *argv_array=[command_str componentsSeparatedByString:(@" ")];
    int argc=(int)argv_array.count;
    char** argv=(char**)malloc(sizeof(char*)*argc);
    for(int i=0;i<argc;i++)
    {
        argv[i]=(char*)malloc(sizeof(char)*1024);
        strcpy(argv[i],[[argv_array objectAtIndex:i] UTF8String]);
    }
    
    ffmpegmain(argc, argv);
    
    for(int i=0;i<argc;i++)
        free(argv[i]);
    free(argv);
    
    return outputpath;
}

- (void)tapgesTapped
{
    [self.view endEditing:YES];
}

- (void)webServiceRequest:(RequestType)requestType error:(NSError *)error userData:(id)userData
{
    NSLog(@"%@",error);
}

- (void)webServiceRequest:(RequestType)requestType errorString:(NSString *)errorString userData:(id)userData
{
    NSLog(@"%@",errorString);
}

- (void)webServiceRequest:(RequestType)requestType response:(id)response userData:(id)userData originalData:(id)data
{
    if (requestType == kRequestTypeAddInfo) {
        
        [self toast:@"上传成功"];
        
        self.titleField.text = @"";
        self.contentTextView.text = @"";
        [self.collectionArray removeAllObjects];
        [self.collectionView reloadData];
        
        [self performSelector:@selector(exitUpLoad) withObject:nil afterDelay:1];
        
    }
}

- (void)exitUpLoad
{
    if (self.popToViewController) {
        [self.navigationController popToViewController:self.popToViewController animated:YES];
        
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
}
-(void)progressCallback:(IOSProgressCallbackData*)obj
{
    
}
-(void)uploadCompleteCallback:(GeeUploadResult*)gr obj:(IGeeUploadData*)obj
{
    NSMutableArray *nsids = [[NSMutableArray alloc]initWithCapacity:0];
    for (GeeUploadFileInfo *info in obj.param.fileinfos) {
        if ([info.nsid length]>0) {
            [nsids addObject:info.nsid];
        }
    }
    
    if (nsids.count == 0) {
        [self hideIndicator];
        [self toast:@"上传失败"];
        return;
    }
    
    if (gr.result == 1) {
        
        [self performSelectorOnMainThread:@selector(addInfo:) withObject:nsids waitUntilDone:YES];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(toast:) withObject:[gr toString] waitUntilDone:YES];
    }
    
    [self hideIndicator];
    
}


- (void)addInfo:(NSArray*)nsids
{
    NSString *ft;

    if (self.collectionArray.count) {
        UploadData *data = [self.collectionArray objectAtIndex:0];
        if (data.videoURL.absoluteString.length > 0) {
            ft = @"1";
        } else {
            ft = @"3";
        }
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.titleField.text,@"title",self.contentTextView.text,@"brief",nsids,@"nsids", ft,@"ft",self.eventid?:@"",@"eventid",nil];
    [[RequestManager sharedManager]addDelegate:self];
    [[RequestManager sharedManager]startRequestWithType:kRequestTypeAddInfo withData:dic];
    
}

@end
