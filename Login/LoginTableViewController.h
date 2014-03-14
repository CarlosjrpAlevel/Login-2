//
//  LoginTableViewController.h
//  Login
//
//  Created by Ghalia Alrajban on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
// using this delegate to make the keyboard disappear
@interface LoginTableViewController : UITableViewController <UITextFieldDelegate>

// define the main variables
// used to initalize the lable in the table cells
@property (nonatomic, retain) NSArray *arrayLogin;
@property (nonatomic, retain) IBOutlet UITextField *userNameTextField;
@property (nonatomic, retain) IBOutlet UITextField *passwordTextField;

@end
