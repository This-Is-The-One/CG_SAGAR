@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Root Singleton Data'
@Metadata.allowExtensions: true
define view entity ZSGR_C_SINGLETON_DATA 
as projection on ZSGR_I_SINGLETON_DATA
{
    key Singleton,
    key ProjectUuid,
    ProjectId,
    ProjectName,
//    Description,
    ProjectType,
//    Category,
//    Status,
    StartDate,
    EndDate,
//    @Semantics.amount.currencyCode: 'Currency'
//    Budget,
//    Currency,
//    Priority,
    CreatedBy,
    CreatedAt,
    IsActive,
    /* Associations */
    _Singleton : redirected to parent ZSGR_C_SINGLETON
}
