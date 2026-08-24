CLASS zsgr_cl_custom_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS gen_and_get_data
     EXPORTING
      ct_table TYPE ZSGR_TT_EMP_01.
ENDCLASS.



CLASS zsgr_cl_custom_01 IMPLEMENTATION.
    METHOD gen_and_get_data.
        DATA: lt_firstname TYPE STANDARD TABLE OF zsgr_emp_t01-first_name,
              lt_lastname TYPE STANDARD TABLE OF zsgr_emp_t01-last_name,
              ranidx1 TYPE I,
              ranidx2 TYPE I,
              ranemail Type I.

        lt_firstname = VALUE #( ( 'RAM' )
                                ( 'SHAM' )
                                ( 'BILLU' )
                                ( 'ABHISHEK' )
                                ( 'PRITI' )
                                ( 'KAVYA' ) ).
        lt_lastname = VALUE #( ( 'SINGH' )
                               ( 'SONI' )
                               ( 'YADAV' )
                               ( 'SOLANKI' )
                               ( 'CHAUDHARY' )
                               ( 'CHATURVEDI' ) ).

        DATA(lo_gen_num) = NEW zsgr_cl_num_gen(  ).
        lo_gen_num->get_number(
            IMPORTING
                cl_number = DATA(lv_empid)
        ).

        DO 1 TIMES.
        ranidx1 = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                              min = 1
                                              max = lines( lt_firstname ) )->get_next(  ).
        ranidx2 = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                              min = 1
                                              max = lines( lt_lastname ) )->get_next(  ).
        ranemail = cl_abap_random_int=>create( seed = cl_abap_random=>seed(  )
                                               min = 1000
                                               max = 9999 )->get_next(  ).

        lv_empid = lv_empid + 1.
        APPEND VALUE #( client = sy-mandt
                        emp_id = lv_empid
                        first_name = lt_firstname[ ranidx1 ]
                        last_name = lt_lastname[ ranidx2 ]
                        email_id = | { lt_firstname[ ranidx1 ] }{ ranemail }@capg.com |
                      ) TO ct_table.

        ENDDO.
    ENDMETHOD.
ENDCLASS.
