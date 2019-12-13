import lldb
from dylan.accessors import *
import dylan.mangling as mangling

def dylan_value_summary(value, internal_dict):
  tag = dylan_tag_bits(value)
  if tag == OBJECT_TAG:
    return dylan_object_summary(value, internal_dict)
  elif tag == INTEGER_TAG:
    return dylan_integer_summary(value, internal_dict)
  elif tag == BYTE_CHARACTER_TAG:
    return dylan_byte_character_summary(value, internal_dict)
  elif tag == UNICODE_CHARACTER_TAG:
    return dylan_unicode_character_summary(value, internal_dict)
  else:
    return 'Invalid tag'

def summary(value):
  wrapper_symbol_name = dylan_object_wrapper_symbol_name(value)
  if not wrapper_symbol_name:
    return ''
  summary_func = SUMMARY_DISPATCH_TABLE.get(wrapper_symbol_name, None)
  if summary_func:
    return summary_func(value, {})
  else:
    return ''

def dylan_object_summary(value, internal_dict):
  # In case we're looking at an object on the stack and not a
  # pointer to it.
  if not value.GetType().IsPointerType():
    value = value.address_of
  wrapper_symbol_name = dylan_object_wrapper_symbol_name(value)
  if not wrapper_symbol_name:
    # We have no valid wrapper symbol, so just find the symbol
    # for the address and use that. This is probably not actually
    # a dylan_value.
    target = lldb.debugger.GetSelectedTarget()
    address = lldb.SBAddress(value.GetValueAsUnsigned(), target)
    return address.symbol.name
  summary_func = SUMMARY_DISPATCH_TABLE.get(wrapper_symbol_name, None)
  if summary_func:
    # Look this up now so that we know we're probably valid given that
    # we have a summary func. If not, we wrap it in try/except below
    # to catch possible errors.
    class_name = dylan_object_class_name(value)
    summary = summary_func(value, internal_dict)
    if summary is not None:
      return '{%s: %s}' % (class_name, summary)
    else:
      return '{%s}' % (class_name,)
  else:
    try:
      return '{%s}' % (dylan_object_class_name(value),)
    except:
      return '{uninitialized}'

def dylan_byte_character_summary(value, internal_dict):
  byte_character = dylan_byte_character_value(value)
  if byte_character.isprintable():
    return '{<byte-character>: %s (0x%x)}' % (byte_character, ord(byte_character))
  else:
    return '{<byte-character>: (0x%x)}' % (ord(byte_character),)

def dylan_integer_summary(value, internal_dict):
  return '{<integer>: %s}' % (dylan_integer_value(value),)

def dylan_unicode_character_summary(value, internal_dict):
  try:
    unicode_character = dylan_unicode_character_value(value)
    if unicode_character.isprintable():
      return '{<unicode-character>: %s (0x%x)}' % (unicode_character, ord(unicode_character))
    else:
      return '{<unicode-character>: (0x%x)}' % (ord(unicode_character), )
  except ValueError:
    return '{<unicode-character> (invalid)}'

def register(binding, module, library):
  def _register(function):
    wrapper = mangling.dylan_mangle_wrapper(binding, module, library)
    SUMMARY_DISPATCH_TABLE[wrapper] = function
    return function
  return _register

SUMMARY_DISPATCH_TABLE = {
}
