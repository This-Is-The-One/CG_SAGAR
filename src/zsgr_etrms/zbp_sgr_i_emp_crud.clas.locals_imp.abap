CLASS lhc_ZSGR_I_EMP_CRUD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR zsgr_i_emp_crud RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR zsgr_i_emp_crud RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
       entities FOR CREATE zsgr_i_emp_crud.

    METHODS validateEmail FOR VALIDATE ON SAVE
       keys FOR zsgr_i_emp_crud~validateEmail.

ENDCLASS.

CLASS lhc_ZSGR_I_EMP_CRUD IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.


  METHOD validateEmail.
    DATA(lc_email_regex) = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' .

    READ ENTITIES OF zsgr_i_emp_crud IN LOCAL MODE
    ENTITY zsgr_i_emp_crud
    FIELDS ( EmailId ) WITH CORRESPONDING #( keys )
    RESULT DATA(lt_EmpData).

    LOOP AT lt_EmpData INTO DATA(ls_EmpData).
      DATA(lv_email) = condense( ls_empdata-EmailId ).

      IF matches( val = lv_email  pcre = lc_email_regex ).
        DATA(lv1) = ls_empdata-%tky.
      ELSE.
        APPEND VALUE #( %tky = ls_empdata-%tky ) TO failed-zsgr_i_emp_crud.
        APPEND VALUE #(
                        %element-EmailId = if_abap_behv=>mk-on
                        %tky = ls_empdata-%tky
                        %msg = new_message_with_text(
                            text = 'Invalid Email Format'
                            severity = if_abap_behv_message=>severity-error
                        )
                      ) TO reported-zsgr_i_emp_crud.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.




* This is not the standard way. On line 43 I have used the standard way.
* This is for my use case, since I don't have access of making the Intervals.
* This is my work around. not recommended.
  METHOD earlynumbering_create.
    DATA(lt_entities) = entities.
    DATA lv_curr_num TYPE n LENGTH 10.

    LOOP AT lt_entities INTO DATA(ls_entity).
      IF ls_entity-EmpId IS INITIAL.
        DATA(lo_gen_num) = NEW zsgr_cl_num_gen(  ).
        lo_gen_num->get_number(
          IMPORTING
            cl_number = lv_curr_num
        ).
        lv_curr_num = lv_curr_num + 1.
        APPEND VALUE #(
                        %cid = ls_entity-%cid
                        %is_draft = ls_entity-%is_draft
                        EmpId = lv_curr_num
                      ) TO mapped-zsgr_i_emp_crud.
      ELSE.
        APPEND VALUE #(
                      %cid = ls_entity-%cid
                      %is_draft = ls_entity-%is_draft
                      EmpId = ls_entity-EmpId
                     ) TO mapped-zsgr_i_emp_crud.

      ENDIF.


    ENDLOOP.
  ENDMETHOD.




*  METHOD earlynumbering_create.
*    DATA(lt_entities) = entities.
*    DELETE lt_entities WHERE EmpId IS NOT INITIAL.
*    DATA lv_currnum TYPE n LENGTH 10.
*
*    TRY.
*        cl_numberrange_runtime=>number_get(
*          EXPORTING
*            nr_range_nr       = '01'
*            object            = '/dmo/trv_m'
*            quantity          = CONV #( lines( lt_entities ) )
*          IMPORTING
*            number            = DATA(lv_lastest_num)
*            returncode        = DATA(lv_code)
*            returned_quantity = DATA(lv_qty)
*        ).
*      CATCH cx_nr_object_not_found INTO DATA(lo_error_obj).
*        LOOP AT lt_entities INTO DATA(ls_entities).
*          APPEND VALUE #( %cid = ls_entities-%cid %key = ls_entities-%key %is_draft = ls_entities-%is_draft )
*          TO failed-zsgr_i_emp_crud.
*          APPEND VALUE #( %cid = ls_entities-%cid %key = ls_entities-%key %msg = lo_error_obj %is_draft = ls_entities-%is_draft )
*          TO reported-zsgr_i_emp_crud.
*        ENDLOOP.
*        EXIT.
*
*      CATCH cx_number_ranges INTO DATA(lo_error).
*        LOOP AT lt_entities INTO ls_entities.
*          APPEND VALUE #( %cid = ls_entities-%cid %key = ls_entities-%key %is_draft = ls_entities-%is_draft )
*          TO failed-zsgr_i_emp_crud.
*          APPEND VALUE #( %cid = ls_entities-%cid %key = ls_entities-%key %msg = lo_error %is_draft = ls_entities-%is_draft )
*          TO reported-zsgr_i_emp_crud.
*        ENDLOOP.
*        EXIT.
*
*    ENDTRY.
*
*    ASSERT lv_qty = lines( lt_entities ).
*    lv_currnum = lv_lastest_num - lv_qty.
*
*    LOOP AT lt_entities INTO ls_entities.
*
*      lv_currnum = lv_currnum + 1.
*      APPEND VALUE #( %cid = ls_entities-%cid
*                      %is_draft = ls_entities-%is_draft
*                      EmpId = lv_currnum
*                    ) TO mapped-zsgr_i_emp_crud.
*
*    ENDLOOP.
*
*  ENDMETHOD.





ENDCLASS.
