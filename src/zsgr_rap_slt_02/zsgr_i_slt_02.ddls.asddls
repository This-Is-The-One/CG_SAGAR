@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Singleton Root View Enitity'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSGR_I_SLT_02 as select from I_Language
left outer join zsgr_stl_demo_02 as T on 1 = 1
composition[1..*] of ZSGR_I_SLT_DATA_02 as _Data
{
    key 1 as singleton_id,
    @Semantics.systemDateTime.lastChangedAt: true
    cast(
        max(T.local_last_changed) as timestampl
    ) as LastChangedAt_SLT,
    _Data
}

where I_Language.Language = $session.system_language
