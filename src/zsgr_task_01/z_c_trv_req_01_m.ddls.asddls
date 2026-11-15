@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Using Managed'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
    typeName: 'Travel Request',
    typeNamePlural: 'Travel Requests',
    title: {
        type: #STANDARD,
        value: 'EmployeeId'
    },
    description: {
        type: #STANDARD,
        value: 'TravelPurpose'
    }
}

define root view entity Z_C_TRV_REQ_01_M
  provider contract transactional_query
  as projection on Z_I_TRV_REQ_01
{
      @UI.facet: [{
          id: 'TRRQ',
          purpose: #STANDARD,
          type: #IDENTIFICATION_REFERENCE,
          label: 'Request Info'
      }]

      @UI.lineItem: [{ position: 10, label: 'Travel ID' }]
      @UI.identification: [{ position: 10, label: 'Travel ID'}]
  key TravelUuid,
      @UI.lineItem: [{ position: 110, label: 'Status' }]
      @UI.identification: [{ position: 11, label: 'Status'}]
      Status,
      @UI.lineItem: [{ position: 20, label: 'EMP ID' }]
      @UI.identification: [{ position: 20, label: 'EMP ID'}]
      EmployeeId,
      @UI.lineItem: [{ position: 23, label: 'Travel Purpose' }]
      @UI.identification: [{ position: 23, label: 'Travel Purpose'}]
      TravelPurpose,
      @UI.lineItem: [{ position: 27, label: 'Transport Type' }]
      @UI.identification: [{ position: 27, label: 'Transport Type'}]
      TransportType,
      @UI.lineItem: [{ position: 30, label: 'Destination' }]
      @UI.identification: [{ position: 30, label: 'Destination'}]
      Destination,
      @UI.lineItem: [{ position: 40, label: 'Travel Day' }]
      TravelDays,
      @UI.identification: [{ position: 40, label: 'Start'}]
      StartDate,
      @UI.identification: [{ position: 50, label: 'End'}]
      EndDate,
      @UI.lineItem: [{ position: 80, label: 'Estimated Amount' }]
      @UI.identification: [{ position: 80, label: 'Estimated Amount'}]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      EstimatedAmount,
      @UI.hidden: true
      CurrencyCode,
      @UI.lineItem: [{ position: 90, label: 'Approved Amount' }]
      @Semantics.amount.currencyCode: 'CurrencyCode'
      ApprovedAmount,
      @UI.lineItem: [{ position: 120, label: 'Manager Comments' }]
      @UI.identification: [{ position: 120, label: 'Manager Comments'}]
      ManagerComment
      
//      @UI.hidden: true
//      @Semantics.user.createdBy: true
//      CreatedBy,
//      @UI.hidden: true
//      @Semantics.systemDateTime.createdAt: true
//      CreatedAt,
//      @UI.hidden: true
//      @Semantics.user.lastChangedBy: true
//      LastChangedBy,
//      @UI.hidden: true
//      @Semantics.systemDateTime.lastChangedAt: true
//      LastChangedAt,
//      @UI.hidden: true
//      @Semantics.systemDateTime.localInstanceLastChangedAt: true
//      LocalLastChangedAt      
}
//{
//    key TravelUuid,
//    EmployeeId,
//    Destination,
//    StartDate,
//    EndDate,
//    TravelPurpose,
//    TransportType,
//    @Semantics.amount.currencyCode: 'CurrencyCode'
//    EstimatedAmount,
//    @Semantics.amount.currencyCode: 'CurrencyCode'
//    ApprovedAmount,
//    CurrencyCode,
//    Status,
//    ManagerComment,
//    @UI.hidden: true
//    CreatedBy,
//    @UI.hidden: true
//    CreatedAt,
//    @UI.hidden: true
//    LastChangedBy,
//    @UI.hidden: true
//    LastChangedAt,
//    @UI.hidden: true
//    LocalLastChangedAt,
//    /* Associations */
//    _Employee
//}
