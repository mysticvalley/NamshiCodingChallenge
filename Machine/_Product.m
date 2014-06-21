// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Product.m instead.

#import "_Product.h"

const struct ProductAttributes ProductAttributes = {
	.brandName = @"brandName",
	.image = @"image",
	.pid = @"pid",
	.price = @"price",
	.productName = @"productName",
	.productPage = @"productPage",
	.sku = @"sku",
};

const struct ProductRelationships ProductRelationships = {
};

const struct ProductFetchedProperties ProductFetchedProperties = {
};

@implementation ProductID
@end

@implementation _Product

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Product";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Product" inManagedObjectContext:moc_];
}

- (ProductID*)objectID {
	return (ProductID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"pidValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pid"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}
	if ([key isEqualToString:@"priceValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"price"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic brandName;






@dynamic image;






@dynamic pid;



- (int16_t)pidValue {
	NSNumber *result = [self pid];
	return [result shortValue];
}

- (void)setPidValue:(int16_t)value_ {
	[self setPid:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePidValue {
	NSNumber *result = [self primitivePid];
	return [result shortValue];
}

- (void)setPrimitivePidValue:(int16_t)value_ {
	[self setPrimitivePid:[NSNumber numberWithShort:value_]];
}





@dynamic price;



- (int16_t)priceValue {
	NSNumber *result = [self price];
	return [result shortValue];
}

- (void)setPriceValue:(int16_t)value_ {
	[self setPrice:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePriceValue {
	NSNumber *result = [self primitivePrice];
	return [result shortValue];
}

- (void)setPrimitivePriceValue:(int16_t)value_ {
	[self setPrimitivePrice:[NSNumber numberWithShort:value_]];
}





@dynamic productName;






@dynamic productPage;






@dynamic sku;











@end
