@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composition table for Singleton'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSGR_I_SINGLETON_DATA as select from zsgr_demo_tb_01
association to parent ZSGR_I_SINGLETON as _Singleton
on $projection.Singleton = _Singleton.Singleton
{
    key '1' as Singleton,
    key project_uuid as ProjectUuid,
    project_id as ProjectId,
    project_name as ProjectName,
//    description as Description,
    project_type as ProjectType,
//    category as Category,
//    status as Status,
    start_date as StartDate,
    end_date as EndDate,
//    @Semantics.amount.currencyCode: 'Currency'
//    budget as Budget,
//    currency as Currency,
//    priority as Priority,
    created_by as CreatedBy,
    created_at as CreatedAt,
    is_active as IsActive,
    _Singleton
}
