; extends

(element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_yaml)))
  (text) @injection.content
  (#eq? @_lang "lang")
  (#any-of? @_yaml "yaml" "yml")
  (#set! injection.language "yaml"))

(element
  (start_tag
    (attribute
      (attribute_name) @_lang
      (quoted_attribute_value
        (attribute_value) @_json)))
  (text) @injection.content
  (#eq? @_lang "lang")
  (#any-of? @_json "json")
  (#set! injection.language "json"))

