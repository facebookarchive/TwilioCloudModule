//
//  AddFriendViewController.h
//  ParseTwilioCloudModule
//
//  Created by Matt GA on 11/2/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AddFriendViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *phoneField;
@property (nonatomic, strong) IBOutlet UIButton *addButton;

- (IBAction)addFriendButtonHandler:(id)sender;

@end
