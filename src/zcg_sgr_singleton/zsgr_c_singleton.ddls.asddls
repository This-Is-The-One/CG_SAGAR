@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Root Singleton'
@Metadata.allowExtensions: true
define root view entity ZSGR_C_SINGLETON
  provider contract transactional_query 
as projection on ZSGR_I_SINGLETON
{
    key Singleton,
//    Description,
    /* Associations */
    _data : redirected to composition child ZSGR_C_SINGLETON_DATA
}
