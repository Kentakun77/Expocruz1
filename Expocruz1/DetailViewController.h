//
//  DetailViewController.h
//  Expocruz1
//
//  Created by Cerff on 29/08/14.
//  Copyright (c) 2014 Cerff. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expositor.h"


@interface DetailViewController : UIViewController

{
    Expositor *expositor;
    UILabel *nombre;
    UILabel *stand;
    UILabel *tel;
    UILabel *fax;
    UILabel *email;
    UILabel *direccion;
    UILabel *pabellon;
}
@property (nonatomic,retain) Expositor *expositor;
@property (nonatomic,retain) IBOutlet UILabel *nombre;
@property (nonatomic,retain) IBOutlet UILabel *stand;
@property (nonatomic,retain) IBOutlet UILabel *tel;
@property (nonatomic,retain) IBOutlet UILabel *fax;
@property (nonatomic,retain) IBOutlet UILabel *email;
@property (nonatomic,retain) IBOutlet UILabel *direccion;
@property (nonatomic,retain) IBOutlet UILabel *pabellon;

@end

