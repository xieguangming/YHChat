//
//  TestData.m
//  YHChat
//
//  Created by YHIOS002 on 17/2/27.
//  Copyright © 2017年 samuelandkevin. All rights reserved.
//

#import "TestData.h"
#import "YHChatModel.h"
#import "YHChatListModel.h"
#import "YHExpressionHelper.h"

@implementation TestData

#pragma mark - 产生模拟数据源 (模拟服务器数据,实际开发可删除)
//随机生成totalCount数量的聊天记录
+ (NSArray <YHChatModel *>*)randomGenerateChatModel:(int)totalCount{
    
    NSMutableArray *retArr = [NSMutableArray arrayWithCapacity:totalCount];
    for (int i=0; i<totalCount; i++) {
        YHChatModel *model = [self _creatOneChatModelWithTotalCount:totalCount];
        //会话Id
        model.chatId = [NSString stringWithFormat:@"%d",(100+i)];
        [retArr addObject:model];
    }
    return retArr;
}

//随机生成totalCount数量的聊天列表
+ (NSArray <YHChatListModel *>*)randomGenerateChatListModel:(int)totalCount{
    
    NSMutableArray *retArr = [NSMutableArray arrayWithCapacity:totalCount];
    for (int i=0; i<totalCount; i++) {
        YHChatListModel *model = [self _creatOneChatListModelWithTotalCount:totalCount];
        [retArr addObject:model];
    }
    return retArr;
}




#pragma mark - private
+ (YHChatModel *)_creatOneChatModelWithTotalCount:(int)totalCount{
    
    YHChatModel *model = [YHChatModel new];
    
    //用户ID
    NSArray *uidArr = @[@"1",@"2",@"3",@"4"];
    int nUidLength  = arc4random() % uidArr.count;
    model.speakerId = uidArr[nUidLength];
    if ([model.speakerId isEqualToString:MYUID]) {
        model.direction = 0;
    }else{
        model.direction = 1;
    }
    
    //发言者头像
    NSArray *avtarArray = @[
                            @"http://testapp.gtax.cn/images/2016/11/09/64a62eaaff7b466bb8fab12a89fe5f2f.png!m90x90.png",
                            @"https://testapp.gtax.cn/images/2016/09/30/ad0d18a937b248f88d29c2f259c14b5e.jpg!m90x90.jpg",
                            @"https://testapp.gtax.cn/images/2016/09/14/c6ab40b1bc0e4bf19e54107ee2299523.jpg!m90x90.jpg",
                            @"http://testapp.gtax.cn/images/2016/11/14/8d4ee23d9f5243f98c79b9ce0c699bd9.png!m90x90.png",
                            @"https://testapp.gtax.cn/images/2016/09/14/8cfa9bd12e6844eea0a2e940257e1186.jpg!m90x90.jpg"];
    int avtarIndex = arc4random() % avtarArray.count;
    if ([model.speakerId isEqualToString:MYUID]) {
        model.speakerAvatar = MYAVTARURL;
    }else{
        model.speakerAvatar = [NSURL URLWithString:avtarArray[avtarIndex]];
    }
    
    //聊天记录ID
    CGFloat myIdLength = arc4random() % totalCount;
    int result = (int)myIdLength % 2;
    model.chatId = [NSString stringWithFormat:@"%d",result];;
    
    
    //消息是否已撤回
    NSArray *stautsArr = @[@"0",@"1",@"1",@"0",@"0",@"1",@"0",@"0"];
    int nStatusLength  = arc4random() % stautsArr.count;
    model.status = [stautsArr[nStatusLength] intValue];
    
    
    //消息类型  0是文本 1是图片 2是语音 3是文件
    NSArray *msgTypeArr = @[@(0),@(1),@(2),@(3)];
    int nMsgTypeLength  = arc4random() % msgTypeArr.count;
    model.msgType = nMsgTypeLength;
    
    //消息内容为文本
    NSArray *textMsgArr = @[@"http://www.cocoachina.com @郭靖 @samuelandkevin https://github.com/samuelandkevin/YHChat",@"我家这个好忠犬啊～[喵喵]  http://t.cn/Ry4UXdF //@我是呆毛芳子蜀黍w:这是什么鬼？  http://t.cn/Ry4U5fQ //@清新可口喵酱圆脸星人是扭蛋狂魔:窝家这个 超委婉的拒绝了窝 http://t.cn/Ry4ylqt //@GloriAries:我家这位好高冷orz http://t.cn/RyUsE79 //@-水蛋蛋-:我的是玩咖即视感  http://t.cn/RyUsS8Q ",@"你他妈😂😂😂😂😂😂",@"#为周杰伦正名# [拜拜]看不下去，什么叫我伦给国足添堵？！演唱会去就审批过的，票也早就开售了，何来我伦干扰国足比赛了？[微笑]国足赛场八月才临时改的场地，甩锅给我伦？这锅不接[微笑]抽奖，不用关注，转发就行，9.10号抽一个人送三盒日本带回来的 白色恋人@转发抽奖平台 [拜拜]",@"iPhone 6s官方宣传视频曝光，你们城里人真会玩，如果iphone 6s真的是这样那的确是碉堡了[嘻嘻]http://t.cn/RyU1m9J",@"别以为这是危言耸听，我身边就有一个坦白了自己刚刚经历过吃了毓婷还中奖的妹子[拜拜]这是最后的补救手段，并且不是万能的，事前做好该做的事情吧[拜拜]",@" 苹果小贴士：如果你用苹果的触控板，看到任何你不认识的字，可以轻易的三指点按－就可以看到解说（词典或维基百科）。在这个示范可以看出这个功能还相当智能，我点选的是英文字，但它不止帮我找到了答案，还选择了中文！在 iPhone 上要多指点按并不精确，这也可能就是 Force Touch 的切入点。",@"电子工业实习课上焊了个小电视，据说跟着抖动100下会boom～@哔哩哔哩智能姬 @哔哩哔哩弹幕网 http://t.cn/z8289ns"];
    int textMsglength = arc4random() % textMsgArr.count;
    NSString *aTextMsg = textMsgArr[textMsglength];
    NSMutableString *qStr = [NSMutableString string];
    CGFloat qlength = arc4random() % 2;
    if (qlength == 0) {
        [qStr appendString:aTextMsg];
    }else{
        for (NSUInteger i = 0; i < qlength; ++i) {
            [qStr appendString:aTextMsg];
        }
    }
    CGFloat addFontSize = [[[NSUserDefaults standardUserDefaults] valueForKey:kSetSystemFontSize] floatValue];
    
    UIColor *textColor = [UIColor blackColor];
    if ([model.speakerId isEqualToString:MYUID]) {
        textColor = [UIColor whiteColor];
    }
    
    model.msgContent = [YHExpressionHelper attributedStringWithText:qStr fontSize:(13+addFontSize) textColor:textColor];
    
    

    
    //消息内容为图片
    NSArray *imgMsgArr = @[@"img[https://testapp.gtax.cn/images/2016/08/25/2241c4b32b8445da87532d6044888f3d.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/0abd8670e96e4357961fab47ba3a1652.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/5cd8aa1f1b1f4b2db25c51410f473e60.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/5e8b978854ef4a028d284f6ddc7512e0.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/03c58da45900428796fafcb3d77b6fad.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/dbee521788da494683ef336432028d48.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/4cd95742b6744114ac8fa41a72f83257.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/4d49888355a941cab921c9f1ad118721.jpg!t300x300.jpg]",
                           
                           @"img[https://testapp.gtax.cn/images/2016/08/25/ea6a22e8b4794b9ba63fd6ee587be4d1.jpg!t300x300.jpg]"];
    int imglength = arc4random() % imgMsgArr.count;
    if (model.msgType == 1) {
        NSString *imgUrlStr = imgMsgArr[imglength];
        model.msgContent = [[NSMutableAttributedString alloc] initWithString:imgUrlStr];
    }
    
    //消息内容为语音
    
    NSArray *voiceArr = @[@"voice[http://apps.gtax.cn/images/2017/01/13/11f9ba99dd3541f38028f841f0b74b64.wav]",
                          @"voice[http://apps.gtax.cn/images/2017/01/13/11a261d334f64c6888da1c2f2ae73865.wav]",
                          @"voice[http://apps.gtax.cn/images/2017/01/13/a893203baacb4c8ebb16bab9c353a4fb.wav]",
                          @"voice[http://apps.gtax.cn/images/2017/01/12/5fea39651c4942d6b679738a855d9233.wav]",
                          @"voice[http://apps.gtax.cn/images/2017/01/12/254084401ed74051aa15dad4a40d4f7b.wav]",
                          @"voice[http://apps.gtax.cn/images/2017/01/12/9d70932816824b5b890c0817d0b992a9.wav]",
                          @"voice[http://apps.gtax.cn/images/2017/01/24/50f06e140ea644b6ac686fec86681f38.wav]"];
    int voicelength = arc4random() % voiceArr.count;
    if (model.msgType == 2) {
        NSString *voiceUrlStr = voiceArr[voicelength];
        model.msgContent = [[NSMutableAttributedString alloc] initWithString:voiceUrlStr];
    }
    
    
    
    
    
    //对话用户名字
    NSArray *sessionNickArr = @[@"李一",@"张国富",@"黎明",@"你不是我的菜",@"这名字会好长的啊！呵呵",@"天天",@"我不要要不要" ];
    int sNickLength  = arc4random() % sessionNickArr.count;
    model.speakerName = sessionNickArr[sNickLength];
    if ([model.speakerId isEqualToString:MYUID]) {
        model.speakerName = @"samuelandkeivn";
    }
    
    
    //发布时间
    model.createTime = @"2013-04-17";
    
    return model;
}


+ (YHChatListModel *)_creatOneChatListModelWithTotalCount:(int)totalCount{
    
    YHChatListModel *model = [YHChatListModel new];
    
    //是否群聊天
    NSArray *isGroupChatArr = @[@(0),@(1),@(1),@(0),@(1)];
    int isGChatLength  = arc4random() % isGroupChatArr.count;
    model.isGroupChat = [isGroupChatArr[isGChatLength] boolValue];
    
    
    //上次发布内容
    //消息内容为文本
    NSString *contentStr = model.isGroupChat? @"群聊内容。":@"单聊内容。";
    
    CGFloat lConlength = arc4random() % 2+1;
    NSMutableString *qStr = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < lConlength; ++i) {
        [qStr appendString:contentStr];
    }
    model.lastContent = qStr;
    
    
    //消息类型
    NSArray *msgTypeArr = @[@(0),@(1),@(2),@(3)];
    int nMsgTypeLength  = arc4random() % msgTypeArr.count;
    model.msgType = nMsgTypeLength;
    
    
    //用户ID
    NSArray *uidArr = @[@"1",@"2",@"3",@"4"];
    int aUidLength  = arc4random() % uidArr.count;
    model.userId = uidArr[aUidLength];
   
    
    //对话用户ID
    NSArray *sessionUidArr = @[@"5",@"6",@"7",@"8"];
    int sUidLength  = arc4random() % sessionUidArr.count;
    model.sessionUserId = uidArr[sUidLength];
    
  
    //消息已读
    NSArray *isReadArr = @[@(0),@(1),@(2),@(3)];
    int isReadLength  = arc4random() % isReadArr.count;
    model.isRead = [isReadArr[isReadLength] boolValue];
    
    //成员数量
    NSArray *memberArr = @[@(1),@(12),@(19),@(4),@(2),@(10),@(5),@(1),@(1),@8,@3];
    int memLength  = arc4random() % memberArr.count;
    memLength = memLength <= 1 ? 2:memLength;
    model.isRead = [memberArr[memLength] intValue];
    
//    model.isGroupChat = YES;//kun调试
//    memLength = 10;
    
    //群名字
    if (model.isGroupChat) {
        NSArray *gNameArr = @[@"群1",@"群2",@"群3",@"群4",@"群5"];
        int gNameLength = arc4random() % gNameArr.count;
        NSString *gStr = gNameArr[gNameLength];
        model.groupName = gStr;
        model.sessionUserName = gStr;
        
        //群成员头像
        NSArray *avtarArray = @[
                                @"http://testapp.gtax.cn/images/2016/11/09/64a62eaaff7b466bb8fab12a89fe5f2f.png!m90x90.png",
                                @"https://testapp.gtax.cn/images/2016/09/30/ad0d18a937b248f88d29c2f259c14b5e.jpg!m90x90.jpg",
                                @"https://testapp.gtax.cn/images/2016/09/14/c6ab40b1bc0e4bf19e54107ee2299523.jpg!m90x90.jpg",
                                @"http://testapp.gtax.cn/images/2016/11/14/8d4ee23d9f5243f98c79b9ce0c699bd9.png!m90x90.png",
                                @"https://testapp.gtax.cn/images/2016/09/14/8cfa9bd12e6844eea0a2e940257e1186.jpg!m90x90.jpg"];
        NSMutableArray <NSURL *>*urlArr = [NSMutableArray new];
        for (int i =0; i<4; i++) {
            [urlArr addObjectsFromArray:avtarArray];
        }
        NSArray *headArray = [urlArr subarrayWithRange:NSMakeRange(0, memLength-1)];
        model.sessionUserHead = headArray;
        
    }else{
    
        //对话用户名字
        NSArray *sessionNickArr = @[@"李一",@"张国富",@"黎明",@"你不是我的菜",@"这名字会好长的啊！呵呵",@"天天",@"我不要要不要" ];
        int sNickLength  = arc4random() % sessionNickArr.count;
        model.sessionUserName = sessionNickArr[sNickLength];
    }
    

    model.status = 0;
    model.updateTime = @"";
    model.creatTime = @"2017-2-27 13:38";
    model.lastCreatTime = @"2017-2-27 9:38";
    return model;
}



@end
