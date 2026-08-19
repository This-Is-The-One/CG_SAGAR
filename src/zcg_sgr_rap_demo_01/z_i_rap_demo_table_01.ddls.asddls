@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo Table for RAP'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_I_RAP_DEMO_TABLE_01 as select from zsgr_demo_tb_01
{
    key project_uuid as ProjectUuid,
    project_id as ProjectId,
    project_name as ProjectName,
    description as Description,
    project_type as ProjectType,
    category as Category,
    status as Status,
    start_date as StartDate,
    end_date as EndDate,
    @Semantics.amount.currencyCode: 'currency'
    budget as Budget,
    currency as Currency,
    priority as Priority,
    created_by as CreatedBy,
    created_at as CreatedAt,
    is_active as IsActive
}
