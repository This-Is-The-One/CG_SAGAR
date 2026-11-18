CLASS lhc_Z_I_TRV_REQ_01 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR TravelRequest RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR TravelRequest RESULT result.
    METHODS setdefaultcurrency FOR DETERMINE ON MODIFY
       keys FOR TravelRequest~setdefaultcurrency.
    METHODS setStatusDraft FOR DETERMINE ON MODIFY
       keys FOR TravelRequest~setStatusDraft.

    METHODS setStatusSubmitted FOR DETERMINE ON SAVE
       keys FOR TravelRequest~setStatusSubmitted.
    METHODS reviewRequest FOR MODIFY
       keys FOR ACTION TravelRequest~reviewRequest RESULT result.

ENDCLASS.

CLASS lhc_Z_I_TRV_REQ_01 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setDefaultCurrency.

    READ ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        FIELDS ( CurrencyCode )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    DELETE lt_requests WHERE CurrencyCode IS NOT INITIAL.
    CHECK lt_requests IS NOT INITIAL.

    MODIFY ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        UPDATE FIELDS ( CurrencyCode )
        WITH VALUE #( FOR ls_req IN lt_requests (
                        %tky         = ls_req-%tky
                        CurrencyCode = 'INR'
                      ) ).
  ENDMETHOD.

  METHOD setStatusDraft.
    " Read newly created instances
    READ ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        FIELDS ( Status ManagerComment )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    " Only update if Status is still empty
    DELETE lt_requests WHERE Status IS NOT INITIAL.
    CHECK lt_requests IS NOT INITIAL.

    " Set initial Status to Draft and default ManagerComment
    MODIFY ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        UPDATE FIELDS ( Status ManagerComment )
        WITH VALUE #( FOR ls_req IN lt_requests (
                        %tky           = ls_req-%tky
                        Status         = 'D'
                        ManagerComment = 'Submit the Request First'
                      ) ).
  ENDMETHOD.

  METHOD setStatusSubmitted.
    READ ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        FIELDS ( Status ManagerComment )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_requests).

    " Update only records transitioning from Draft (or initial) to Submitted
    DELETE lt_requests WHERE Status <> 'D' AND Status IS NOT INITIAL.
    CHECK lt_requests IS NOT INITIAL.

    " Update Status to Submitted and ManagerComment to Under Review
    MODIFY ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        UPDATE FIELDS ( Status ManagerComment )
        WITH VALUE #( FOR ls_req IN lt_requests (
                        %tky           = ls_req-%tky
                        Status         = 'S'
                        ManagerComment = 'Under Review'
                      ) ).
  ENDMETHOD.

  METHOD reviewRequest.
    MODIFY ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
        ENTITY TravelRequest
          UPDATE FIELDS ( Status ApprovedAmount ManagerComment )
          WITH VALUE #( FOR ls_key IN keys (
                          %tky           = ls_key-%tky
                          Status         = ls_key-%param-Status
                          ApprovedAmount = ls_key-%param-ApprovedAmount
                          ManagerComment = ls_key-%param-ManagerComment
                        ) ).

    " Read back the updated instance to return $self to Fiori Elements
    READ ENTITIES OF z_i_trv_req_01 IN LOCAL MODE
      ENTITY TravelRequest
        ALL FIELDS
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_updated).

    result = VALUE #( FOR ls_req IN lt_updated (
                        %tky   = ls_req-%tky
                        %param = ls_req
                      ) ).
  ENDMETHOD.

ENDCLASS.
