@EndUserText.label: 'Travel Summary of Employee'
@ObjectModel.query.implementedBy: 'ABAP:Z_CL_TRV_SUMM'

@UI.headerInfo: {
    typeNamePlural: 'Employee Summary'
}

define custom entity Z_CE_TRV_SUMM
{
      @UI.lineItem        : [{ position: 10, label: 'Employee ID' }]
  key EmployeeId          : abap.numc(10);
      @UI.lineItem        : [{ position: 20, label: 'Employee Name' }]
      EmployeeName        : abap.char(60);
      @UI.lineItem        : [{ position: 30, label: 'Department' }]
      Department          : abap.char(40);
      @UI.lineItem        : [{ position: 40, label: 'Total Requests' }]
      TotalRequests       : abap.int4;
      @UI.lineItem        : [{ position: 50, label: 'Approved Requests' }]
      ApprovedRequests    : abap.int4;
      @UI.lineItem        : [{ position: 60, label: 'Rejected Requests' }]
      RejectedRequests    : abap.int4;

      @UI.lineItem        : [{ position: 70, label: 'Total Approved Amount' }]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalApprovedAmount : abap.curr(15,2);

      @UI.lineItem        : [{ position: 80, label: 'Currency Code' }]
      @Semantics.currencyCode: true
      CurrencyCode        : abap.cuky;

}
