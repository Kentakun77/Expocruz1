//
//  DetailViewController.m
//  Expocruz1
//
//  Created by Cerff on 29/08/14.
//  Copyright (c) 2014 Cerff. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize expositor;
@synthesize nombre;
@synthesize stand;
@synthesize tel;
@synthesize fax;
@synthesize email;
@synthesize pabellon;
@synthesize direccion;


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
    
    nombre.text = expositor.nombre;
    stand.text = expositor.stand;
    tel.text = expositor.tel;
    fax.text = expositor.fax;
    email.text = expositor.email;
    pabellon.text = expositor.pabellon;
    direccion.text = expositor.dir;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
