//
//  LoginTableViewController.m
//  Login
//
//  Created by Ghalia Alrajban on 12/21/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "LoginTableViewController.h"
#import "AppDelegate.h"
#import "AppMainView.h"

@implementation LoginTableViewController
@synthesize arrayLogin;
@synthesize userNameTextField, passwordTextField;

bool isKeyboardVisible = FALSE;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // initalize array:
    arrayLogin = [[NSArray alloc] initWithObjects:@"user name", @"password", nil];
    // set the titel:
    self.navigationItem.title= @"Best App";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardAppeared) name:UIKeyboardDidShowNotification object:nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) keyboardAppeared{
    if (isKeyboardVisible == FALSE) {
        isKeyboardVisible = true;
        
        UIBarButtonItem *btnGo = [[UIBarButtonItem alloc] initWithTitle:@"Go" style:UIBarButtonItemStyleBordered target:self action:@selector(loginAction)];
        self.navigationItem.rightBarButtonItem = btnGo;
    }
}

- (void) loginAction{
    if ([userNameTextField.text isEqualToString:@"0"] || [passwordTextField.text isEqualToString:@"0"]) {
        // i need to get the control for main navigation controller
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        [appDelegate.navigationController popToRootViewControllerAnimated:NO];
        // create object from app main view to push it
        AppMainView *appMainView = [[AppMainView alloc] initWithNibName:@"AppMainView" bundle:nil];
        [appDelegate.navigationController pushViewController:appMainView animated:YES];
    }
    if ([userNameTextField.text isEqualToString:@""] || [passwordTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Please Fill all the field" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    // i will use a code from connect to DB tutorial
    NSString *strURL = [NSString stringWithFormat:@"http://localhost/MAMP/login.php?userName=%@&password=%@",userNameTextField.text, passwordTextField.text];
    
    // to execute php code
    NSData *dataURL = [NSData dataWithContentsOfURL:[NSURL URLWithString:strURL]];
    
    // to receive the returend value
    NSString *strResult = [[NSString alloc] initWithData:dataURL encoding:NSUTF8StringEncoding];
    
    if ([strResult isEqualToString:@"1"])
    {
        // i need to get the control for main navigation controller
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        [appDelegate.navigationController popToRootViewControllerAnimated:NO];
        // create object from app main view to push it
        AppMainView *appMainView = [[AppMainView alloc] initWithNibName:@"AppMainView" bundle:nil];
        [appDelegate.navigationController pushViewController:appMainView animated:YES];
    }else
    {
        // invalid information
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"alert" message:@"Invalide Information" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.arrayLogin = nil;
    self.userNameTextField = nil; 
    self.passwordTextField = nil; 
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [arrayLogin count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // create frame for lables in cell and textfields
    
    // the cells are not selectable.!!
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CGRect frame;
    frame.origin.x = 10;
    frame.origin.y = 10;
    frame.size.height = 30;
    frame.size.width = 200;
    
    UILabel *label = [[UILabel alloc] initWithFrame: frame];
    
    label.font = [UIFont boldSystemFontOfSize:16.0];
    label.text = [arrayLogin objectAtIndex:indexPath.row];
    [cell.contentView addSubview:label];
    
    frame.origin.x = 110;
    frame.size.height = 90;
    frame.size.width = 180;
    // textfield part, 
    if (indexPath.row == 0) {//user name part
        userNameTextField = [[UITextField alloc ] initWithFrame: frame];
        userNameTextField.returnKeyType  = UIReturnKeyDefault;
        userNameTextField.delegate = self;
        [cell.contentView addSubview:userNameTextField];
    }else
    {
        //password part
        passwordTextField = [[UITextField alloc] initWithFrame:frame];
        passwordTextField.returnKeyType = UIReturnKeyDefault;
        passwordTextField.secureTextEntry = YES;
        passwordTextField.delegate = self;
        [cell.contentView addSubview:passwordTextField];
    }
    // Configure the cell...
    
    return cell;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
