@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CRUD OP Projections'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZSGR_C_EMP_CRUD
  provider contract transactional_query
  as projection on ZSGR_I_EMP_CRUD
{
      @UI.facet: [
         {
             id: 'GeneralInfo',
             purpose: #STANDARD,
             type: #IDENTIFICATION_REFERENCE,
             label: 'Employee Information',
             position: 10
         }
      ]
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
      @EndUserText.label: 'EMP ID'
  key EmpId,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
      @EndUserText.label: 'First Name'
      FirstName,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      @EndUserText.label: 'Last Name'
      LastName,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      @EndUserText.label: 'Email ID'
      EmailId,
      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 50 }]
      @EndUserText.label: 'Phone'
      PhoneNum,
      @UI.lineItem: [{ position: 60 }]
      @UI.identification: [{ position: 60 }]
      @EndUserText.label: 'DEPT ID'
      DepartmentId,
      @UI.lineItem: [{ position: 70 }]
      @UI.identification: [{ position: 70 }]
      @EndUserText.label: 'DEPT Name'
      DepartmentName,
      @UI.lineItem: [{ position: 80 }]
      @UI.identification: [{ position: 80 }]
      @EndUserText.label: 'Designation'
      Designation,
      @UI.lineItem: [{ position: 90 }]
      @UI.identification: [{ position: 90 }]
      @EndUserText.label: 'Manager ID'
      ManagerId,
      @UI.lineItem: [{ position: 100 }]
      @UI.identification: [{ position: 100 }]
      @EndUserText.label: 'Location'
      OfficeLoc,
      @UI.lineItem: [{ position: 110 }]
      @UI.identification: [{ position: 110 }]
      @EndUserText.label: 'DOJ'
      Doj
      //    CreatedBy,
      //    CreatedAt,
      //    LastChangedBy,
      //    LastChangedAt
}
