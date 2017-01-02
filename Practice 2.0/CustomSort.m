//
//  CustomSort.m
//  Readable Colors
//
//  Created by cdu on 2017-01-02.
//  Copyright © 2017 Michael Dziuba. All rights reserved.
//


#import "CustomSort.h"



long sortCode;

long sortCode;
int sortCode1;
int sortCode2;
int sortCode3;
int sortCode4;

float arrayHSVColors[7400][4];


@implementation CustomSort




-(void) sortArray{
    switch (sortCode) {
        case 0: sortCode1 = 0; sortCode2 = 2; sortCode3 = 1; sortCode4 = 3; break;
        case 1: sortCode1 = 1; sortCode2 = 2; sortCode3 = 0; sortCode4 = 3; break;
        case 2: sortCode1 = 2; sortCode2 = 1; sortCode3 = 0; sortCode4 = 3; break;
        case 3: sortCode1 = 3; sortCode2 = 1; sortCode3 = 2; sortCode4 = 0; break;
        default: break;
    }
    qsort(arrayHSVColors, 7400, (sizeof arrayHSVColors[0]), compare);
}



int compare (const void *a, const void *b) {
    
    if(((const float *)a)[sortCode1] < ((const float *)b)[sortCode1]){
        return 1;
    }else if(((const float *)a)[sortCode1] > ((const float *)b)[sortCode1]){
        return -1;
    }else if(((const float *)a)[sortCode2] < ((const float *)b)[sortCode2]){
        return 1;
    }else if(((const float *)a)[sortCode2] > ((const float *)b)[sortCode2]){
        return -1;
    }else if(((const float *)a)[sortCode3] < ((const float *)b)[sortCode3]){
        return 1;
    }else if(((const float *)a)[sortCode3] > ((const float *)b)[sortCode3]){
        return -1;
    }else if(((const float *)a)[sortCode4] < ((const float *)b)[sortCode4]){
        return 1;
    }else if(((const float *)a)[sortCode4] > ((const float *)b)[sortCode4]){
        return -1;
    }
    return 0;
}

@end
