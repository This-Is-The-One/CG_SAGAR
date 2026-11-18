CLASS lcl_buffer DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA: mt_create TYPE STANDARD TABLE OF ztb_employee_01 WITH EMPTY KEY,
                mt_update TYPE STANDARD TABLE OF ztb_employee_01 WITH EMPTY KEY,
                mt_delete TYPE STANDARD TABLE OF ztb_employee_01 WITH EMPTY KEY.
ENDCLASS.

CLASS lhc_Z_I_EMPLOYEE_01 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR z_i_employee_01 RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR z_i_employee_01 RESULT result.

    METHODS create FOR MODIFY
       entities FOR CREATE z_i_employee_01.

    METHODS update FOR MODIFY
       entities FOR UPDATE z_i_employee_01.

    METHODS delete FOR MODIFY
       keys FOR DELETE z_i_employee_01.

    METHODS read FOR READ
       keys FOR READ z_i_employee_01 RESULT result.

    METHODS lock FOR LOCK
       keys FOR LOCK z_i_employee_01.

ENDCLASS.

CLASS lhc_Z_I_EMPLOYEE_01 IMPLEMENTATION.

  METHOD get_instance_authorizations.
    result = VALUE #( FOR ls_key IN keys (
      %tky    = ls_key-%tky
      %update = if_abap_behv=>auth-allowed
      %delete = if_abap_behv=>auth-allowed
    ) ).
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.
  ENDMETHOD.

  METHOD create.
    DATA ls_db TYPE ztb_employee_01.
    GET TIME STAMP FIELD DATA(lv_ts).

    LOOP AT entities INTO DATA(ls_entity).
      ls_db = VALUE #(
        employee_id           = ls_entity-EmployeeId
        employee_name         = ls_entity-EmployeeName
        department            = ls_entity-Department
        manager_id            = ls_entity-ManagerId
        email_id              = ls_entity-EmailId
        cost_center           = ls_entity-CostCenter
        currency_code         = ls_entity-CurrencyCode
        created_by            = cl_abap_context_info=>get_user_technical_name( )
        created_at            = lv_ts
        last_changed_by       = cl_abap_context_info=>get_user_technical_name( )
        last_changed_at       = lv_ts
        local_last_changed_at = lv_ts
      ).

      APPEND ls_db TO lcl_buffer=>mt_create.

      " Map %cid to the user-entered EmployeeId
      APPEND VALUE #(
        %cid       = ls_entity-%cid
        %is_draft  = ls_entity-%is_draft
        EmployeeId = ls_db-employee_id
      ) TO mapped-z_i_employee_01.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA ls_db TYPE ztb_employee_01.
    GET TIME STAMP FIELD DATA(lv_ts).

    LOOP AT entities INTO DATA(ls_entity).
      SELECT SINGLE * FROM ztb_employee_01
        WHERE employee_id = @ls_entity-EmployeeId
        INTO @ls_db.

      IF sy-subrc = 0.
        IF ls_entity-%control-EmployeeName = if_abap_behv=>mk-on.
          ls_db-employee_name = ls_entity-EmployeeName.
        ENDIF.
        IF ls_entity-%control-Department = if_abap_behv=>mk-on.
          ls_db-department = ls_entity-Department.
        ENDIF.
        IF ls_entity-%control-ManagerId = if_abap_behv=>mk-on.
          ls_db-manager_id = ls_entity-ManagerId.
        ENDIF.
        IF ls_entity-%control-EmailId = if_abap_behv=>mk-on.
          ls_db-email_id = ls_entity-EmailId.
        ENDIF.
        IF ls_entity-%control-CostCenter = if_abap_behv=>mk-on.
          ls_db-cost_center = ls_entity-CostCenter.
        ENDIF.
        IF ls_entity-%control-CurrencyCode = if_abap_behv=>mk-on.
          ls_db-currency_code = ls_entity-CurrencyCode.
        ENDIF.

        ls_db-last_changed_by       = cl_abap_context_info=>get_user_technical_name( ).
        ls_db-last_changed_at       = lv_ts.
        ls_db-local_last_changed_at = lv_ts.

        APPEND ls_db TO lcl_buffer=>mt_update.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys INTO DATA(ls_key).
      APPEND VALUE #( employee_id = ls_key-EmployeeId ) TO lcl_buffer=>mt_delete.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    CHECK keys IS NOT INITIAL.

    SELECT * FROM ztb_employee_01
      FOR ALL ENTRIES IN @keys
      WHERE employee_id = @keys-EmployeeId
      INTO TABLE @DATA(lt_db).

    result = VALUE #( FOR ls_db IN lt_db (
      EmployeeId         = ls_db-employee_id
      EmployeeName       = ls_db-employee_name
      Department         = ls_db-department
      ManagerId          = ls_db-manager_id
      EmailId            = ls_db-email_id
      CostCenter         = ls_db-cost_center
      CurrencyCode       = ls_db-currency_code
      CreatedBy          = ls_db-created_by
      CreatedAt          = ls_db-created_at
      LastChangedBy      = ls_db-last_changed_by
      LastChangedAt      = ls_db-last_changed_at
      LocalLastChangedAt = ls_db-local_last_changed_at
    ) ).
  ENDMETHOD.


  METHOD lock.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_Z_I_EMPLOYEE_01 DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_Z_I_EMPLOYEE_01 IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
    IF lcl_buffer=>mt_create IS NOT INITIAL.
      INSERT ztb_employee_01 FROM TABLE @lcl_buffer=>mt_create.
    ENDIF.

    IF lcl_buffer=>mt_update IS NOT INITIAL.
      UPDATE ztb_employee_01 FROM TABLE @lcl_buffer=>mt_update.
    ENDIF.

    IF lcl_buffer=>mt_delete IS NOT INITIAL.
      DELETE ztb_employee_01 FROM TABLE @lcl_buffer=>mt_delete.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup.
    CLEAR: lcl_buffer=>mt_create,
           lcl_buffer=>mt_update,
           lcl_buffer=>mt_delete.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
