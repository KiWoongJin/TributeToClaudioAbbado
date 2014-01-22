//
//  WorkViewController.m
//  TributeToClaudioAbbado
//
//  Created by SDT-1 on 2014. 1. 22..
//  Copyright (c) 2014년 SDT-1. All rights reserved.
//

#import "WorkViewController.h"
#import "MusicViewController.h"

@interface WorkViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation WorkViewController{
    NSArray *imageList;
    NSArray *titleName;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MusicViewController *nextVC = [segue destinationViewController];
    NSIndexPath *selectedIndexPath = [self.table indexPathForSelectedRow];
    nextVC.title2 = [UIImage imageNamed:[imageList objectAtIndex:selectedIndexPath.row]];
    nextVC.name = [titleName objectAtIndex:selectedIndexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MUSIC_CELL" forIndexPath:indexPath];
    cell.textLabel.text = [titleName objectAtIndex:indexPath.row];

    cell.imageView.image =[UIImage imageNamed:[imageList objectAtIndex:indexPath.row]];
    
    
    return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    imageList = @[@"image1.jpg", @"image2.jpg", @"image3.jpg", @"image4.jpg", @"image5.jpg", @"image6.jpg", @"image7.jpg"];
    titleName = @[@"Mahler Symphony No.9 4th.mov.mp3", @"Beethoven Symphony No.9 3rd.mov.mp3", @"Mahler Symphony No.7 5th.mov.mp3", @"Brahms Symphony No.4 1st.mov.mp3", @"Mahler Symphony No.1 4th.mov.mp3", @"Beethoven Symphony No.9 4th.mov.mp3", @"Bramhs Hungarian Dances No.5.mp3"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
