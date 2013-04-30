//
//  AddFriendViewController.m
//  ParseTwilioCloudModule
//
//  Created by Matt GA on 11/2/12.
//

#import "AddFriendViewController.h"


@implementation AddFriendViewController


- (void)viewDidLoad {
    [self.addButton addTarget:self action:@selector(addFriendButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
}

/* Create new friend object and add to Parse */
- (IBAction)addFriendButtonHandler:(id)sender {    
    // Make sure fields were filled out
    if ([self.nameField.text length] == 0 || [self.phoneField.text length] == 0)
    {
        [[[UIAlertView alloc] initWithTitle:@"Forgot Something" message:@"You need to add a phone number and a name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
    // Create new Friend object and save it
    PFObject *friend = [[PFObject alloc] initWithClassName:@"Friend"];
    [friend setObject:self.nameField.text forKey:@"name"];
    [friend setObject:self.phoneField.text forKey:@"number"];
    [friend saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Something Went Wrong" message:@"Uh oh, try again!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    }];
}

@end
