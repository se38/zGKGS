"! <p class="shorttext synchronized" lang="en">Google KGS: A result returned by searching for an entity</p>
CLASS zcl_gkgs_entity_search_result DEFINITION
  PUBLIC
  INHERITING FROM zcl_schema_intangible
  CREATE PUBLIC
  GLOBAL FRIENDS zcl_schema_thing..

  PUBLIC SECTION.
    METHODS:
      constructor IMPORTING i_json TYPE string OPTIONAL,
      get_result RETURNING VALUE(r_result) TYPE REF TO zcl_schema_thing,
      get_result_score RETURNING VALUE(r_result) TYPE f,
      set_result_score IMPORTING i_result_score TYPE string.

  PROTECTED SECTION.
    METHODS:
      "*--- append attributes of this and all super classes as JSON ---*
      append_attributes REDEFINITION.

  PRIVATE SECTION.
    CLASS-DATA:
      type TYPE string VALUE 'EntitySearchResult'.

    DATA:
      "! The search result
      result               TYPE REF TO zcl_schema_thing,
      "! Results with higher resultScores are considered better matches.
      result_score         TYPE f.
ENDCLASS.



CLASS ZCL_GKGS_ENTITY_SEARCH_RESULT IMPLEMENTATION.


  METHOD append_attributes.
    INCLUDE z_schema_attributes_super.
  ENDMETHOD.


  METHOD constructor.
    INCLUDE z_schema_constructor_super.

    DATA(result_json) = json_doc->get_value( 'result' ).
    me->result = zcl_schema_main=>create( result_json ).
  ENDMETHOD.


  METHOD get_result.
    r_result = me->result.
  ENDMETHOD.


  METHOD get_result_score.
    r_result = me->result_score.
  ENDMETHOD.


  METHOD set_result_score.
    me->result_score = i_result_score.
  ENDMETHOD.
ENDCLASS.