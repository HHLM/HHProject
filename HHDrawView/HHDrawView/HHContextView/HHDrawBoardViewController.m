//
//  HHDrawBoardViewController.m
//  HHDrawView
//
//  Created by Mac on 2018/6/10.
//  Copyright © 2018年 Now. All rights reserved.
//

#import "HHDrawBoardViewController.h"
#import "HHDrawBoardView.h"
#import "HHDrawTopView.h"
@interface HHDrawBoardViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet HHDrawBoardView *drawView;

@end

@implementation HHDrawBoardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)repeal:(id)sender {
    [self.drawView repealPath];
}
- (IBAction)clear:(id)sender {
    [self.drawView clearPath];
}
- (IBAction)erasure:(id)sender {
    self.drawView.lineColor = self.drawView.backgroundColor;
}
- (IBAction)choosePhoto:(id)sender {
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.delegate = self;
    vc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSLog(@"%@",info);
    UIImage *image  = info[UIImagePickerControllerOriginalImage];
    
    HHDrawTopView *topView = [[HHDrawTopView alloc] initWithFrame:self.drawView.bounds];
    [self.drawView addSubview:topView];
    [topView setBlock:^(UIImage *image) {
        self.drawView.image = image;
    }];
    
    topView.image = image;
    [self imagePickerControllerDidCancel:picker];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)savePhoto:(id)sender {
    [self.drawView savePhoto];
}
- (IBAction)setColor:(UIButton *)sender {
    
    UIColor *selectColor = [UIColor redColor];
    if (sender.tag == 0) {
        selectColor = [UIColor redColor];
    }else if (sender.tag == 1) {
        selectColor = [UIColor orangeColor];
    }else if (sender.tag == 2) {
        selectColor = [UIColor yellowColor];
    }else if (sender.tag == 3) {
        selectColor = [UIColor greenColor];
    }else if (sender.tag == 4) {
        selectColor = [UIColor cyanColor];
    }else if (sender.tag == 5) {
        selectColor = [UIColor blueColor];
    }else if (sender.tag == 6) {
        selectColor = [UIColor purpleColor];
    }
    self.drawView.lineColor = selectColor;
}
- (IBAction)changeValue:(UISlider *)sender {
    self.drawView.lineWidth = sender.value;
}



@end
