@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection for Root Singleton'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZSGR_C_SLT_02
  provider contract transactional_query 
as projection on ZSGR_I_SLT_02
{   @UI.facet: [
        { 
            id: 'GeneralInfo',
            purpose: #STANDARD,
            type: #IDENTIFICATION_REFERENCE,
            label: 'General Information',
            position: 10
        },
        {
            id: 'DataFacet',
            purpose: #STANDARD,
            type: #LINEITEM_REFERENCE,
            label: 'Records',
            position: 20,
            targetElement: '_Data'
        }
    ]
    @UI.lineItem: [{ position: 10 }]
    @UI.identification: [{ position: 10 }]
    @EndUserText.label: 'Singleton'
    key singleton_id,
    @UI.lineItem: [{ position: 20 }]
    @UI.identification: [{ position: 20 }]
    @EndUserText.label: 'Last Updated'
    LastChangedAt_SLT,

    _Data : redirected to composition child ZSGR_C_SLT_DATA_02
}
