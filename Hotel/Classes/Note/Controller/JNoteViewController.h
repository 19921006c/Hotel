//
//  JNoteViewController.h
//  Hotel
//
//  Created by J on 16/7/21.
//  Copyright © 2016年 J. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JNoteViewController : UIViewController{

    __weak IBOutlet UISearchBar *searchBar;
    
    IBOutlet UISearchDisplayController *searchDisplayController;
}

@end
