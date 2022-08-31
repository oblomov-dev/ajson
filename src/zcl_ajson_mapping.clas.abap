class zcl_ajson_mapping definition
  public
  final
  create public.

  public section.

    constants:
      begin of rename_by,
        attr_name type i value 0,
        full_path type i value 1,
        pattern type i value 2,
        " regex type i value 3, " TODO add if needed in future
      end of rename_by.

    class-methods create_camel_case
      importing
        it_mapping_fields   type zif_ajson_mapping=>ty_mapping_fields optional
        iv_first_json_upper type abap_bool default abap_true
      returning
        value(ri_mapping)   type ref to zif_ajson_mapping.

    class-methods create_upper_case
      importing
        it_mapping_fields type zif_ajson_mapping=>ty_mapping_fields optional
      returning
        value(ri_mapping) type ref to zif_ajson_mapping.

    class-methods create_lower_case
      importing
        it_mapping_fields type zif_ajson_mapping=>ty_mapping_fields optional
      returning
        value(ri_mapping) type ref to zif_ajson_mapping.

    class-methods create_field_mapping
      importing
        it_mapping_fields type zif_ajson_mapping=>ty_mapping_fields
      returning
        value(ri_mapping) type ref to zif_ajson_mapping.

    class-methods create_rename
      importing
        it_rename_map type zif_ajson_mapping=>tty_rename_map
        iv_rename_by type i default rename_by-attr_name
      returning
        value(ri_mapping) type ref to zif_ajson_mapping.

    class-methods create_compound_mapper
      importing
        ii_mapper1 type ref to zif_ajson_mapping optional
        ii_mapper2 type ref to zif_ajson_mapping optional
        ii_mapper3 type ref to zif_ajson_mapping optional
        it_more type zif_ajson_mapping=>ty_table_of optional
      returning
        value(ri_mapping) type ref to zif_ajson_mapping.

  protected section.

  private section.

ENDCLASS.



CLASS ZCL_AJSON_MAPPING IMPLEMENTATION.


  method create_camel_case.

    create object ri_mapping type lcl_mapping_camel
      exporting
        it_mapping_fields   = it_mapping_fields
        iv_first_json_upper = iv_first_json_upper.

  endmethod.


  method create_field_mapping.

    create object ri_mapping type lcl_mapping_fields
      exporting
        it_mapping_fields = it_mapping_fields.

  endmethod.


  method create_lower_case.

    create object ri_mapping type lcl_mapping_to_lower
      exporting
        it_mapping_fields = it_mapping_fields.

  endmethod.

  method create_compound_mapper.

    data lt_queue type zif_ajson_mapping=>ty_table_of.

    append ii_mapper1 to lt_queue.
    append ii_mapper2 to lt_queue.
    append ii_mapper3 to lt_queue.
    append lines of it_more to lt_queue.
    delete lt_queue where table_line is initial.

    create object ri_mapping type lcl_compound_mapper
      exporting
        it_queue = lt_queue.

  endmethod.

  method create_upper_case.

    create object ri_mapping type lcl_mapping_to_upper
      exporting
        it_mapping_fields = it_mapping_fields.

  endmethod.

  method create_rename.

    create object ri_mapping type lcl_rename
      exporting
        it_rename_map = it_rename_map
        iv_rename_by = iv_rename_by.

  endmethod.

ENDCLASS.
