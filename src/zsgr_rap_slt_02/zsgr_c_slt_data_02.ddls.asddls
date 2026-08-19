@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Root Singleton Data'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSGR_C_SLT_DATA_02 
as projection on ZSGR_I_SLT_DATA_02
{
    @UI.facet: [
        { 
            id: 'General Info',
            purpose: #STANDARD,
            type: #IDENTIFICATION_REFERENCE,
            label: 'General Information',
            position: 10
        },
        {
            id: 'DataFacet',
            purpose: #STANDARD,
            type: #LINEITEM_REFERENCE,
            label: 'SLT',
            position: 20,
            targetElement: '_Slt'
        }
    ]
//    @UI.lineItem: [{ position: 10 }]
//    @UI.identification: [{ position: 10 }]
//    @EndUserText.label: 'ConfigID'
    @UI.hidden: true
    key ConfigId,
    @UI.lineItem: [{ position: 20 }]
    @UI.identification: [{ position: 20 }]
    @EndUserText.label: 'App ID'
    key AppId,
    @UI.lineItem: [{ position: 30 }]
    @UI.identification: [{ position: 30 }]
    @EndUserText.label: 'App Name'
    AppName,
    @UI.lineItem: [{ position: 40 }]
    @UI.identification: [{ position: 40 }]
    @EndUserText.label: 'App Description'
    AppDesc,
    @UI.lineItem: [{ position: 50 }]
    @UI.identification: [{ position: 50 }]
    @EndUserText.label: 'Active'
    Active,
//    @UI.lineItem: [{ position: 60 }]
//    @UI.identification: [{ position: 60 }]
//    @EndUserText.label: 'Created At'
    @UI.hidden: true
    CreatedAt,
    @UI.lineItem: [{ position: 70 }]
    @UI.identification: [{ position: 70 }]
    @EndUserText.label: 'Last Change At'
    LastChangedAt,
//    @UI.lineItem: [{ position: 80 }]
//    @UI.identification: [{ position: 80 }]
//    @EndUserText.label: 'Last Local Update'
    @UI.hidden: true
    LocalLastChanged,
    /* Associations */
    _Slt : redirected to parent ZSGR_C_SLT_02   
}
