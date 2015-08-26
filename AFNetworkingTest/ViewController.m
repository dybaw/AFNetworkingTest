//
//  ViewController.m
//  AFNetworkingTest
//
//  Created by robert on 15/8/21.
//  Copyright (c) 2015年 lyp. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"


@interface ViewController ()

//@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) UIButton *button;
//@property (strong,nonatomic) UILabel *label;
//@property (strong,nonatomic) UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //_imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 320, 300)];
    //_imageView.backgroundColor = [UIColor grayColor];
    //[_imageView setImageWithURL:[NSURL URLWithString:@"https://www.baidu.com/img/bd_logo1.png"]];
    //[self.view addSubview:_imageView];
    //_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 380, 320, 40)];
   // _label.backgroundColor = [UIColor grayColor];
    //[self.view addSubview:_label];
    _button = [[UIButton alloc]initWithFrame:CGRectMake(130, 450, 100, 40)];
    _button.backgroundColor = [UIColor blueColor];
    [_button addTarget:self action:@selector(selector:) forControlEvents:UIControlEventTouchDown];
    [_button setTitle:@"Parser" forState:UIControlStateNormal];
    [self.view addSubview:_button];
    //_textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 500, 320, 50)];
    //_textView.backgroundColor = [UIColor grayColor];
    //[self.view addSubview:_textView];

}
//http://www.webxml.com.cn/WebServices/TranslatorWebService.asmx
//http://www.webxml.com.cn/WebServices/TranslatorWebService.asmx/HelloWebXml
//http://rss.sina.com.cn/news/allnews/tech.xml
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//按键点击事件
- (void)selector:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//返回的数据类型
    // NSDictionary *dirc = @{@"formal":@"xml"};
    [manager GET:@"http://rss.sina.com.cn/news/allnews/tech.xml" parameters:nil success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"GET:%@", result);
        _xmlParser = [[NSXMLParser alloc] initWithData:responseObject];
        _xmlParser.delegate = self;
        [_xmlParser parse];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR:%@", error);
    }];
}

/* 开始解析xml文件，在开始解析xml节点前，通过该方法可以做一些初始化工作 */
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"开始解析xml文件");
}

/* 当解析器对象遇到xml的开始标记时，调用这个方法开始解析该节点 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    NSLog(@"发现节点");
    if([elementName isEqualToString:@"title"]){
        if(_newsTitles == nil)
        _newsTitles = [[NSMutableArray alloc] init];
    }
}

/* 当解析器找到开始标记和结束标记之间的字符时，调用这个方法解析当前节点的所有字符 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"正在解析节点内容");
    if(self.tempString == nil)
    self.tempString = [[NSMutableString alloc] init];
    [self.tempString appendString:string];
}

/* 当解析器对象遇到xml的结束标记时，调用这个方法完成解析该节点 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"解析节点结束");
    if([elementName isEqualToString:@"title"]){
        [_newsTitles addObject:self.tempString];
    }
    self.tempString = nil;
}

/* 解析xml出错的处理方法 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"解析xml出错:%@", parseError);
}

/* 解析xml文件结束 */
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    if (!_tempString) {
        _tempString = [[NSMutableString alloc] init];
    }
    for (int i = 0; i < _newsTitles.count; i++){
            [_tempString appendString:_newsTitles[i]];
            NSLog(@"%@",_newsTitles[i]);
            //_textView.text = _newsTitles[i];
            NSLog(@"解析xml文件结束");
    }
}

@end
