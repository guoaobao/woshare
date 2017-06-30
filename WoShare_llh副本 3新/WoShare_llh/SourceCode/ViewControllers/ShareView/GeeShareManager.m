//
//  GeeShareManager.m
//  WoShare_llh
//
//  Created by 陆利刚 on 16/7/5.
//  Copyright © 2016年 陆利杭. All rights reserved.
//

#import "GeeShareManager.h"
#import "WXApi.h"
#import "AppDelegate.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>


static NSString *kImageTagName = @"";
static NSString *kMessageExt = @"这是第三方带的测试字段";
static NSString *kMessageAction = @"<action>dotalist</action>";

@implementation GeeShareManager

- (void)shareToSina
{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    
    
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare] authInfo:authRequest access_token:myDelegate.wbtoken];
    request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}


//- (void)sendImageContent
//{
//    
//    NSString *content = [NSString stringWithFormat:@"%@ %@%@",[Config shareInstance].sinaShareContent,[Config shareInstance].sinaShareInfoLink,self.info._id];
//    UIImage *newsImage = [UIImage imageFromURLString:[self.info getSmallestImageURLString]];
//    
//    NSData *imageData = UIImageJPEGRepresentation(newsImage, 1.0);
//    
//    UIImage *thumbImage = newsImage;
//    [self sendImageData:imageData
//                TagName:kImageTagName
//             MessageExt:content
//                 Action:kMessageAction
//             ThumbImage:thumbImage
//                InScene:WXSceneTimeline];
//}

- (void)sendLinkContent {
    NSString *content = [NSString stringWithFormat:@"%@ %@%@",[Config shareInstance].WXShareContent,[Config shareInstance].WXShareInfoLink,self.info._id];
    UIImage *newsImage = [UIImage imageFromURLString:[self.info getSmallestImageURLString]];
    
    [self sendLinkURL:[NSString stringWithFormat:@"%@%@",[Config shareInstance].sinaShareInfoLink,self.info._id]
                             TagName:@""
                               Title:content
                         Description:content
                          ThumbImage:newsImage
                             InScene:WXSceneTimeline];
}

- (void)sendLinkContentToWechatFriend
{
    NSString *content = [NSString stringWithFormat:@"%@ %@%@",[Config shareInstance].WXShareContent,[Config shareInstance].WXShareInfoLink,self.info._id];
    UIImage *newsImage = [UIImage imageFromURLString:[self.info getSmallestImageURLString]];
    
    [self sendLinkURL:[NSString stringWithFormat:@"%@%@",[Config shareInstance].sinaShareInfoLink,self.info._id]
              TagName:@""
                Title:content
          Description:content
           ThumbImage:newsImage
              InScene:WXSceneSession];
}

- (BOOL)sendImageData:(NSData *)imageData
              TagName:(NSString *)tagName
           MessageExt:(NSString *)messageExt
               Action:(NSString *)action
           ThumbImage:(UIImage *)thumbImage
              InScene:(enum WXScene)scene {
    WXImageObject *ext = [WXImageObject object];
    ext.imageData = imageData;
    
    WXMediaMessage *message = [self messageWithTitle:nil
                                         Description:nil
                                              Object:ext
                                          MessageExt:messageExt
                                       MessageAction:action
                                          ThumbImage:thumbImage
                                            MediaTag:tagName];
    
    SendMessageToWXReq* req = [self requestWithText:nil
                                     OrMediaMessage:message
                                              bText:NO
                                            InScene:scene];
    
    return [WXApi sendReq:req];
}

- (WXMediaMessage *)messageWithTitle:(NSString *)title
                         Description:(NSString *)description
                              Object:(id)mediaObject
                          MessageExt:(NSString *)messageExt
                       MessageAction:(NSString *)action
                          ThumbImage:(UIImage *)thumbImage
                            MediaTag:(NSString *)tagName {
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = description;
    message.mediaObject = mediaObject;
    message.messageExt = messageExt;
    message.messageAction = action;
    message.mediaTagName = tagName;
    [message setThumbImage:thumbImage];
    return message;
}

- (SendMessageToWXReq *)requestWithText:(NSString *)text
                         OrMediaMessage:(WXMediaMessage *)message
                                  bText:(BOOL)bText
                                InScene:(enum WXScene)scene {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = bText;
    req.scene = scene;
    if (bText)
        req.text = text;
    else
        req.message = message;
    return req;
}


- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    
    NSString *content = [NSString stringWithFormat:@"%@ %@%@",[Config shareInstance].sinaShareContent,[Config shareInstance].sinaShareInfoLink,self.info._id];
    UIImage *newsImage = [UIImage imageFromURLString:[self.info getSmallestImageURLString]];
    
    message.text = content;
    
    WBImageObject *image = [WBImageObject object];
    image.imageData = UIImageJPEGRepresentation(newsImage,1);//[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"]];
    message.imageObject = image;
    
    return message;
}

- (BOOL)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene {
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = urlString;
    
    WXMediaMessage *message = [self messageWithTitle:title
                                                   Description:description
                                                        Object:ext
                                                    MessageExt:nil
                                                 MessageAction:nil
                                                    ThumbImage:thumbImage
                                                      MediaTag:tagName];
    
    SendMessageToWXReq* req = [self requestWithText:nil
                                                   OrMediaMessage:message
                                                            bText:NO
                                                          InScene:scene];
    return [WXApi sendReq:req];
}


- (void)sendLinkToQQFriend
{
    NSString *content = [NSString stringWithFormat:@"%@ %@%@",[Config shareInstance].qZoneShareContent,[Config shareInstance].qZoneShareInfoLink,self.info._id];
//    UIImage *newsImage = [UIImage imageFromURLString:[self.info getSmallestImageURLString]];
    NSString *url = [NSString stringWithFormat:@"%@%@",[Config shareInstance].sinaShareInfoLink,self.info._id];
    
    QQApiNewsObject *newsObj = [QQApiNewsObject
                                objectWithURL :[NSURL URLWithString:url]
                                title: @"悦分享"
                                description :content
                                previewImageURL:[NSURL URLWithString:[self.info getSmallestImageURLString]]];
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
    //将内容分享到qq
    [QQApiInterface sendReq:req];
}

@end
