@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for ZTB_EMPLOYEE_01'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_I_EMPLOYEE_01 as select from ztb_employee_01
association[0..*] to Z_I_TRV_REQ_01 as _TravelReq
on $projection.EmployeeId = _TravelReq.EmployeeId
{
    key employee_id as EmployeeId,
    employee_name as EmployeeName,
    department as Department,
    manager_id as ManagerId,
    email_id as EmailId,
    cost_center as CostCenter,
    currency_code as CurrencyCode,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    local_last_changed_at as LocalLastChangedAt,
    _TravelReq
}
