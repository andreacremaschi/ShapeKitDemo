//
//  ShapeKit+MapKit.m
//  ShapeKit
//
//  Created by Andrea Cremaschi on 27/06/12.
//  Copyright (c) 2012 independent. All rights reserved.
//

#import "ShapeKit+MapKit.h"
#import <MapKit/MapKit.h>

@implementation MKShapeKitPoint
- (MKPointAnnotation *)geometry
{
    if (!_geometry) {
        _geometry = [[MKPointAnnotation alloc] init];
        [(MKPointAnnotation *)_geometry setCoordinate: self.coordinate];
    }
    return _geometry;
}
@end

@implementation MKShapeKitPolyline
- (MKPolyline *)geometry
{
    if (!_geometry) {
        CLLocationCoordinate2D coords[self.numberOfCoords];
        for (int i=0;i<self.numberOfCoords;i++)
            coords[i]=[self coordinateAtIndex:i];
        _geometry = [MKPolyline polylineWithCoordinates: coords count: self.numberOfCoords];
    }
    return _geometry;
}

@end

@implementation MKShapeKitPolygon
- (MKPolygon *)geometry
{
    if (!_geometry) {
        CLLocationCoordinate2D coords[self.numberOfCoords];
        for (int i=0;i<self.numberOfCoords;i++)
            coords[i]=[self coordinateAtIndex:i];
        _geometry = [MKPolygon polygonWithCoordinates: coords count: self.numberOfCoords];
    }
    return _geometry;
}

@end
