from dylan.accessors import *
from dylan import summaries

@summaries.register('<llvm-argument>', 'llvm', 'llvm')
def llvm_argument_summary(value, internal_dict):
  argument_type = dylan_slot_element_by_name(value, 'llvm-value-type')
  argument_name_value = dylan_slot_element_by_name(value, 'llvm-argument-name')
  argument_name = ''
  # argument_name_value is false-or(<string>)
  if not dylan_is_false(argument_name_value):
    argument_name = ' ' + dylan_string(argument_name_value)
  return '%s%s' % (summaries.summary(argument_type), argument_name)
