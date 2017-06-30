//
//  AnalyticalError.m
//  WisdomCloud
//
//  Created by leijie liu on 12-6-18.
//  Copyright (c) 2012年 zlvod. All rights reserved.
//
//  Change By Apan
//  2012-7-9
//  1.Change Instanse Method to Class Method
//  2.Change Params

#import "AnalyticalError.h"

@implementation AnalyticalError

+(NSString *) getErrorInfo: (NSString *)status responseData:(id)data
{
    NSString *restring = nil;
    switch ([status intValue])
    {
        case 1:
            restring = @"成功返回";
            break;
        case -101:
            restring = @"接口已经关闭";
            break;
        case -102:
            restring = @"IP不允许访问";
            break;
        case -103:
            restring = @"缺少文件";
            break;
        case -104:
            restring = @"缺少参数";
            break;
        case -105:
            restring = @"验证未通过";
            break;
        case -106:
            restring = @"无权操作";
            break;
        case -107:
            restring = @"没有POST数据";
            break;
        case -108:
            restring = @"没有适合的方法";
            break;
        case -109:
            restring = @"需要重新登录";
            break;
        case -110:
            restring = @"用户未注册";
            break;
        case -111:
            restring = @"用户密码不正确";
            break;
        case -112:
            restring = @"验证码未通过";
            break;
        case -113:
            restring = @"用户空间未开通";
            break;
        case -114:
            restring = @"暂时不允许注册";
            break;
        case -115:
            restring = @"用户ID未取到";
            break;
        case -116:
            restring = @"用户已登录";
            break;
        case -117:
            restring = @"昵称已占用";
            break;
        case -118:
            restring = @"用户名不合法";
            break;
        case -119:
            restring = @"账号已存在";
            break;
        case -120:
            restring = @"资源不存在";
            break;
        case -121:
            restring = @"评论内容过短";
            break;
        case -122:
            restring = @"两次密码不一样";
            break;
        case -123:
            restring = @"密码不合法";
            break;
        case -124:
            restring = @"用户空间不够";
            break;
        case -125:
            restring = @"文件夹已存在";
            break;
        case -126:
            restring = @"文件不存在";
            break;
        case -127:
            restring = @"顶过啦";
            break;
        case -128:
            restring = @"私密文件";
            break;
        case -129:
            restring = @"资源未通过审核";
            break;
        case -131:
            restring = @"授权信息不存在";
            break;
        case -132:
            restring = @"该账号已被其他用户绑定";
            break;
        case -133:
            restring = @"唯一账号不能解绑";
            break;
        case -134:
            restring = @"未绑定SNS账号";
            break;
        case -135:
            restring = @"验证码错误";
            break;
        case -136:
            restring = @"手机已绑定账号";
            break;
        case -140:
            restring = @"收藏信息不存在";
            break;
        case -141:
            restring = @"收藏内容已存在";
            break;
        case -142:
            restring = @"评论信息不存在";
            break;
        case -143:
            restring = @"上层收藏信息不存在";
            break;
        case -150:
            restring = @"不能关注自己";
            break;
        case -151:
            restring = @"爱意表达过了,含蓄才是王道~";
            break;
        case -152:
            restring = @"关注用户不存在";
            break;
        case -153:
            restring = @"已关注过";
            break;
        case -154:
            restring = @"这个号码已经申请过了.";
            break;
        case -155:
            restring = @"您本次投票已用完";
            break;
        case -156:
            restring = @"您已经投过票了,谢谢您";
            break;
        case -170:
            restring = @"消息已存在";
            break;
        case -180:
            restring = @"文件夹层数是否超过上限";
            break;
        case -181:
            restring = @"文件夹已经存在";
            break;
        case -182:
            restring = @"文件夹层数是否超过上限";
            break;
        case -183:
            restring = @"文件或文件夹已经被删除";
            break;
        case -184:
            restring = @"个人空间不够";
            break;
        case -185:
            restring = @"文件夹暂不能移动";
            break;
        case -186:
            restring = @"文件夹非空";
            break;
        case -187:
            restring = @"不能操作系统文件夹";
            break;
        case -188:
            restring = @"不能操作非本人文件夹";
            break;
        case -190:
            restring = @"已经投过票";
            break;
        case -191:
            restring = @"活动不存在";
            break;
        case -192:
            restring = @"活动已结束";
            break;
        case -193:
            restring = @"活动已结束报名";
            break;
        case -201:
            restring = @"用户名不存在";
            break;
        case -202:
            restring = @"用户已锁定";
            break;
        case -210:
            restring = @"图片格式不对";
            break;
        case -211:
            restring = @"图片保存失败";
            break;
        case -220:
            restring = @"含有违规字符";
            break;
        case -230:
            restring = @"没有备份文件";
            break;
        case -240:
            restring = @"超过个人抽奖次数";
            break;
        case -241:
            restring = @"抽奖发生错误";
            break;
        case 250:
            restring = @"已举报过资源";
            break;
        case -993:
            restring = @"服务器返回错误";
            break;
        case -994:
            restring = [self get994Error:data];
            break;
        case -995:
            restring = @"程序出错了";
            break;
        case -996:
            restring = @"POST数据太快了";
            break;
        case -997:
            restring = @"您已经被拉入系统黑名单";
            break;
        case -998:
            restring = @"您当前权限已被管理员限制，请理解我们的管理";
            break;
        case -999:
            restring = @"已经超出最大页数";
            break;
        case -10124:
            restring = @"余额不足";
            break;
        case -10125:
            restring = @"订购失败";
            break;
        case -10126:
            restring = @"已经开通此业务";
            break;
        case -10127:
            restring = @"扣费失败";
            break;
        case -10128:
            restring = @"扣费失败";
            break;
        case -1000:
            restring = @"验证码错误";
            break;
        case -1001:
            restring = @"账号已存在";
            break;
        case -1002:
            restring = @"账号格式不正确";
            break;
        case -1003:
            restring = @"密码不能为空";
            break;
        case -1004:
            restring = @"密码格式不符合";
            break;
        case -1005:
            restring = @"密码不一致";
            break;
        case -1006:
            restring = @"密码校验失败";
            break;
        case -1007:
            restring = @"账号或密码为空";
            break;
        case -1008:
            restring = @"账号不存在";
            break;
        default:
            restring = @"Sorry,发生了一点小意外~";
            break;
    }
    return restring;
}

+(NSString *) get994Error:(id)data1
{
    NSInteger data = [[data1 objectForKey:@"data"] intValue];
    NSString *restring = nil;
    switch (data)
    {
        case 0:
            restring = @"失败";
            break;
        case 2:
            restring = @"文件或目录已存在";
            break;
        case 3:
            restring = @"文件或目录已存在";
            break;
        case 4:
            restring = @"文件或目录不存在";
            break;
        case 5:
            restring = @"文件或目录不存在";
            break;
        case 6:
            restring = @"同ID文件已存在";
            break;
        case -8:
            restring = @"没有操作权限";
            break;
        case -9:
            restring = @"文件或目录名不合法";
            break;
        case -12:
            restring = @"删除文件夹的时候，该文件夹下面存在文件";
            break;
        case -13:
            restring = @"Session过期";
            break;
        default:
            restring = @"操作出错";
            break;
    }
    return restring;
}

@end
