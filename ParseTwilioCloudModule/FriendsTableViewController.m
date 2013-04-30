//
//  FriendsTableViewController.m
//  ParseTwilioCloudModule
//
//  Created by Mattieu Gamache-Asselin on 11/2/12.
//

#import "FriendsTableViewController.h"
#import "AddFriendViewController.h"

@implementation FriendsTableViewController

- (id)init {
    self = [super init];
    if (self) {
        // Initialization properties
        self.className = @"Friend";
        self.textKey = @"name";
        self.paginationEnabled = YES;
        self.objectsPerPage = 20;
        self.title = @"Parse and Twilio!";

        // Add Contacts navbar button
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Contacts" style:UIBarButtonItemStyleBordered target:self action:@selector(inviteContactButtonTouchHandler:)];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriendButtonTouchHandler:)];
    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}


#pragma mark - PFQueryTableViewController

/* Set the Parse query run by the PFQueryTableViewController */
- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    return query;
}


#pragma mark - UITableViewDelegate

/* Call sendSMS with appropriate phone number when row is selected */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PFObject * selectedFriend = [self.objects objectAtIndex:indexPath.row];
    [self sendSMSToNumber:[selectedFriend objectForKey:@"number"]];
}


#pragma mark - ABPeoplePickerDelegate

/* Always allow looking at address book contacts details */
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

/* Send invitation text to phone number when an address book contact is selected */
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    if (property == kABPersonPhoneProperty) {
        // Get selected phone number
        ABMultiValueRef phoneProperty = ABRecordCopyValue(person,property);
        NSString *phoneNumber = (__bridge_transfer NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,identifier);
        
        // Make Cloud Code function call
        [self sendSMSToNumber:phoneNumber];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    return NO;
}

/* Called when the user cancels the address book view controller. We simply dismiss it. */
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ()

/* Button touch handler for the contact navigation bar button */
- (void)inviteContactButtonTouchHandler:(id)sender {
    ABPeoplePickerNavigationController *addressBook = [[ABPeoplePickerNavigationController alloc] init];
    addressBook.peoplePickerDelegate = self;
    addressBook.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    [self presentViewController:addressBook animated:YES completion:nil];
}

- (void)addFriendButtonTouchHandler:(id)sender {
    AddFriendViewController *addFriendController = [[AddFriendViewController alloc] initWithNibName:@"AddFriendViewController" bundle:nil];
    [self.navigationController pushViewController:addFriendController animated:YES];
}

/* Send invitation SMS to a phone number using Cloud Code and Twilio! */
- (void)sendSMSToNumber:(NSString *)number {
    NSDictionary *params = [NSDictionary dictionaryWithObject:number forKey:@"number"];
    [PFCloud callFunctionInBackground:@"inviteWithTwilio" withParameters:params block:^(id object, NSError *error) {
        NSString *message = @"";
        if (!error) {
            message = @"Your SMS invitation has been sent!";
        } else {
            message = @"Uh oh, something went wrong :(";
        }
        
        [[[UIAlertView alloc] initWithTitle:@"Invite Sent!"
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil, nil] show];
        [self.tableView reloadData];
    }];
}
@end
