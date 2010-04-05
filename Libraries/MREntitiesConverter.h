//
//  MREntities.h
//  TrackerPad
//
//  Created by Jakob Borg on 4/5/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MREntitiesConverter : NSObject {
        NSMutableString *resultString;
}

- (NSString*)convertEntiesInString:(NSString*)s;

@end
