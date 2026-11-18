@EndUserText.label: 'Abstract entity to review the request'
define abstract entity Z_A_REV_REQ_01
{
  @EndUserText.label: 'Approval Status'
  Status         : abap.char(1);

  @EndUserText.label: 'Approved Amount'
  @Semantics.amount.currencyCode: 'CurrencyCode'
  ApprovedAmount : abap.curr(15,2);

  @UI.hidden: true
  CurrencyCode   : abap.cuky;

  @EndUserText.label: 'Manager Comment'
  ManagerComment : abap.char(255);
}
