//
//  JPSThumbnailAnnotation.m
//  JPSThumbnailAnnotationView
//
//  Created by Jean-Pierre Simard on 4/21/13.
//  Copyright (c) 2013 JP Simard. All rights reserved.
//

#import "JPSThumbnailAnnotation.h"

@interface JPSThumbnailAnnotation ()

@property (nonatomic, readwrite) MKAnnotationView <JPSThumbnailAnnotationViewProtocol> *view;
@property (nonatomic, readonly) JPSThumbnail *thumbnail;

@end

@implementation JPSThumbnailAnnotation

+ (instancetype)annotationWithThumbnail:(JPSThumbnail *)thumbnail {
    return [[self alloc] initWithThumbnail:thumbnail];
}

- (id)initWithThumbnail:(JPSThumbnail *)thumbnail {
    self = [super init];
    if (self) {
        _coordinate = thumbnail.coordinate;
        _thumbnail = thumbnail;
    }
    return self;
}

- (NSString *)thumbnailAnnotationViewClass {
    return @"JPSThumbnailAnnotationView";
}

- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView {
    if (!self.view) {
        self.view = [mapView dequeueReusableAnnotationViewWithIdentifier:kJPSThumbnailAnnotationViewReuseID];
        
        Class viewClass = NSClassFromString([self thumbnailAnnotationViewClass]);
        if (!self.view) self.view = [[viewClass alloc] initWithAnnotation:self];
    } else {
        self.view.annotation = self;
    }
    [self updateThumbnail:self.thumbnail animated:NO];
    return self.view;
}

- (void)updateThumbnail:(JPSThumbnail *)thumbnail animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.33f animations:^{
            _coordinate = thumbnail.coordinate; // use ivar to avoid triggering setter
        }];
    } else {
        _coordinate = thumbnail.coordinate; // use ivar to avoid triggering setter
    }
    
    [self.view updateWithThumbnail:thumbnail];
}

@end

