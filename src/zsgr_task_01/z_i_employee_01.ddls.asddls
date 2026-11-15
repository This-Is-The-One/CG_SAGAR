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
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt,
    _TravelReq
}
