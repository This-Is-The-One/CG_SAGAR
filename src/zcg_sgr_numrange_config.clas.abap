CLASS zcg_sgr_numrange_config DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS num_rng_obj TYPE cl_numberrange_objects=>nr_attribute-object VALUE 'ZSGRNUMC10'.
    METHODS configure_numrngobj
    IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcg_sgr_numrange_config IMPLEMENTATION.
  METHOD configure_numrngobj.
    TRY.
        cl_numberrange_intervals=>create(
            EXPORTING
                interval = VALUE #( ( nrrangenr = '01' fromnumber = '2000000000' tonumber = '3000000000' procind = 'I' ) )
                object = num_rng_obj
            IMPORTING
                error     = DATA(ld_error)
                error_inf = DATA(ls_error)
                error_iv  = DATA(lt_error_iv)
                warning   = DATA(ld_warning)
        ).
    CATCH cx_root INTO DATA(lo_error).
        io_out->write( lo_error->get_text( ) ).

    ENDTRY.
    io_out->write( ld_error ).
    io_out->write( ls_error ).
    io_out->write( lt_error_iv ).
    io_out->write( ld_warning ).
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    configure_numrngobj( out ).
  ENDMETHOD.

ENDCLASS.
