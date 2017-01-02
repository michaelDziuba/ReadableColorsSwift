//
//  CustomSort.h
//  Readable Colors
//
//  Created by cdu on 2017-01-02.
//  Copyright © 2017 Michael Dziuba. All rights reserved.
//

//#ifndef CustomSort_h
//#define CustomSort_h
//
//
//
//
//#endif /* CustomSort_h */



//@interface CustomSort: NSObject{
//    
//    
//@property  sortCode;
//@public int sortCode1;
//@public int sortCode2;
//@public int sortCode3;
//@public int sortCode4;
//    
//@public float arrayHSVColors[7400][4];
//    
//}
//
//
//int compare (const void *a, const void *b);
//
//
//-(void) sortArray;
//
//
//
//@end

#import <UIKit/UIKit.h>

@interface CustomSort : NSObject

@property (strong, nonatomic) id sortCode;
@property (strong, nonatomic) id sortCode1;
@property (strong, nonatomic) id sortCode2;
@property (strong, nonatomic) id sortCode3;
@property (strong, nonatomic) id sortCode4;

@property (strong, nonatomic) id arrayHSVColors;

int compare (const void *a, const void *b);

- (void) sortArray : (int) sortCode : (float* [7400][4]) arrayHSVColors;

@end
