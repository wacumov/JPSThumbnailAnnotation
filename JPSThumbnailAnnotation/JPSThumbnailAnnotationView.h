//
//  JPSThumbnailAnnotationView.h
//  JPSThumbnailAnnotationView
//
//  Created by Jean-Pierre Simard on 4/21/13.
//  Copyright (c) 2013 JP Simard. All rights reserved.
//

@import MapKit;

@class JPSThumbnail;

extern NSString * const kJPSThumbnailAnnotationViewReuseID;

typedef NS_ENUM(NSInteger, JPSThumbnailAnnotationViewAnimationDirection) {
    JPSThumbnailAnnotationViewAnimationDirectionGrow,
    JPSThumbnailAnnotationViewAnimationDirectionShrink,
};

typedef NS_ENUM(NSInteger, JPSThumbnailAnnotationViewState) {
    JPSThumbnailAnnotationViewStateCollapsed,
    JPSThumbnailAnnotationViewStateExpanded,
    JPSThumbnailAnnotationViewStateAnimating,
};

@protocol JPSThumbnailAnnotationViewProtocol <NSObject>

- (void)didSelectAnnotationViewInMap:(MKMapView *)mapView;
- (void)didDeselectAnnotationViewInMap:(MKMapView *)mapView;

- (void)updateWithThumbnail:(JPSThumbnail *)thumbnail;

@end

@interface JPSThumbnailAnnotationView : MKAnnotationView <JPSThumbnailAnnotationViewProtocol>

- (id)initWithAnnotation:(id<MKAnnotation>)annotation;

// Programmatically expand the annotation
- (void)expand;

// Programmatically shrink the annotation
- (void)shrink;

@end
