//
//  JPSThumbnailAnnotation.m
//  JPSThumbnailAnnotationView
//
//  Created by Jean-Pierre Simard on 4/21/13.
//  Copyright (c) 2013 JP Simard. All rights reserved.
//

#import "JPSThumbnailAnnotation.h"

static NSString * const kDefaultViewClassName = @"JPSThumbnailAnnotationView";

@interface JPSThumbnailAnnotation ()

@property (nonatomic, readwrite) MKAnnotationView <JPSThumbnailAnnotationViewProtocol> *view;
@property (nonatomic, readonly) JPSThumbnail *thumbnail;
@property (nonatomic, copy) NSString *viewClassName;
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
    return [self initWithThumbnail:thumbnail
                     viewClassName:kDefaultViewClassName];
}

- (id)initWithThumbnail:(JPSThumbnail *)thumbnail
          viewClassName:(NSString *)viewClassName {
    self = [super init];
    if (self) {
        _coordinate = thumbnail.coordinate;
        _thumbnail = thumbnail;
        _viewClassName = viewClassName;
    }
    return self;
}
- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView {
    if (!self.view) {
        self.view = [mapView dequeueReusableAnnotationViewWithIdentifier:kJPSThumbnailAnnotationViewReuseID];
        
        Class viewClass = NSClassFromString(self.viewClassName);
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



