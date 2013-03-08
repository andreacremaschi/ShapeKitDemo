//
//  ShapeKit+MapKit.m
//  ShapeKit
//
//  Created by Andrea Cremaschi on 27/06/12.
//  Copyright (c) 2012 independent. All rights reserved.
//

#import "ShapeKit+MapKit.h"

@implementation MKShapeKitPoint
- (MKPointAnnotation *)mapkitShape
{
    if (!_mapkitShape) {
        _mapkitShape = [[MKPointAnnotation alloc] init];
        [(MKPointAnnotation *)_mapkitShape setCoordinate: self.coordinate];
    }
    return _mapkitShape;
}
@end

@implementation MKShapeKitPolyline
- (MKPolyline *)mapkitShape
{
    if (!_mapkitShape) {
        CLLocationCoordinate2D coords[self.numberOfCoords];
        for (int i=0;i<self.numberOfCoords;i++)
            coords[i]=[self coordinateAtIndex:i];
        _mapkitShape = [MKPolyline polylineWithCoordinates: coords count: self.numberOfCoords];
    }
    return _mapkitShape;
}

@end

@implementation MKShapeKitPolygon
- (MKPolygon *)mapkitShape
{
    if (!_mapkitShape) {
        CLLocationCoordinate2D coords[self.numberOfCoords];
        for (int i=0;i<self.numberOfCoords;i++)
            coords[i]=[self coordinateAtIndex:i];
        _mapkitShape = [MKPolygon polygonWithCoordinates: coords count: self.numberOfCoords];
    }
    return _mapkitShape;
}

+(MKShapeKitPolygon *) polygonWithShapeKitPolygon: (ShapeKitPolygon *)polygon
{
    CLLocationCoordinate2D *coords = malloc (sizeof(CLLocationCoordinate2D) * polygon.numberOfCoords);
    for (int i=0;i<polygon.numberOfCoords;i++)
        coords[i] = [polygon coordinateAtIndex:i];
    MKShapeKitPolygon *newPoly = [[MKShapeKitPolygon alloc] initWithCoordinates:coords count:polygon.numberOfCoords];
    return newPoly;
}

@end
