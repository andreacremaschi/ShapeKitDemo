//
//  ShapeKitViewController.m
//  ShapeKit
//
//  Created by Michael Weisman on 10-08-21.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ShapeKitViewController.h"
#import <ShapeKit/ShapeKit.h>
#import "ShapeKit+MapKit.h"

#import "NSString+HexToData.h"


@implementation ShapeKitViewController
@synthesize theMap;



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

- (ShapeKitGeometry *)loadWKBGeometryFromFile:(NSString *)file {
    ShapeKitGeometry *geometry = nil;
	NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"plist"];
	NSDictionary *stupidDict = [NSDictionary dictionaryWithContentsOfFile:path];
	NSData *geomData = [stupidDict objectForKey:@"shape"];
	if (geomData && [geomData length]) {
		// poly = [[ShapeKitPolygon alloc] initWithWKB:[geomData bytes] size:[geomData length]];
        geometry = [[ShapeKitFactory defaultFactory] geometryWithWKB: geomData];
        
	}
	return geometry;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create some geometries and add them to the map view
    MKShapeKitPoint *myPoint = [[MKShapeKitPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(49.283592, -123.104997)];
    myPoint.mapkitShape.title = @"0 0";
    myPoint.mapkitShape.subtitle = @"Next to the most awesome place in the world";
    [theMap addAnnotation:myPoint.mapkitShape];

    // Create some geometries more and add them to the map view
    MKShapeKitPoint *myPoint2 = [[MKShapeKitPoint alloc] initWithCoordinate:CLLocationCoordinate2DMake(45.67932, 9.673462)];
    myPoint.mapkitShape.title = @"0 0";
    myPoint.mapkitShape.subtitle = @"Not bad here neither";
    [theMap addAnnotation:myPoint2.mapkitShape];

    // Create a polygon and run it through the predicates with the point
    //ShapeKitPolygon *polygon = [[ShapeKitPolygon alloc] initWithWKT:@"POLYGON((-1 -1, -1 1, 1 1, 1 -1, -1 -1))"];
    CLLocationCoordinate2D polyCoords[7];
    polyCoords[0] = CLLocationCoordinate2DMake(49.283894529188,-123.102176803645);
    polyCoords[1] = CLLocationCoordinate2DMake(49.282388289451,-123.102213028432);
    polyCoords[2] = CLLocationCoordinate2DMake(49.2824077667387,-123.103291100283);
    polyCoords[3] = CLLocationCoordinate2DMake(49.2838335164225,-123.1034755758);
    polyCoords[4] = CLLocationCoordinate2DMake(49.2838684091301,-123.103369232099);
    polyCoords[5] = CLLocationCoordinate2DMake(49.2838634036584,-123.102745005068);
    polyCoords[6] = CLLocationCoordinate2DMake(49.283894529188,-123.102176803645);
    MKShapeKitPolygon *polygon = [[MKShapeKitPolygon alloc] initWithCoordinates:polyCoords count:7];
    polygon.mapkitShape.title = @"foo";
    [theMap addOverlay:polygon.mapkitShape];
    
    if ([polygon isDisjointFromGeometry:myPoint]) {
        NSLog(@"Disjoined");
    } else {
        NSLog(@"Not Disjoined");
    }
    
    if ([polygon touchesGeometry:myPoint]) {
        NSLog(@"Touches");
    } else {
        NSLog(@"Does not Touch");
    }
    
    if ([polygon intersectsGeometry:myPoint]) {
        NSLog(@"Intersects");
    } else {
        NSLog(@"No Intersect");
    }
    
    if ([polygon crossesGeometry:myPoint]) {
        NSLog(@"Crosses");
    } else {
        NSLog(@"Does not Cross");
    }
    
    if ([polygon isWithinGeometry:myPoint]) {
        NSLog(@"Within");
    } else {
        NSLog(@"Not Within");
    }
    
    if ([polygon containsGeometry:myPoint]) {
        NSLog(@"Contains");
    } else {
        NSLog(@"Does not Contain");
    }
    
    if ([polygon overlapsGeometry:myPoint]) {
        NSLog(@"Overlaps");
    } else {
        NSLog(@"Does Not Overlap");
    }
    
    if ([polygon isEqualToGeometry:myPoint]) {
        NSLog(@"Equals");
    } else {
        NSLog(@"Does Not Equal");
    }
    
    if ([polygon isRelatedToGeometry:myPoint WithRelatePattern:@"*********"]) {
        NSLog(@"Related with Pattern");
    } else {
        NSLog(@"Not Related with Pattern");
    }
    NSLog(@"Realtionship bewteen point and polygon: %@",[myPoint relationshipWithGeometry:polygon]);
    
    // Make a Polyline
/*    CLLocationCoordinate2D coords[5];
    coords[0] = CLLocationCoordinate2DMake(49.283245,-123.105370);
    coords[1] = CLLocationCoordinate2DMake(49.283485,-123.106674);
    coords[2] = CLLocationCoordinate2DMake(49.281200,-123.107620);
    coords[3] = CLLocationCoordinate2DMake(49.278542,-123.107796);
    coords[4] = CLLocationCoordinate2DMake(49.279720,-123.109703);
    
    MKShapeKitPolyline *line = [[MKShapeKitPolyline alloc] initWithCoordinates:coords count:5];
	
	// Reproject the line to Google Web Merc
//	line.projDefinition = @"+proj=latlong +datum=WGS84";
	[line reprojectTo:@"+proj=merc +a=6378137 +b=6378137 +lat_ts=0.0 +lon_0=0.0 +x_0=0.0 +y_0=0 +k=1.0 +units=m +nadgrids=@null +wktext +no_defs"];	
	
    [theMap addOverlay:line.geometry];
    
    [theMap addOverlay:[line envelope].geometry];
    [theMap addOverlay:[line bufferWithWidth:0.005].geometry];
    [theMap addOverlay:[line convexHull].geometry];
    [theMap addAnnotation:[line pointOnSurface].geometry];
    [theMap addAnnotation:[line centroid].geometry];
*/
    ShapeKitPolygon *wkbPolygon = (ShapeKitPolygon*)[self loadWKBGeometryFromFile: @"PlanID20-82"];
    MKShapeKitPolygon *myPolygon = [MKShapeKitPolygon polygonWithShapeKitPolygon: wkbPolygon];
    myPolygon.mapkitShape.title = @"82";
	[theMap addOverlay: myPolygon.mapkitShape];

    ShapeKitPolygon *wkbPolygon2 = (ShapeKitPolygon*)[self loadWKBGeometryFromFile: @"PlanID20-83"];
    MKShapeKitPolygon *myPolygon2 = [MKShapeKitPolygon polygonWithShapeKitPolygon: wkbPolygon2];
    myPolygon2.mapkitShape.title = @"83";
	[theMap addOverlay: myPolygon2.mapkitShape];
    
    ShapeKitPolygon *wkbPolygon3 = (ShapeKitPolygon*)[self loadWKBGeometryFromFile: @"PlanID20-84"];
    MKShapeKitPolygon *myPolygon3 = [MKShapeKitPolygon polygonWithShapeKitPolygon: wkbPolygon3];
    myPolygon3.mapkitShape.title = @"84";
	[theMap addOverlay: myPolygon3.mapkitShape];
	


}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



#pragma mark -
#pragma mark MapView Delegate methods

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView *polylineView = [[MKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [UIColor redColor];
        polylineView.lineWidth = 5.0;

        return polylineView;
        
    } else if ([overlay isKindOfClass:[MKPolygon class]]) {
        MKPolygonView *polygonView = [[MKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [UIColor redColor];
        polygonView.lineWidth = 5.0;
        polygonView.fillColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.5];
        
        return polygonView;
    }
	
	return nil;
}

@end
