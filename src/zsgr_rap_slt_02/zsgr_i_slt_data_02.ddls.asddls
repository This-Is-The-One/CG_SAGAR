@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Singleton View Enitity'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSGR_I_SLT_DATA_02 as select from zsgr_stl_demo_02
association to parent ZSGR_I_SLT_02 as _Slt
    on $projection.ConfigId = _Slt.singleton_id
{
    key zsgr_stl_demo_02.config_id as ConfigId,
    key zsgr_stl_demo_02.app_id as AppId,
    zsgr_stl_demo_02.app_name as AppName,
    zsgr_stl_demo_02.app_desc as AppDesc,
    zsgr_stl_demo_02.active as Active,
    @Semantics.systemDateTime.createdAt: true
    zsgr_stl_demo_02.created_at as CreatedAt,
    @Semantics.systemDateTime.lastChangedAt: true
    zsgr_stl_demo_02.last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    zsgr_stl_demo_02.local_last_changed as LocalLastChanged,
    _Slt
}
