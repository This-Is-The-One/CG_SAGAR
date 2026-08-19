@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity CDS View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSGR_I_SINGLETON as select from zsgr_dum_slt
composition[0..*] of ZSGR_I_SINGLETON_DATA as _data
{
    key dummy_id as Singleton,
//    cast( 'Singleton Object' as abap.char(50) ) as Description,
//    max(_data.CreatedAt) as LastChangedAt,
    _data
}
where dummy_id = '1'
