// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Product.h instead.

#import <CoreData/CoreData.h>


extern const struct ProductAttributes {
	__unsafe_unretained NSString *brandName;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *image;
	__unsafe_unretained NSString *price;
	__unsafe_unretained NSString *productName;
	__unsafe_unretained NSString *productPage;
	__unsafe_unretained NSString *sku;
} ProductAttributes;

extern const struct ProductRelationships {
} ProductRelationships;

extern const struct ProductFetchedProperties {
} ProductFetchedProperties;










@interface ProductID : NSManagedObjectID {}
@end

@interface _Product : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ProductID*)objectID;





@property (nonatomic, strong) NSString* brandName;



//- (BOOL)validateBrandName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int16_t idValue;
- (int16_t)idValue;
- (void)setIdValue:(int16_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* image;



//- (BOOL)validateImage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* price;



@property int16_t priceValue;
- (int16_t)priceValue;
- (void)setPriceValue:(int16_t)value_;

//- (BOOL)validatePrice:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* productName;



//- (BOOL)validateProductName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* productPage;



//- (BOOL)validateProductPage:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* sku;



//- (BOOL)validateSku:(id*)value_ error:(NSError**)error_;






@end

@interface _Product (CoreDataGeneratedAccessors)

@end

@interface _Product (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveBrandName;
- (void)setPrimitiveBrandName:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int16_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int16_t)value_;




- (NSString*)primitiveImage;
- (void)setPrimitiveImage:(NSString*)value;




- (NSNumber*)primitivePrice;
- (void)setPrimitivePrice:(NSNumber*)value;

- (int16_t)primitivePriceValue;
- (void)setPrimitivePriceValue:(int16_t)value_;




- (NSString*)primitiveProductName;
- (void)setPrimitiveProductName:(NSString*)value;




- (NSString*)primitiveProductPage;
- (void)setPrimitiveProductPage:(NSString*)value;




- (NSString*)primitiveSku;
- (void)setPrimitiveSku:(NSString*)value;




@end
