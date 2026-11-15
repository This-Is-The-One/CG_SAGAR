@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface for ZTB_TRV_REQ_01'
@Metadata.ignorePropagatedAnnotations: true
define root view entity Z_I_TRV_REQ_01
  as select from ztb_trv_req_01
  association to Z_I_EMPLOYEE_01 as _Employee
  on $projection.EmployeeId = _Employee.EmployeeId
{
  key travel_uuid           as TravelUuid,
  @ObjectModel.foreignKey.association: '_Employee'
      employee_id           as EmployeeId,
      destination           as Destination,
      start_date            as StartDate,
      end_date              as EndDate,
      travel_purpose        as TravelPurpose,
      transport_type        as TransportType,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      estimated_amount      as EstimatedAmount,
      @Semantics.amount.currencyCode : 'CurrencyCode'
      approved_amount       as ApprovedAmount,
      currency_code         as CurrencyCode,
      status                as Status,
      manager_comment       as ManagerComment,
      @Semantics.user.createdBy: true
      created_by            as CreatedBy,
       @Semantics.systemDateTime.createdAt: true
      created_at            as CreatedAt,
      @Semantics.user.lastChangedBy: true
      last_changed_by       as LastChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      case
        when start_date is not initial and end_date is not initial and end_date >= start_date
          then dats_days_between( start_date, end_date ) + 1
        else 0
      end                   as TravelDays,
      _Employee
      
}
