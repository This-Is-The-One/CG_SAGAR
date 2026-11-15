@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Using Managed'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_C_EMP_01_M
  provider contract transactional_query
  as projection on Z_I_EMPLOYEE_01
{
  key EmployeeId,
      EmployeeName,
      Department,
      ManagerId,
      EmailId,
      CostCenter,
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt,
      /* Associations */
      _TravelReq
}
