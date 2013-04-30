//
//  FriendsTableViewController.h
//  ParseTwilioCloudModule
//
//  Created by Mattieu Gamache-Asselin on 11/2/12.
//

#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import <Parse/Parse.h>

@interface FriendsTableViewController : PFQueryTableViewController <ABPeoplePickerNavigationControllerDelegate>

- (void)inviteContactButtonTouchHandler:(id)sender;
- (void)addFriendButtonTouchHandler:(id)sender;
- (void)sendSMSToNumber:(NSString *)number;

@end
