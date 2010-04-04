//
//  PTProject.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "PTPerson.h"
#import "PTProject.h"

@implementation PTProject

@synthesize name;
@synthesize id;
@synthesize velocity;
@synthesize members;

- (PTPerson*)memberNamed:(NSString*)fullName
{
        // TODO: Memoize this, in case it turns out to be called _often_.
        for (int i = 0; i < [members count]; i++) {
                PTPerson *person = [members objectAtIndex:i];
                if ([fullName isEqualToString:person.name])
                        return person;
        }

        return nil;
}

@end
