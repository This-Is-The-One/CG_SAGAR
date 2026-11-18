@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Using Managed'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
    typeName: 'Employee Info',
    typeNamePlural: 'Employees List',
    title: {
        type: #STANDARD,
        value: 'EmployeeName'
    },
    description: {
        type: #STANDARD,
        value: 'EmployeeId'
    }
}
define root view entity Z_C_EMP_01_M
  provider contract transactional_query
  as projection on Z_I_EMPLOYEE_01
{
  @UI.facet: [{
      id: 'EmployeeInfo',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'EMPLOYEES'
  }]
  @UI.lineItem: [{ position: 10, label: 'Employee ID' }]
  @UI.identification: [{ position: 10, label: 'Employee ID'  }]
  key EmployeeId,
  @UI.lineItem: [{ position: 20, label: 'Employee Name' }]
  @UI.identification: [{ position: 20, label: 'Employee Name'  }]
      EmployeeName,
  @UI.lineItem: [{ position: 30, label: 'Department' }]
  @UI.identification: [{ position: 30, label: 'Department'  }]
      Department,
  @UI.lineItem: [{ position: 40, label: 'Manager Id' }]
  @UI.identification: [{ position: 40, label: 'Manager Id'  }]
      ManagerId,
  @UI.lineItem: [{ position: 50, label: 'Email Id' }]
  @UI.identification: [{ position: 50, label: 'Email Id' }]
      EmailId,
  @UI.lineItem: [{ position: 60, label: 'Cost Center' }]
  @UI.identification: [{ position: 60, label: 'Cost Center'  }]
      CostCenter,
  @UI.lineItem: [{ position: 70, label: 'Currency Code' }]
  @UI.identification: [{ position: 70, label: 'Currency Code'  }]
      CurrencyCode,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      LocalLastChangedAt
}
