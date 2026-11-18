CLASS z_cl_trv_summ DEFINITION
  PUBLIC FINAL CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
ENDCLASS.



CLASS z_cl_trv_summ IMPLEMENTATION.
    METHOD if_rap_query_provider~select.

    DATA lt_result TYPE TABLE OF z_ce_trv_summ.

    IF io_request->is_data_requested( ).

      DATA(lv_top)  = io_request->get_paging( )->get_page_size( ).
      DATA(lv_skip) = io_request->get_paging( )->get_offset( ).
      IF lv_top < 0.
        lv_top = 50.
      ENDIF.

      SELECT FROM z_i_trv_req_01 AS travel
        INNER JOIN z_i_employee_01 AS employee
          ON employee~EmployeeId = travel~EmployeeId
        FIELDS
          travel~EmployeeId                         AS employeeid,
          employee~EmployeeName                     AS employeename,
          employee~Department                       AS department,
          COUNT( * )                                AS totalrequests,
          SUM( CASE travel~Status
                 WHEN 'A' THEN 1 ELSE 0 END )       AS approvedrequests,
          SUM( CASE travel~Status
                 WHEN 'R' THEN 1 ELSE 0 END )       AS rejectedrequests,
          SUM( travel~ApprovedAmount )              AS totalapprovedamount,
          travel~CurrencyCode                       AS currencycode
        GROUP BY
          travel~EmployeeId,
          employee~EmployeeName,
          employee~Department,
          travel~CurrencyCode
        ORDER BY travel~EmployeeId
        INTO CORRESPONDING FIELDS OF TABLE @lt_result
        OFFSET @lv_skip
        UP TO @lv_top ROWS.

      " <-- THIS LINE WAS MISSING:
      io_response->set_data( lt_result ).

    ENDIF.

    IF io_request->is_total_numb_of_rec_requested( ).
      io_response->set_total_number_of_records( lines( lt_result ) ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
