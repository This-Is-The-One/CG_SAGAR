CLASS zsgr_cl_num_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_number
     EXPORTING
      cl_number TYPE zsgr_numc_10_de.

ENDCLASS.



CLASS ZSGR_CL_NUM_GEN IMPLEMENTATION.


    METHOD get_number.

        SELECT SINGLE max( emp_id ) FROM zsgr_emp_t01
        into @DATA(lv_curr_num).

        cl_number = lv_curr_num.

    ENDMETHOD.
ENDCLASS.
