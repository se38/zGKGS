"! <p class="shorttext synchronized" lang="en">Google Knowledge Graph Search API</p>
CLASS zcl_gkgs_api DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

**********************************************************************
* see https://developers.google.com/knowledge-graph/
**********************************************************************

  PUBLIC SECTION.
    TYPES tt_results TYPE STANDARD TABLE OF REF TO zcl_gkgs_entity_search_result WITH EMPTY KEY.

    METHODS:
      "! Constructor of the Knowledge Graph API
      "!
      "! @parameter i_api_key   | Insert your own API key (see https://developers.google.com/knowledge-graph/prereqs)
      constructor
        IMPORTING i_api_key TYPE string,
      "! Searches Knowledge Graph for entities that match the constraints.
      "!
      "! @parameter i_query     | A literal string to search for in the Knowledge Graph.
      "! @parameter i_ids       | A list of entity IDs to search for in the Knowledge Graph.
      "! @parameter i_languages | The list of language codes (defined in ISO 639) to run the query with, for instance en.
      "! @parameter i_types     | Restricts returned entities to those of the specified types. For example, you can specify Person (as defined in http://schema.org/Person) to restrict the results to entities representing people.
      "! @parameter i_prefix    | Enables prefix (initial substring) match against names and aliases of entities. For example, a prefix Jung will match entities and aliases such as Jung, Jungle, and Jung-ho Kang.
      "! @parameter i_limit     | Limits the number of entities to be returned.
      search
        IMPORTING i_query     TYPE string
                  i_ids       TYPE string OPTIONAL
                  i_languages TYPE string OPTIONAL
                  i_types     TYPE string OPTIONAL
                  i_prefix    TYPE string OPTIONAL
                  i_limit     TYPE i      DEFAULT 10
        EXPORTING e_results   TYPE tt_results.

  PROTECTED SECTION.
  PRIVATE SECTION.
    CONSTANTS google_host_name TYPE string VALUE 'kgsearch.googleapis.com'.
    DATA api_key TYPE string.

    METHODS:
      "! Parse JSON to objects
      "!
      "! @parameter i_result  | JSON (Return from Google search)
      "! @parameter e_results | Result objects
      parse_result
        IMPORTING i_result  TYPE string
        EXPORTING e_results TYPE tt_results.
ENDCLASS.



CLASS zcl_gkgs_api IMPLEMENTATION.


  METHOD constructor.
    api_key = i_api_key.
  ENDMETHOD.


  METHOD parse_result.

    DATA(result_doc) = zcl_json_document=>create_with_json( i_result ).
    CHECK result_doc->get_value( 'error' ) IS INITIAL.

    DATA(item_list_elements) = zcl_json_document=>create_with_json( result_doc->get_value( 'itemlistelement' ) ).

    WHILE item_list_elements->get_next( ) IS NOT INITIAL.

      DATA(item_list_element_json) = item_list_elements->get_json( ).
      DATA(item_list_element_doc) = zcl_json_document=>create_with_json( item_list_element_json ).

      CHECK item_list_element_doc->get_value( '@type' ) = 'EntitySearchResult'.

      DATA(search_result) = NEW zcl_gkgs_entity_search_result( item_list_element_json ).
      IF search_result IS BOUND.
        INSERT search_result INTO TABLE e_results.
      ENDIF.

    ENDWHILE.

  ENDMETHOD.


  METHOD search.

    cl_http_client=>create(
      EXPORTING
        host               = google_host_name     " logische Destination (Wird bei Funktionsaufruf angegeben)
        scheme             = cl_http_client=>schemetype_https    " HTTP/HTTPS
      IMPORTING
        client             = DATA(client)    " HTTP Client Abstraction
      EXCEPTIONS
        argument_not_found = 1
        plugin_not_active  = 2
        internal_error     = 3
        OTHERS             = 4
    ).

    IF sy-subrc <> 0.
      WRITE:/ 'WTF'.
      RETURN.
    ENDIF.

    DATA(uri) = |/v1/entities:search| &&
                |?query={ cl_http_utility=>escape_url( i_query ) }| &&
                |&key={ api_key }| &&
                |&limit={ i_limit }|.

    IF i_types IS NOT INITIAL.
      uri = |{ uri }&types={ cl_http_utility=>escape_url( i_types ) }|.
    ENDIF.

    client->request->set_header_field(
      name = '~request_uri'
      value = uri
      ).

    client->request->set_header_field(
      name  = '~request_method'
      value = 'GET'
      ).

    client->send( EXCEPTIONS http_communication_failure = 8 ).
    IF sy-subrc <> 0.
      WRITE:/ 'WTF'.
      RETURN.
    ENDIF.

    client->receive( EXCEPTIONS http_communication_failure = 8 ).
    IF sy-subrc <> 0.
      client->get_last_error(
        IMPORTING
*          code           =     " Rückgabewert, Rückgabewert nach ABAP-Anweisungen
          message        = DATA(message)    " Fehlermeldung
*          message_class  =     " Arbeitsgebiet
*          message_number =     " Nachrichtennummer
      ).
      cl_demo_output=>display( message ).
      RETURN.
    ENDIF.

    DATA(result) = client->response->get_cdata( ).

    me->parse_result(
      EXPORTING
        i_result  = result
      IMPORTING
        e_results = e_results
    ).

  ENDMETHOD.
ENDCLASS.