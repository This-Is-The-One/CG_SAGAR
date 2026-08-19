@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CRUD OP Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSGR_I_EMP_CRUD
as select from zsgr_emp_t01
{
    key emp_id as EmpId,
    first_name as FirstName,
    last_name as LastName,
    email_id as EmailId,
    phone_num as PhoneNum,
    department_id as DepartmentId,
    department_name as DepartmentName,
    designation as Designation,
    manager_id as ManagerId,
    office_loc as OfficeLoc,
    doj as Doj,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt
}
