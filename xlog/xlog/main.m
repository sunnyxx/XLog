//
//  main.m
//  xlog
//
//  Created by sunny on 13-9-23.
//
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        NSLog(@"%d", argc);
        for (int i = 0; i < argc; i++)
        {
            NSLog(@"%s", argv[i]);

        }
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
