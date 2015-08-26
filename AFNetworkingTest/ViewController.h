//
//  ViewController.h
//  AFNetworkingTest
//
//  Created by robert on 15/8/21.
//  Copyright (c) 2015年 lyp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *newsTitles;      // 标题
@property (nonatomic, strong) NSMutableArray *newsDescription; // 摘要
@property (nonatomic, strong) NSMutableArray *newsPublicDates; // 发布时间
@property (nonatomic, strong) NSMutableString *tempString;     // 用于临时保存解析的字符数据
@property (nonatomic, strong) NSXMLParser *xmlParser; // XML解析器


@end

