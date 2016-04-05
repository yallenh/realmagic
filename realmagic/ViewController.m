//
//  ViewController.m
//  realmagic
//
//  Created by Yan-Hsiang Huang on 4/4/16.
//  Copyright © 2016 Yan-Hsiang Huang. All rights reserved.
//

#import "ViewController.h"
#import "RMService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // [[RMService sharedInstance] requestWithMethod:RMRequestMethodGet url:@"https://news-app.abumedia.yql.yahoo.com/v1/topstory" params:nil responseDataKey:@"items.result"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
