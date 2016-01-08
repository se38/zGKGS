*&---------------------------------------------------------------------*
*& Report z_gkgs_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
*& zGKGS
*& The Google Knowledge Graph Search API
*& Copyright (C) 2016 Uwe Fetzer together with the SCN ABAP community
*&
*& Project home: https://github.com/se38/SchemA
*&
*& Published under Apache License, Version 2.0
*& http://www.apache.org/licenses/LICENSE-2.0.html
*&---------------------------------------------------------------------*
REPORT z_gkgs_demo.

DATA(google_knowledge_graph_search) = NEW zcl_gkgs_api( i_api_key = 'AIzaSyAi8fPh6vnkNwmMuDXdy1Ma86aRbWi1pL8' ).

google_knowledge_graph_search->search(
  EXPORTING
    i_query     = 'sap'
    i_limit     = 5
  IMPORTING
    e_results   = DATA(results)
).

LOOP AT results ASSIGNING FIELD-SYMBOL(<result>).

  cl_demo_output=>begin_section( title = <result>->get_result( )->get_description( ) ).

  IF <result>->get_result( )->get_image( ) IS BOUND.
    cl_demo_output=>write_html( html = |<image src="{ <result>->get_result( )->get_image( )->get_content_url( ) }"/>| ).
  ENDIF.

  cl_demo_output=>write_text( <result>->get_result( )->get_detailed_description( )->get_article_body( ) ).
  cl_demo_output=>end_section( ).

ENDLOOP.

cl_demo_output=>display( ).

**********************************************************************
* Google Knowledge Graph search response:
*
*{
*  "@context": {
*    "@vocab": "http://schema.org/",
*    "goog": "http://schema.googleapis.com/",
*    "EntitySearchResult": "goog:EntitySearchResult",
*    "detailedDescription": "goog:detailedDescription",
*    "resultScore": "goog:resultScore",
*    "kg": "http://g.co/kg"
*  },
*  "@type": "ItemList",
*  "itemListElement": [
*    {
*      "@type": "EntitySearchResult",
*      "result": {
*        "@id": "kg:/m/01pf4l",
*        "name": "SAP SE",
*        "@type": [
*          "Corporation",
*          "Thing",
*          "Organization"
*        ],
*        "description": "Software company",
*        "image": {
*          "contentUrl": "http://t0.gstatic.com/images?q=tbn:ANd9GcTqrobfWZcF-HjYvRb0_Kt5vP5sGcMJpd-5XUiXe8-0G07wm2qR",
*          "url": "https://commons.wikimedia.org/wiki/File:SAP_2011_logo.svg"
*        },
*        "detailedDescription": {
*          "articleBody": "SAP SE is a German multinational software corporation that makes enterprise software to manage business operations and
*                          customer relations. SAP is headquartered in Walldorf, Baden-Württemberg, Germany, with regional offices in 130 countries. The company has
*                          over 293,500 customers in 190 countries. The company is a component of the Euro Stoxx 50 stock market index.",
*          "url": "http://en.wikipedia.org/wiki/SAP_SE",
*          "license": "https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"
*        }
*      },
*      "resultScore": 97.224617
*    },
*    {
*      "@type": "EntitySearchResult",
*      "result": {
*        "@id": "kg:/m/01q895",
*        "name": "Tonlé Sap",
*        "@type": [
*          "BodyOfWater",
*          "TouristAttraction",
*          "Place",
*          "LakeBodyOfWater",
*          "Thing"
*        ],
*        "description": "Lake in Cambodia",
*        "image": {
*          "contentUrl": "http://t2.gstatic.com/images?q=tbn:ANd9GcShWlrow3F_bPQeq0T3EEyH7FwSwbEVhYRScpok7jZ9UpAA81w3",
*          "url": "https://en.wikipedia.org/wiki/Tonl%C3%A9_Sap_Biosphere_Reserve",
*          "license": "http://www.gnu.org/copyleft/fdl.html"
*        },
*        "detailedDescription": {
*          "articleBody": "Tonlé Sap refers to a seasonally inundated freshwater lake, the Tonlé Sap Lake and an attached river, the 120 km long Tonlé Sap River, that connects the lake to the Mekong. ",
*          "url": "http://en.wikipedia.org/wiki/Tonl%C3%A9_Sap",
*          "license": "https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"
*        }
*      },
*      "resultScore": 39.483871
*    },
*    {
*      "@type": "EntitySearchResult",
*      "result": {
*        "@id": "kg:/m/030mq7",
*        "name": "SAP Center",
*        "@type": [
*          "StadiumOrArena",
*          "CivicStructure",
*          "Place",
*          "Thing",
*          "TouristAttraction"
*        ],
*        "description": "Arena in San Jose, California",
*        "image": {
*          "contentUrl": "http://t3.gstatic.com/images?q=tbn:ANd9GcS63ZzL8YKkyeNL_qvgj878Vzr9AS1Aqq63xiZJGdtdGjmF_O9D",
*          "url": "https://en.wikipedia.org/wiki/File:HP_Pavilion_(angle).jpg",
*          "license": "http://www.gnu.org/copyleft/fdl.html"
*        },
*        "detailedDescription": {
*          "articleBody": "SAP Center at San Jose is an indoor arena located in San Jose, California. Its primary tenant is the San Jose Sharks of the National Hockey League, for which the arena has earned the nickname \"The Shark Tank\". ",
*          "url": "http://en.wikipedia.org/wiki/SAP_Center",
*          "license": "https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"
*        },
*        "url": "http://www.hppavilion.com/index2.html"
*      },
*      "resultScore": 32.231056
*    },
*    {
*      "@type": "EntitySearchResult",
*      "result": {
*        "@id": "kg:/m/01c6q7",
*        "name": "Sybase",
*        "@type": [
*          "Organization",
*          "Thing",
*          "Corporation"
*        ],
*        "description": "Software company",
*        "image": {
*          "contentUrl": "http://t2.gstatic.com/images?q=tbn:ANd9GcSvAK5xa_F-SFEIahSXVMP0_gxe3TZft_cQzGhSUY8N7KWIn5Lz",
*          "url": "https://commons.wikimedia.org/wiki/File:Sybase-SAP_FINAL_logo.png",
*          "license": "http://creativecommons.org/licenses/by-sa/3.0"
*        },
*        "detailedDescription": {
*          "articleBody": "Sybase is an enterprise software and services company that produces software to manage and analyze information in relational databases. Sybase is a standalone subsidiary of SAP.",
*          "url": "http://en.wikipedia.org/wiki/Sybase",
*          "license": "https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"
*        }
*      },
*      "resultScore": 29.479715
*    },
*    {
*      "@type": "EntitySearchResult",
*      "result": {
*        "@id": "kg:/m/07dq6k",
*        "name": "SAP Arena",
*        "@type": [
*          "StadiumOrArena",
*          "Place",
*          "Thing",
*          "TouristAttraction",
*          "CivicStructure"
*        ],
*        "description": "Arena in Mannheim, Germany",
*        "image": {
*          "contentUrl": "http://t2.gstatic.com/images?q=tbn:ANd9GcSUl5pzPVvu9DULVsaYJNsRNw5c7WfzRzGcZfqvR_ppjqwwRzbp",
*          "url": "https://commons.wikimedia.org/wiki/File:SAP-Arena-Handball.jpg",
*          "license": "http://www.gnu.org/copyleft/fdl.html"
*        },
*        "detailedDescription": {
*          "articleBody": "SAP Arena is a multi-purpose arena in Mannheim, Germany. It is primarily used for ice hockey and handball, and is the home arena of the Adler Mannheim ice hockey club and the Rhein-Neckar Löwen handball club. ",
*          "url": "http://en.wikipedia.org/wiki/SAP_Arena",
*          "license": "https://en.wikipedia.org/wiki/Wikipedia:Text_of_Creative_Commons_Attribution-ShareAlike_3.0_Unported_License"
*        },
*        "url": "http://www.saparena.de/"
*      },
*      "resultScore": 28.427057
*    }
*  ]
*}