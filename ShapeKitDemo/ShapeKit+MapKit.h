//
//  ShapeKit+MapKit.h
//  ShapeKit
//
//  Created by Andrea Cremaschi on 27/06/12.
//
// * This is free software; you can redistribute and/or modify it under
// the terms of the GNU Lesser General Public Licence as published
// by the Free Software Foundation. 
// See the COPYING file for more information.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <ShapeKit/ShapeKit.h>

@interface MKShapeKitGeometry: ShapeKitGeometry
@property (strong, nonatomic) MKShape *mapkitShape;

@end

@interface MKShapeKitPoint: ShapeKitPoint
@property (strong, nonatomic) MKPointAnnotation *mapkitShape;

@end

@interface MKShapeKitPolyline: ShapeKitPolyline
@property (strong, nonatomic) MKPolyline *mapkitShape;
@end

@interface MKShapeKitPolygon: ShapeKitPolygon
@property (strong, nonatomic) MKPolygon *mapkitShape;
+(MKShapeKitPolygon *) polygonWithShapeKitPolygon: (ShapeKitPolygon *)polygon;
@end