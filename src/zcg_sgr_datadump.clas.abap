CLASS zcg_sgr_datadump DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS delete_record.
*    METHODS update_record.
ENDCLASS.



CLASS ZCG_SGR_DATADUMP IMPLEMENTATION.


  METHOD delete_record.
    DELETE FROM zsgr_stl_demo_02
    WHERE active = @abap_false.
    IF sy-subrc = 0.
      COMMIT WORK.
    ENDIF.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

*    DATA lv_timestamp TYPE timestampl.
*    GET TIME STAMP FIELD lv_timestamp.

*    DATA lt_data TYPE TABLE OF zsgr_count_tb01.
*    lt_data = VALUE #(
*        ( id = 1 counter = '1000000000' )
*    ).
*
*    INSERT zsgr_count_tb01 FROM TABLE @lt_data.
*    out->write( | Inserted { lines( lt_data ) } records | ).
*    delete_record( ).
*    out->write( 'Record deleted successfully' ).


*        UPDATE zsgr_emp_t01
*        SET emp_id = '1000000001'.

     data(lo_temp) = new zsgr_cl_custom_01( ).
     lo_temp->gen_and_get_data(
       IMPORTING
         ct_table = data(lt_table)
     ).
     LOOP AT lt_table INTO DATA(wa_table).
        Out->write( | { wa_table-client } { wa_table-emp_id } { wa_table-first_name } { wa_table-last_name } { wa_table-email_id } | ).
     ENDLOOP.

     out->write( 'success' ).

  ENDMETHOD.
ENDCLASS.
