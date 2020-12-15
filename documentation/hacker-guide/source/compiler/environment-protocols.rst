*********************
Environment Protocols
*********************

This is the interface used to communicate with the back-end compiler or IDE.

.. library:: environment-protocols

The Dylan compiler and integrated development environment maintain
a model of the program under development, with objects representing
libraries, modules, methods and so on. It also includes run time entities,
such as registers and breakpoints in the debugger.

This library represents the interface to that model.

.. module:: environment-protocols

This is only module in the library, and exports many symbols. They
are classified according to the sub-sections below.

- :ref:`Server Objects`
- :ref:`IDs`
- :ref:`Environment Objects`
- :ref:`Application Objects`
- :ref:`Unbound Objects`
- :ref:`Address Objects`
- :ref:`Register Objects`
- :ref:`Component Objects`
- :ref:`Application and Compiler Objects`
- :ref:`Composite Objects`
- :ref:`User Objects`
- :ref:`User Class Info`
- :ref:`Internal Objects`
- :ref:`Foreign Objects`
- :ref:`Dylan Objects`
- :ref:`Dylan Expression Objects`
- :ref:`Dylan Application Objects`
- :ref:`Boolean Objects`
- :ref:`Collection Objects`
- :ref:`Source Forms`
- :ref:`Macro Calls`
- :ref:`Non-Definition Source Forms`  
- :ref:`Definition Objects`
- :ref:`Compiler Databases`
- :ref:`Project Objects`

Server Objects
^^^^^^^^^^^^^^
The 'server' is the top-level object which is used to resolve all others.
It is an abstract class; concrete sub-classes provide the actual behavior.

- :class:`<server>`
- :class:`<closed-server-error>`
- :class:`<invalid-object-error>`
- :gf:`condition-project`
- :gf:`condition-object`
- :gf:`record-client-query`
- :gf:`server-project`

.. class:: <server>
   :abstract:

   :superclasses: :drm:`<object>`


.. class:: <closed-server-error>
   :sealed:

   :superclasses: :class:`<simple-error>`

.. class:: <invalid-object-error>
   :sealed:

   :superclasses: :class:`<simple-error>`

   :keyword project: an instance of :class:`<project-object>`. Required.
   :keyword object: an instance of :class:`<environment-object>`. Required.

.. type:: <query-type>

   :equivalent: :drm:`<symbol>`

.. generic-function:: record-client-query
   :open:

   :signature: *server*, *client*, *object*, *type*  => ();
   :parameter server: an instance of :class:`<server>`
   :parameter client: an instance of :drm:`<object>`
   :parameter object: an instance of :drm:`<object>`
   :parameter type:  an instance of :type:`<query-type>`

.. generic-function:: server-project
   :open:

   :signature: *server* => *project*
   :parameter server: an instance of :class:`<server>`
   :returns project: an instance of :class:`<project-object>`

IDs
^^^

- :class:`<id>`
- :class:`<library-id>`
- :class:`<module-id>`
- :class:`<definition-id>`
- :class:`<method-id>`
- :class:`<object-location-id>`
- :class:`<library-object-location-id>`

.. class:: <id>
   :abstract:

   :superclasses: :drm:`<object>`

   :description:

      An identifier for an environment object. See the concrete subclasses of this class.

.. class:: <unique-id>
   :sealed:
   :abstract:

   This class is not exported by the module.

   :superclass: :class:`<id>`

   :keyword name:  an instance of :drm:`<string>`

   :slot id-name: an instance of :drm:`<string>`

.. class:: <named-id>
   :sealed:
   :abstract:

   This class is not exported by the module.

   :superclass: :class:`<unique-id>`

   :keyword name:  an instance of :drm:`<string>`. Required.

   :slot id-name: an instance of :drm:`<string>`


.. class:: <library-id>

   :superclasses: :class:`<named-id>`

   :keyword name: an instance of :drm:`<string>`. Required.

   :description:

      An identifier for a library.

.. class:: <module-id>

   :superclasses: :class:`<named-id>`

   :keyword library: an instance of :class:`<library-id>`. Required.

   :description:

      An identifier for a module.



   :slot id-library: an instance of :class:`<library-id>`

.. class:: <definition-id>

   :superclasses: :class:`<named-id>`

   :keyword module: an instance of :class:`<module-id>`. Required.

   :description:

      An identifier for a definition within a module.
   :slot id-module:  an instance of :class:`<module-id>`

.. class:: <method-id>

   :superclasses: :class:`<unique-id>`

   :keyword generic-function: an instance of :class:`<definition-id>`. Required.
   :keyword specializers: an instance of :drm:`<simple-object-vector>`. Required.

   :description:

      An identifier for a method.

   :slot id-generic-function: an instance of :class:`<definition-id>`
   :slot id-specializers:  an instance of :drm:`<simple-object-vector>`

.. class:: <object-location-id>

   :superclasses: :class:`<id>`

   :keyword filename: an instance of :class:`<file-locator>`. Required.
   :keyword line-number: an instance of :drm:`<integer>`. Required.

   :slot id-filename: an instance of :class:`<file-locator>`
   :slot id-line-number: an instance of :drm:`<integer>`.

.. class:: <library-object-location-id>

   :superclasses: :class:`<object-location-id>`

   :keyword filename: an instance of :class:`<file-locator>`. Required.
   :keyword line-number: an instance of :drm:`<integer>`. Required.
   :keyword library: an instance of :class:`<library-id>`. Required.

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword library: an instance of :class:`<library-object>`. Required.

Environment Objects
^^^^^^^^^^^^^^^^^^^
- :class:`<environment-object>`
- :class:`<environment-object-with-id>`
- :class:`<environment-object-with-library>`
- :gf:`note-object-properties-changed`
- :gf:`environment-object-id`
- :gf:`environment-object-exists?`
- :gf:`environment-object-primitive-name`
- :gf:`get-environment-object-primitive-name`
- :gf:`environment-object-basic-name`
- :gf:`environment-object-display-name`
- :gf:`environment-object-unique-name`
- :gf:`environment-object-type`
- :gf:`environment-object-type-name`
- :gf:`environment-object-source`
- :gf:`environment-object-source-location`
- :gf:`environment-object-home-server?`
- :gf:`environment-object-home-name`
- :gf:`environment-object-name`
- :gf:`environment-object-library`
- :gf:`find-environment-object`
- :gf:`make-environment-object`
- :gf:`parse-environment-object-name`
- :gf:`parse-module-name`
- :gf:`print-environment-object`
- :gf:`print-environment-object-to-string`
- :gf:`print-environment-object-name`
- :gf:`print-environment-object-name-to-string`
- :gf:`source-location-environment-object`

.. class:: <environment-object>
   :abstract:
   :primary:

   :superclasses: :drm:`<object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`

.. class:: <environment-object-with-id>
   :primary:

   :superclasses: :class:`<environment-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword id: an instance of :class:`false-or(<id-or-integer>) <<id-or-integer>>`. Required.

.. class:: <environment-object-with-library>
   :open:
   :abstract:

   :superclasses: :class:`<environment-object>`

.. type:: <id-or-integer>

   :equivalent: the type union of :drm:`<integer>` and :class:`<id>`.

.. generic-function:: note-object-properties-changed

   :signature: note-object-properties-changed *project*, *object*, *type* => ()

   :parameter project: an instance of :class:`<project-object>`
   :parameter object: an instance of :class:`<environment-object>`
   :parameter type: an instance of :type:`<query-type>`

.. generic-function:: environment-object-id
   :open:

   :signature: environment-object-id *server*, *object* => *id*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return id: an instance of :class:`false-or(<id-or-integer>) <<id-or-integer>>`

.. generic-function:: environment-object-exists?
   :open:

   :signature: environment-object-exists? *server*, *object* => *exists?*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return exists?: an instance of :drm:`<boolean>`

.. generic-function:: environment-object-primitive-name
   :open:

   :signature: environment-object-primitive-name *server*, *object* => *name*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return name: an instance of :drm:`false-or(<string>) <<string>>`

.. generic-function:: get-environment-object-primitive-name
   :open:

   :signature: get-environment-object-primitive-name *server*, *object* => *name*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`
   :return name: an instance of :drm:`false-or(<string>) <<string>>`

.. generic-function:: environment-object-library
   :open:

   :signature: environment-object-library *server*, *object* => *library*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`
   :return library: an instance of :class:`false-or(<library-object>) <<library-object>>`


.. generic-function:: environment-object-basic-name
   :open:

   :signature: environment-object-basic-name *server*, *object* ``#key`` ``#all-keys`` => name

   :parameter server:  an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return name:  an instance of :drm:`false-or(<string>) <<string>>`

.. generic-function:: environment-object-display-name
   :open:

   :signature: environment-object-display-name *server*, *object*, *namespace* ``#key`` ``#all-keys`` => name

   :parameter server:  an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`
   :parameter namespace: an instance of :class:`false-or(<namespace-object>) <<namespace-object>>`

   :return name:  an instance of :drm:`false-or(<string>) <<string>>`

.. generic-function:: environment-object-unique-name
   :open:

   :signature: environment-object-unique-name *server*, *object*, *namespace* ``#key`` ``#all-keys`` => name

   :parameter server:  an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`
   :parameter namespace: an instance of :class:`false-or(<namespace-object> <<namespace-object>>`

   :return name:  an instance of :drm:`false-or(<string>) <<string>>`

.. generic-function:: environment-object-type
   :open:

   :signature: environment-object-type *server*, *object* => *type*
   :parameter server:  an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return type: an instance of :class:`<environment-object>`

.. generic-function:: environment-object-type-name
   :open:

   :signature: environment-object-type-name *object* => *type*
   :parameter object: an instance of :class:`<environment-object>`

   :return type-name: an instance of :drm:`<string>`

.. generic-function:: environment-object-source
   :open:

   :signature: environment-object-source *server*, *object* => *source*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return source: an instance of :drm:`false-or(<string>) <<string>>`

.. generic-function:: environment-object-source-location
   :open:

   :signature: environment-object-source-location *server*, *object* => *location*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return location: an instance of :class:`false-or(<source-location>) <<source-location>>`

.. generic-function:: environment-object-home-server?

   Note there is no generic function actually defined in this module.

   :signature: environment-object-home-server? *server*, *object* => *home?*
   :parameter server: an instance of :drm:`<object>`
   :parameter object: an instance of :drm:`<object>`

   :return home?: an instance of :drm:`<boolean>`

.. generic-function:: environment-object-home-name
   :open:

   :signature: environment-object-home-name     *server*, *object* => *name*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

   :return name: an instance of :class:`false-or(<name-object>) <<<name-object>>`

.. generic-function:: environment-object-name
   :open:

   :signature: environment-object-name     *server*, *object*, *namespace* => *name*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`
   :parameter namespace: an instance of :class:`<namespace-object>`

   :return name: an instance of :class:`false-or(<name-object>) <<<name-object>>`

.. generic-function:: source-location-environment-object
   :open:

   :signature: source-location-environment-object *server* *location* => *object*

   :parameter server: an instance of :class:`<server>`
   :parameter location: an instance of :class:`<source-location>`

   :return object: an instance of :class:`false-or(<environment-object>) <<environment-object>>`

.. generic-function:: find-environment-object
   :open:

   Find an environment object by name or id

   :signature: find-environment-object *server*, *name* ``#key`` ``#all-keys`` => object

   :parameter server: an instance of :class:`<server>`
   :parameter name: an instance of :drm:`<string>` or :class:`<id-or-integer>`

   :return object: an instance of :class:`false-or(<environment-object>) <<environment-object>>`

.. generic-function:: make-environment-object
   :sealed:

   :signature: make-environment-object *class* ``#key`` *project* *library* *id* *application-object-proxy* *compiler-object-proxy* => *object*

   :parameter class: a instance of :drm:`<class>`, a subclass of :class:`<environment-object>`
   :parameter key project: an instance of :class:`<project-object>`
   :parameter key library: an instance of :class:`false-or(<library-object>) <<library-object>>`
   :parameter key id: an instance of :class:`false-or(<id-or-integer>) <<id-or-integer>>`
   :parameter key application-object-proxy: an instance of :drm:`<object>`
   :parameter key compiler-object-proxy: an instance of :drm:`<object>`

   :return object: an instance of :class:`<environment-object>`

.. generic-function:: parse-environment-object-name
   :sealed:

   :signature: parse-environment-object-name *name* ``#key`` ``#all-keys`` => id

   :parameter name: an instance of :drm:`<string>`

   :return id: an instance of :class:`false-or(<id-or-integer>)<<id-or-integer>>`

.. generic-function:: parse-module-name

   :signature: parse-module-name *name* ``#key`` *library* => id

   :parameter name: an instance of :drm:`<string>`
   :parameter key library: an instance of :class:`false-or(<library-id>) <<library-id>>`

   :return id: an instance of :class:`false-or(<module-id>) <<module-id>>`

.. generic-function:: print-environment-object
   :open:

   :signature: print-environment-object *stream*, *server*, *object* ``#key`` ``#all-keys`` => ()

   :parameter stream: an instance of :class:`<stream>`
   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

.. generic-function:: print-environment-object-name
   :open:

   :signature: print-environment-object-name *stream*, *server*, *object* ``#key`` ``#all-keys`` => ()

   :parameter stream: an instance of :class:`<stream>`
   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`

.. generic-function:: print-environment-object-name-to-string
   :open:

   :signature: print-environment-object-name-to-string *server*, *object* ``#rest`` args ``#key`` *namespace* ``#all-keys`` => *name*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<environment-object>`
   :parameter key namespace: an instance of :class:`<object>`
   :value name: an instance of :drm:`<string>`

Environment options
^^^^^^^^^^^^^^^^^^^

- :class:`<environment-options>`

.. class:: <environment-options>

   :superclasses: :class:`<environment-object>`

Compiler Objects
^^^^^^^^^^^^^^^^
- :class:`<compiler-object>`

.. class:: <compiler-object>
   :sealed:
   :abstract:

   :superclass: :class:`<environment-object>`

   :keyword compiler-object-proxy: an instance of :drm:`<object>`. Required.

   :slot compiler-object-proxy:

.. generic-function:: invalidate-compiler-proxy
   :open:

   :signature: invalidate-compiler-proxy *server*, *object* => ()

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<compiler-object>`

Application Objects
^^^^^^^^^^^^^^^^^^^

- :class:`<application-object>`
- :class:`<application-code-object>`
- :gf:`application-object-class`
- :gf:`application-object-address`
- :gf:`invalidate-application-proxy`

.. class:: <application-object>
   :abstract:
   :sealed:
   :primary:

   :superclasses: :class:`<environment-object>`

   :keyword application-object-proxy: an instance of :drm:`<object>`.

   :slot application-object-proxy: an instance of :drm:`<object>`.

.. generic-function:: invalidate-application-proxy

   :signature: invalidate-application-proxy *server*, *object* => ()

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<application-object>`

.. generic-function:: application-object-class
   :open:

   :signature: application-object-class *server*, *object* => *class*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<application-object>`

   :return class: an instance of :class:`false-or(<class-object>) <<class-object>>`

.. generic-function:: application-object-address
   :open:

   :signature: application-object-class *server*, *object* => *class*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<application-object>`

   :return class: an instance of :class:`false-or(<address-object>) <<address-object>>`

.. class:: <application-code-object>
   :abstract:
   :sealed:

   :superclasses: :class:`<application-object>`

   :keyword application-object-proxy: an instance of :drm:`<object>`.

Unbound Objects
^^^^^^^^^^^^^^^
- :class:`<unbound-object>`
- :const:`$unbound-object`

.. class:: <unbound-object>

   :superclasses: :class:`<application-object>`

.. constant:: $unbound-object

   :type: :class:`<unbound-object>`

   Used to indicate the application is not set. Only used once, in the debugger.

Address Objects
^^^^^^^^^^^^^^^
- :type:`<address-display-format>`
- :type:`<data-display-format>`
- :class:`<data-display-size>`
- :class:`<address-object>`
- :const:`$invalid-address-object`
- :gf:`address-application-object`
- :gf:`address-to-string`
- :gf:`string-to-address`
- :gf:`indirect-address`
- :gf:`indexed-address`
- :gf:`address-read-memory-contents`
- :gf:`address-read-application-object`

.. class:: <address-object>

   :superclasses: :class:`<application-object>`

.. type:: <address-display-format>

   :equivalent: One of ``#"octal"``, ``#"decimal"`` or ``#"hexadecimal"``.

.. type:: <data-display-format>

   :equivalent: A type union of :type:`<address-display-format>` and :type:`<non-address-display-format>`

.. type:: <non-address-display-format>

   :equivalent: One of ``#"byte-character"``,
         ``#"unicode-character"``,
         ``#"single-float"`` or
         ``#"double-float"``

.. constant:: $invalid-address-object

   This unique instance of <address-object> serves as a legal member of
   the type, but without any valid interpretation. This is used in
   preference to #f as a failing result or argument.

   :type: <address-object>

.. generic-function:: address-application-object
   :open:

   Convert an address to a more specific object.

   :signature: address-application-object *server*, *addr* => *obj*

   :parameter server: The backend dispatching object, an instance of :class:`<server>`
   :parameter addr: The address to be converted, an instance of :class:`<address-object>`

   :return obj: an instance of :class:`<application-object>`

   :description:
      Converts an abstract address to a more specific application
      object where possible. (Eg. if the address corresponds
      exactly to a dylan object, then the dylan object will be
      returned).

      The return value is an instance of <application-object>, possibly a
      <foreign-object>. If the address is not valid, then
      it may just be returned unchanged, which is to contract
      since <address-object> is itself a subclass of
      <application-object>.

.. generic-function:: address-to-string
   :open:

   Converts an abstract address into a printable string.

   :signature: address-to-string *server*, *address*, ``#key`` *format* => *s*
   :parameter server: an instance of :class:`<server>`
   :parameter address: an instance of :class:`<address>`
   :parameter #key format: an instance of :class:`<address-display-format>`
   :return s: an instance of :drm:`<string>`

   :description: Outputs a string of fixed size per runtime platform, padded with
		 leading
		 zeros if necessary, and formatted as per the supplied number base.
		 The string contains no extra decoration. This must be added by the
		 UI where required.
		 If the supplied address is invalid, the server will return a
		 string of the correct size, but filled with question-mark ('?')
		 characters.

.. generic-function:: string-to-address
   :open:

   Converts a string to an abstract address.

   :signature: string-to-address *server*, *str*, ``#key`` *format* => *address*
   :parameter server: an instance of :class:`<server>`
   :parameter str: an instance of :drm:`<string>`
   :parameter #key format: an instance of :class:`<address-display-format>`
   :return address: an instance of :class:`<address>`

   :description:
      This is not a parsing function. For a string that is not well-formed,
      the address returned may be invalid, or otherwise nonsensical.
      Parsing should be performed by the UI, which should also undertake
      to strip away any extra decoration that it might require in order
      to determine the number base (eg. "#x").

.. generic-function:: indirect-address
   :open:

   Indirects through an address to generate a new address.

   :signature: indirect-address *server*, *address* => *i-address*
   :parameter server: an instance of :class:`<server>`
   :parameter address: an instance of :class:`<address>`
   :return i-address: an instance of :class:`<address>`

   :description:
      Outputs the address object obtained by indirecting through
      the original address.
      It is entirely possible for this address to be invalid,
      and this will certainly be the case if the original
      address is invalid.

.. generic-function:: indexed-address
   :open:

   Adds an indexed-offset to a base address.

   :signature: indexed-address *server*, *addr*, *index*, *size* => *i-addr*

   :parameter server: an instance of :class:`<server>`
   :parameter addr: The base address, an instance of :class:`<address>`
   :parameter index: An integer used as the index. An instance of :drm:`<integer>`
   :parameter size: An instance of :class:`<data-display-size>`. The implementation
                will multiply the index by the appropriate factor according
                to this. The default is #"word".
   :return i-addr: an instance of :class:`<address>`

.. generic-function:: address-read-memory-contents
   :open:

   :signature: address-read-memory-contents *server*, *addr*, ``#key`` *size*, *format*, *from-index*, *to-index* => *printable-strings*, *nxt*

   :parameter server: an instance of :class:`<server>`
   :parameter addr: The base address, an instance of :class:`<address>`
   :parameter #key size: The granularity at which to read the data, defaults
		     to ``#"word"``, the runtime platform word-size.
   :parameter #key format: The format directive for the imported data.
		       An instance of :class:`<address-display-format>`
   :parameter #key from-index: An index interpreted according to the ``size`` parameter,
		      from which to read the first object. Default zero.
		      An instance of :drm:`<integer>`
   :parameter #key to-index: An index
		      from which to read the last object. Default 7
		      An instance of :drm:`<integer>`
   :return printable-strings: an instance of :drm:`<sequence>`
   :return nxt: an instance of :class:`<address-object>`
   :description:
      Import a block of memory contents starting at the supplied
      address, and return the contents as formatted strings. Also
      returns the address that immediately follows the block that
      has been read.

.. generic-function:: address-read-application-object
   :open:

   Import an application object from an address.

   :signature: address-read-application-object *server*, *addr* => *obj*

   :parameter server: The backend dispatching object. An instance of :class:`<server>`
   :parameter addr: The address at which to base the import. An instance of :class:`<address-object>`
   :return obj: An instance of :class:`false-or(<application-object>) <<application-object>>`
		Returns the imported application object, or #f if the
                import fails.

Register Objects
^^^^^^^^^^^^^^^^

- :class:`<register-category>`
- :class:`<register-object>`
- :func:`application-registers`
- :gf:`do-application-registers`
- :gf:`register-contents`
- :gf:`register-contents-address`
- :gf:`lookup-register-by-name`

.. type:: <register-category>

   Describes an abstract categorization for the runtime register set.

   :equivalent: one of ``#"general-purpose"``,
      ``#"special-purpose"``,
      or ``#"floating-point"``.

.. class:: <register-object>

   Represents a hardware-level register.

   :superclasses: :class:`<application-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword application-object-proxy: an instance of :drm:`<object>`.

.. function:: application-registers

   :signature: application-registers *server* ``#key`` *category* => *classes*
   :parameter server: an instance of :class:`<server>`
   :parameter #key category: an instance of :type:`<register-category>`
   :return classes: an instance of :drm:`<sequence>`

.. generic-function:: lookup-register-by-name
   :open:

   Tries to find a register object corresponding to a given
   name.

   :signature: lookup-register-by-name *server*, *name* => *reg*
   :parameter server: an instance of :class:`<server>`
   :parameter name: an instance of :drm:`<string>`
   :return reg: an instance of :class:`false-or(<register-object>) <<register-object>>`

   :description:
      If successful, returns a :class:`<register-object>`.
      Returns #f if no match is found, or if the application
      is not tethered.

.. generic-function:: do-application-registers
   :open:

   Iterates over all runtime registers.

   :signature: do-application-registers *f*, *server* ``#key`` *category* => ()

   :parameter f: an instance of :drm:`<function>`
   :parameter server: an instance of :class:`<server>`
   :parameter #key category: an instance of :type:`<register-category>`

   :description:
      The function has signature ``(<register-object>) => ()``.
      If category is supplied, must be a <register-category>. The
      iteration will be restricted to registers of this
      category.
      If not supplied, the iteration will include all
      available platform registers.

.. generic-function:: register-contents
   :open:

   Retrieve the value stored in a register.

   :signature: register-contents *server*, *reg*, *thread* ``#key`` *stack-frame-context* => *obj*

   :parameter server: an instance of :class:`<server>`
   :parameter reg: an instance of :class:`<register-object>`
   :parameter thread: an instance of :class:`<thread-object>`
   :parameter #key stack-frame-context: an instance of :class:`<stack-frame-object>`
   :return obj: an instance of :class:`false-or(<application-object>) <<application-object>>`

   :description:
      The thread context must be supplied as it is assumed that registers are a thread-local
      resource on all platforms.
      On different platforms, varying numbers of registers
      are saved per stack frame. If a <stack-frame-object>
      is supplied via the keyword argument, and the corresponding
      register is stack-frame local, then the appropriate
      value will be retrieved. Where this is not possible,
      the basic thread-local value will be used regardless of
      the frame context.

.. generic-function:: register-contents-address
   :open:

   Retrieve the value stored in a register, represented as an address.

   :signature: register-contents *server*, *reg*, *thread* ``#key`` *stack-frame-context* => *obj*

   :parameter server: an instance of :class:`<server>`
   :parameter reg: an instance of :class:`<register-object>`
   :parameter thread: an instance of :class:`<thread-object>`
   :parameter #key stack-frame-context: an instance of :class:`<stack-frame-object>`
   :return obj: an instance of :class:`false-or(<address-object>) <<address-object>>`

   :description:
      The thread context must be supplied as it is assumed that registers are a thread-local
      resource on all platforms.
      On different platforms, varying numbers of registers
      are saved per stack frame. If a <stack-frame-object>
      is supplied via the keyword argument, and the corresponding
      register is stack-frame local, then the appropriate
      value will be retrieved. Where this is not possible,
      the basic thread-local value will be used regardless of
      the frame context. The returned object is the register's context, interpreted as an
      address <application-object>.

Component Objects
^^^^^^^^^^^^^^^^^
- :class:`<component-object>`
- :gf:`component-image-filename`
- :gf:`component-version`
- :func:`component-version-string`
- :gf:`lookup-component-by-name`
- :func:`application-components`
- :gf:`do-application-components`

.. class:: <component-object>

   A shared object or executable file.

   :superclass: :class:`<application-object>`

   :description:
      A subclass of <application-object>.
      Represents a runtime "component" - ie. a DLL/EXE file, or a shared
      object file.

      ``application-object-address`` can be called on objects of this class,
      and the result is interpreted as the "base address" of the component.

      ``environment-object-primitive-name`` for this class returns the name
      of the component as stripped of all platform-specific pathname
      and extension strings. Therefore, there is no ``component-name``
      protocol.

.. generic-function:: component-image-filename
   :open:

   Locates the binary image file (on disk) associated with
   the component.

   :signature: component-image-filename *server*, *component* => *file*

   :parameter server: an instance of :class:`<server>`
   :parameter component: an instance of :class:`<component-object>`
   :return file: an instance of :class:`false-or(<file-locator>) <<file-locator>>`

.. generic-function:: component-version
   :open:

   Return the version number of a component.

   :signature: component-version *server*, *component* => *major-version-index*, *minor-version-index*

   :parameter server: an instance of :class:`<server>`
   :parameter component: an instance of :class:`<component-object>`
   :return major-version-index: an instance of :drm:`<integer>`
   :return minor-version-index: an instance of :drm:`<integer>`

   :description:
      Returns the version number for a component. This is assumed
      to be both meaningful and obtainable on all platforms.

.. function:: component-version-string

   Return the component's version as a string.

   :signature: component-version *server*, *component* => *version-string*

   :parameter server: an instance of :class:`<server>`
   :parameter component: an instance of :class:`<component-object>`
   :return version-string: an instance of :drm:`<string>`

.. generic-function:: lookup-component-by-name
   :open:

   :signature: lookup-component-by-name *server*, *name* => *component*
   :parameter server: an instance of :class:`<server>`
   :return component: an instance of :class:`false-or(<component-object>) <<component-object>>`
   :return version-string: an instance of :drm:`<string>`

.. generic-function:: do-application-components
   :open:

   Iterates over the components currently loaded into an
   application.

   :signature: do-application-components *f*, *server* => ()

   :parameter f: an instance of :class:`<function>` with signature
            ``(<component-object>) => ()``
   :parameter server: an instance of :class:`<server>`

.. function:: application-components

   Get a collection of all components

   :signature: application-components *server* => *components*

   :parameter server: an instance of :class:`<server>`
   :return components: an instance of :drm:`<sequence>`

Application and Compiler Objects
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- :class:`<application-and-compiler-object>`

.. class:: <application-and-compiler-object>
   :open:
   :abstract:

   Combined application and compiler object.

   :superclasses: :class:`<application-object>` :class:`<compiler-object>`

Composite Objects
^^^^^^^^^^^^^^^^^
- :class:`<composite-object>`
- :gf:`composite-object-size`
- :gf:`composite-object-contents`

.. class:: <composite-object>
   :abstract:

   :superclass: :class:`<application-object>`

.. generic-function:: composite-object-size
   :open:

   :signature: composite-object-size *server*, *object*, ``#key`` *inherited?* => *size*
   :parameter server:  an instance of :class:`<server>`
   :parameter object: an instance of :class:`<composite-object>`
   :parameter #key inherited?: an instance of :drm:`<boolean>`
   :return size: an instance of :drm:`false-or(<integer>) <<integer>>`

.. generic-function:: composite-object-contents
   :open:

   :signature: composite-object-contents *server*, *object*, ``#key`` *inherited?* => *names*, *values*
   :parameter server:  an instance of :class:`<server>`
   :parameter object: an instance of :class:`<composite-object>`
   :parameter #key inherited?: an instance of :drm:`<boolean>`
   :return names: an instance of :drm:`<sequence>`
   :return values: an instance of :drm:`<sequence>`

User Objects
^^^^^^^^^^^^
- :class:`<user-object>`
- :gf:`user-object-slot-value`
- :gf:`user-object-slot-values`

.. class:: <user-object>

   :superclasses: :class:`<composite-object>` :class:`<environment-object-with-id>`

.. generic-function:: user-object-slot-values

   :signature: user-object-slot-values *server*, *object* => *functions*, *values*

   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<user-object>`
   :return functions: an instance of :drm:`<sequence>`
   :return values: an instance of :drm:`<sequence>`

.. generic-function:: user-object-slot-value
   :open:

   :signature: user-object-slot-value *server*, *object*, *slot* ``#key`` *repeated-element* => *value*
   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<user-object>`
   :parameter slot: an type union of :class:`<definition-id>` and :class:`<slot-object>`
   :parameter #key repeated-element: an instance of :drm:`<object>`
   :return value: an instance of :class:`false-or(<environment-object>) <<environment-object>>`

User Class Info
^^^^^^^^^^^^^^^
- :class:`<user-class-info>`
- :func:`user-object-class-mappings`

.. class:: <user-class-info>
   :sealed:

   :superclasses: :class:`<object>`

   :keyword class: an instance of :drm:`<class>`. Required.
   :keyword id: an instance of :class:`<definition-id>`. Required.

   :slot user-class-info-class:  an instance of :drm:`<class>`
   :slot user-class-info-id: an instance of :class:`<definition-id>`

.. function:: user-object-class-mappings

   :signature: user-object-class-mappings () => mappings
   :return mappings: an instance of :drm:`<sequence>`

Internal Objects
^^^^^^^^^^^^^^^^

- :class:`<internal-object>`

.. class:: <internal-object>

   :superclass: :class:`<user-object>`


Foreign Objects
^^^^^^^^^^^^^^^

- :class:`<foreign-object>`

.. class:: <foreign-object>

   :superclass: :class:`<application-code-object>`

Dylan Objects
^^^^^^^^^^^^^

Dylan objects don't seem to do much yet, but it seems like it should
be useful for the environment to be able to work out if an object is
part of the language (e.g. a class) or whether it is an abstraction
provided by the environment (e.g. a project)

- :class:`<dylan-object>`
- :class:`<dylan-application-object>`
- :class:`<immediate-application-object>`
- :class:`<dylan-compiler-object>`
- :const:`$dylan-library-id`
- :const:`$dylan-module-id`
- :const:`$dylan-extensions-module-id`
- :const:`$dispatch-engine-module-id`
- :const:`$<object>-id`
- :const:`$<class>-id`
- :const:`$<method>-id`
- :const:`$<generic-function>-id`

.. class:: <dylan-object>
   :open:
   :abstract:

   :superclass: :class:`<environment-object>`

.. class:: <dylan-application-object>
   :open:
   :abstract:

   :superclass: :class:`<dylan-object>` :class:`<application-object>`

.. class:: <immediate-application-object>
   :open:
   :abstract:

   :superclass: :class:`<dylan-application-object>`

.. class:: <dylan-compiler-object>
   :open:
   :abstract:

   :superclass: :class:`<dylan-object>` :class:`<compiler-object>`


.. constant:: $dylan-library-id

   :type: :class:`<library-id>`

.. constant:: $dylan-module-id

   :type: :class:`<module-id>`

.. constant:: $dylan-extensions-module-id

   :type: :class:`<module-id>`

.. constant:: $dispatch-engine-module-id

   :type: :class:`<module-id>`

.. constant:: $<object>-id

   :type: :class:`<definition-id>`

.. constant:: $<class>-id

   :type: :class:`<definition-id>`

.. constant:: $<method>-id

   :type: :class:`<definition-id>`

.. constant:: $<generic-function>-id

   :type: :class:`<definition-id>`

.. constant:: $<boolean>-id

   :type: :class:`<definition-id>`



Dylan Expression Objects
^^^^^^^^^^^^^^^^^^^^^^^^

Expression objects represent arbitrary expressions in Dylan, usually
on the right-hand side of an assignment.

- :class:`<expression-object>`
- :class:`<type-expression-object>`
- :class:`<complex-type-expression-object>`

.. class:: <expression-object>
   :open:
   :abstract:

   A basic expression.

   :superclass: :class:`<dylan-compiler-object>`

.. class:: <type-expression-object>
   :open:

   Expressions that evaluate to a type.

   :superclass: :class:`<expression-object>`

.. class:: <complex-type-expression-object>
   :open:

   The canonical type expression of arbitrary complexity (only one instance)

   :superclass: :class:`<type-expression-object>`

Dylan Application Objects
^^^^^^^^^^^^^^^^^^^^^^^^^
- :class:`<character-object>`
- :class:`<string-object>`
- :class:`<symbol-object>`
- :class:`<number-object>`
- :class:`<integer-object>`
- :func:`number-object-to-string`


.. class:: <character-object>

   :superclass: :class:`<immediate-application-object>`

.. class:: <string-object>

   :superclass: :class:`<sequence-object>`

.. class:: <symbol-object>

   :superclass: :class:`<immediate-application-object>`

.. class:: <number-object>

   :superclass: :class:`<immediate-application-object>`

.. class:: <integer-object>

   :superclass: :class:`<number-object>`

.. generic-function:: number-object-to-string
   :open:

   :signature: number-object-to-string *server*, *number*, ``#key`` *prefix?* *format* => *string*

   :parameter server: an instance of :class:`<server>`
   :parameter number: an instance of :class:`<number-object>`
   :parameter #key prefix?: an instance of :drm:`<boolean>`
   :parameter #key format: an instance of :drm:`false-or(<symbol>) <<symbol>>`
   :return string: an instance of :drm:`false-or(<string>) <<string>>`

Boolean Objects
^^^^^^^^^^^^^^^

- :class:`<boolean-object>`
- :const:`$true-object`
- :const:`$false-object`

.. class:: <boolean-object>

   :superclass: :class:`<immediate-application-object>`
   :keyword true?: an instance of :drm:`<boolean>`. Required.
   :slot boolean-object-true?:

.. constant:: $true-object

   :type: :class:`<boolean-object>`

.. constant:: $false-object

   :type: :class:`<boolean-object>`


Collection Objects
^^^^^^^^^^^^^^^^^^

- :class:`<collection-object>`
- :class:`<sequence-object>`
- :class:`<explicit-key-collection-object>`
- :class:`<array-object>`
- :class:`<range-object>`
- :class:`<pair-object>`
- :gf:`collection-size`
- :gf:`collection-keys`
- :gf:`collection-elements`
- :gf:`do-collection-keys`
- :gf:`do-collection-elements`
- :gf:`range-start`
- :gf:`range-end`
- :gf:`range-by`
- :gf:`pair-head`
- :gf:`pair-tail`

.. class:: <collection-object>

   :superclasses: :class:`<composite-object>` :class:`<dylan-application-object>`

.. class:: <sequence-object>

   :superclass: :class:`<collection-object>`

.. class:: <explicit-key-collection-object>

   :superclasses: :class:`<internal-object>` :class:`<collection-object>`

.. class:: <range-object>

   :superclasses: :class:`<user-object>` :class:`<sequence-object>`

   Note: ranges are user objects, not internal objects, because
   the "Contents" page is the only way to browse ranges.

.. class:: <pair-object>

   :superclass: :class:`<user-object>`

   Note: This only models non-proper lists, so it isn't a sequence object

.. generic-function:: collection-size
   :open:

   :signature: collection-size *server*, *collection* => *size*
   :parameter server: an instance of :class:`<server>`
   :parameter collection: an instance of :class:`<collection-object>`
   :returns size: an instance of :drm:`false-or(<integer>) <<integer>>`

.. generic-function:: do-collection-keys
   :open:

   :signature: do-collection-keys *function*, *server*, *collection* => ()
   :parameter function: an instance of :drm:`<function>`
   :parameter server: an instance of :class:`<server>`
   :parameter collection: an instance of :class:`<collection-object>`

.. generic-function:: do-collection-elements
   :open:

   :signature: do-collection-keys *function*, *server*, *collection* => ()
   :parameter function: an instance of :drm:`<function>`
   :parameter server: an instance of :class:`<server>`
   :parameter collection: an instance of :class:`<collection-object>`

.. generic-function:: collection-keys
   :open:

   :signature: collection-keys *server*, *collection* ``#key`` range => *keys*
   :parameter server: an instance of :class:`<server>`
   :parameter collection: an instance of :class:`<collection-object>`
   :parameter #key range: an instance of :drm:`<range>`
   :return keys: an instance of :drm:`<sequence>`

.. generic-function:: collection-values
   :open:

   :signature: collection-values *server*, *collection* ``#key`` range => *values*
   :parameter server: an instance of :class:`<server>`
   :parameter collection: an instance of :class:`<collection-object>`
   :parameter #key range: an instance of :drm:`<range>`
   :return values: an instance of :drm:`<sequence>`

.. generic-function:: range-start
   :open:

   :signature: range-start *server*, *range* => *start*
   :parameter server: an instance of :class:`<server>`
   :parameter range: an instance of :class:`<range-object>`
   :return start: an instance of :class:`false-or(<number-object>) <<number-object>>`

.. generic-function:: range-end
   :open:

   :signature: range-end *server*, *range* => *end*
   :parameter server: an instance of :class:`<server>`
   :parameter range: an instance of :class:`<range-object>`
   :return end: an instance of :class:`false-or(<number-object>) <<number-object>>`

.. generic-function:: range-by
   :open:

   :signature: range-by *server*, *range* => *start*
   :parameter server: an instance of :class:`<server>`
   :parameter range: an instance of :class:`<range-object>`
   :return by: an instance of :class:`false-or(<number-object>) <<number-object>>`

.. generic-function:: pair-head
   :open:

   :signature: pair-head *server*, *pair* => *head*
   :parameter server: an instance of :class:`<server>`
   :parameter pair: an instance of :class:`<pair-object>`
   :return head: an instance of :class:`false-or(<application-object>) <<application-object>>`

.. generic-function:: pair-tail
   :open:

   :signature: pair-tail *server*, *pair* => *tail*
   :parameter server: an instance of :class:`<server>`
   :parameter pair: an instance of :class:`<pair-object>`
   :return tail: an instance of :class:`false-or(<application-object>) <<application-object>>`

Source Forms
^^^^^^^^^^^^

- :class:`<source-form-object>`
- :gf:`do-used-definitions`
- :gf:`do-client-source-forms`
- :gf:`source-form-has-clients?`
- :gf:`source-form-uses-definitions?`
- :func:`source-form-used-definitions`
- :func:`source-form-clients`

.. class:: <source-form-object>
   :open:
   :abstract:

   :superclasses: :class:`<application-code-object>`
		  :class:`<application-and-compiler-object>`
		  :class:`<environment-object-with-id>`

.. generic-function:: do-used-definitions
   :open:

   :signature: do-used-definitions *function*,  *server*, *object*, ``#key`` *modules* *libraries* *client* => ()
   :param function: an instance of :drm:`<function>`
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<source-form-object>`
   :param #key modules:
   :param #key libraries:
   :param #key client:
	       
.. generic-function:: do-used-definitions
   :open:

   :signature: do-client-source-forms *function*,  *server*, *object*, ``#key`` *modules* *libraries* *client* => ()
   :param function: an instance of :drm:`<function>`
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<source-form-object>`
   :param #key modules:
   :param #key libraries:
   :param #key client:
	       
.. generic-function:: source-form-has-clients?
   :open:

   :signature: source-form-has-clients? *server*, *object*, ``#key`` *modules* *libraries* *client* => *uses-definitions?*
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<source-form-object>`
   :param #key modules:
   :param #key libraries:
   :param #key client:
   :return has-clients?: an instance of :drm:`<boolean>`

.. generic-function:: source-form-uses-definitions?
   :open:

   :signature: source-form-uses-definitions? *server*, *object*, ``#key`` *modules* *libraries* *client* => *uses-definitions?*
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<source-form-object>`
   :param #key modules:
   :param #key libraries:
   :param #key client:
   :return uses-definitions?: an instance of :drm:`<boolean>`

.. function:: source-form-used-definitions
	      
   :signature: source-form-used-definitions *server*, *object*, ``#key`` *modules* *libraries* *client* => *used-definitions*
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<source-form-object>`
   :param #key modules:
   :param #key libraries:
   :param #key client:
   :return used-definitions: an instance of :drm:`<sequence>`	      

.. function:: source-form-clients
	      
   :signature: source-form-clients *server*, *object*, ``#key`` *modules* *libraries* *client* => *clients*
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<source-form-object>`
   :param #key modules:
   :param #key libraries:
   :param #key client:
   :return clients: an instance of :drm:`<sequence>`	      

Macro Calls
^^^^^^^^^^^
- :class:`<macro-call-object>`
- :gf:`do-macro-call-source-forms`
- :func:`macro-call-source-forms`


.. class:: <macro-call-object>
   :abstract:

   :superclass: :class:`<source-form-object>`

.. generic-function:: do-macro-call-source-forms
   :open:

   :signature: do-macro-call-source-forms *function*, *server*, *object* => ()
   :param function: an instance of :drm:`<function>`
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<macro-call-object>`

.. function:: macro-call-source-forms

   :signature: macro-call-source-forms *server*, *object* => *source-forms*
   :param server: an instance of :class:`<server>`
   :param object: an instance of :class:`<macro-call-object>`
   :return source-forms: an instance of :drm:`<sequence>`
			 
Non-definition source forms
^^^^^^^^^^^^^^^^^^^^^^^^^^^
- :class:`<simple-macro-call-object>`
- :class:`<top-level-expression-object>`

.. class:: <simple-macro-call-object>

   :superclasses: :class:`<top-level-expression-object>`
		  :class:`<macro-call-object>`

.. class:: <top-level-expression-object>

   :superclass: :class:`<source-form-object>`

Definition Objects
^^^^^^^^^^^^^^^^^^
- :class:`<definition-object>`
- :gf:`definition-modifiers`
- :gf:`definition-interactive-locations`
- :gf:`definition-known-locations`
- :func:`find-named-definition`

.. class:: <definition-object>
   :open:
   :abstract:

   :superclasses: :class:`<macro-call-object>` :class:`<dylan-object>` :class:`<environment-object-with-id>`

.. generic-function:: definition-modifiers
   :open:

   :signature: definition-modifiers *server*, *object* => *modifiers*
   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<definition-object>`
   :return modifiers: an instance of :drm:`<sequence>`. Each modifier is a :drm:`<symbol>`

.. generic-function:: definition-interactive-locations
   :open:

   :signature: definition-interactive-locations *server*, *object* => *locations*
   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<definition-object>`
   :return locations: an instance of :drm:`<sequence>`

.. generic-function:: definition-known-locations
   :open:

   :signature: definition-known-locations *server*, *object* => *locations*
   :parameter server: an instance of :class:`<server>`
   :parameter object: an instance of :class:`<definition-object>`
   :return locations: an instance of :drm:`<sequence>`

.. function:: find-named-definition

   :signature: find-named-definition *project*, *module*, *name* ``#key`` *imported* => *definition*
   :parameter project: an instance of :class:`<project>`
   :parameter module: an instance of :class:`<module>`
   :parameter name: an instance of :drm:`<string>`
   :parameter #key imported?: an instance of :drm:`<boolean>`, default ``#t``
   :return definition: an instance of :class:`false-or(<definition-object>) <<definition-object>>`
      
Breakpoints
^^^^^^^^^^^

There are many symbols associated with breakpoints. These are
not documented yet.

- :class:`<breakpoint-object>`
- :class:`<environment-object-breakpoint-object>`
- :class:`<class-breakpoint-object>`
- :class:`<function-breakpoint-object>`
- :class:`<simple-function-breakpoint-object>`
- :class:`<generic-function-breakpoint-object>`
- :class:`<method-breakpoint-object>`
- :class:`<source-location-breakpoint-object>`
- :class:`<breakpoint-state>`
- :class:`<breakpoint-direction>`
- :const:`$default-breakpoint-stop?`
- :const:`$default-breakpoint-message?`
- :const:`$default-breakpoint-transient?`
- :const:`$default-breakpoint-enabled?`
- :const:`$default-breakpoint-profile?`
- :const:`$default-breakpoint-test`
- :const:`$default-breakpoint-entry-function?`
- :const:`$default-breakpoint-directions`
- :func:`destroy-breakpoint`
- :func:`initialize-breakpoint`
- :func:`reinitialize-breakpoint`
- :func:`do-generic-breakpoint-methods`
- :func:`current-stop-breakpoints`
- :func:`find-breakpoint`
- :func:`project-breakpoints`
- :func:`source-location-breakpoints`
- :func:`environment-object-breakpoints`
- :func:`breakpoint-object`
- :func:`breakpoint-object-setter`
- :func:`breakpoint-project`
- :func:`breakpoint-stop?`
- :func:`breakpoint-stop?-setter`
- :func:`breakpoint-message?`
- :func:`breakpoint-message?-setter`
- :func:`breakpoint-transient?`
- :func:`breakpoint-transient?-setter`
- :func:`breakpoint-enabled?`
- :func:`breakpoint-enabled?-setter`
- :func:`breakpoint-profile?`
- :func:`breakpoint-profile?-setter`
- :func:`breakpoint-test`
- :func:`breakpoint-test-setter`
- :func:`breakpoint-entry-function?`
- :func:`breakpoint-entry-function?-setter`
- :func:`breakpoint-entry-point?`
- :func:`breakpoint-entry-point?-setter`
- :func:`breakpoint-directions`
- :func:`breakpoint-directions-setter`
- :func:`note-breakpoint-state-changed`
- :func:`server-note-breakpoint-state-changed`
- :func:`\with-compressed-breakpoint-state-changes`
- :func:`do-with-compressed-breakpoint-state-changes`
- :func:`note-breakpoint-state-changes-failed`
- :func:`trace-function`

Thread Objects
^^^^^^^^^^^^^^

No further documentation on thread objects.

- :class:`<thread-object>`
- :func:`thread-stack-trace`
- :func:`thread-complete-stack-trace`
- :func:`thread-index`
- :func:`thread-state`
- :func:`thread-runtime-state`
- :func:`thread-runtime-state-setter`
- :func:`thread-suspended?`
- :func:`thread-suspended?-setter`
- :func:`create-application-thread`
- :func:`suspend-application-thread`
- :func:`resume-application-thread`
- :func:`thread-current-interactor-level`
- :func:`add-application-object-to-thread-history`
- :func:`application-default-interactor-thread`

Restarts
^^^^^^^^

No further documentation on restarts.

- :class:`<restart-object>`
- :func:`application-thread-restarts`
- :func:`application-restart-message`
- :func:`application-restart-abort?`
- :func:`invoke-application-restart`

Machines
^^^^^^^^

No further documentation on Machines.

- :class:`<machine>`
- :func:`machine-network-address`
- :func:`machine-hostname`
- :func:`environment-host-machine`
- :func:`do-machine-connections`
- :func:`close-connection-to-machine`
- :func:`machine-connection-open?`
- :func:`<remote-debug-connection-error>`
- :func:`<remote-connection-closed-error>`
- :func:`<remote-connection-failed-error>`
- :func:`<remote-connection-password-mismatch-error>`
- :func:`failed-connection`
- :func:`failed-network-address`
- :func:`failed-password`
- :func:`<attempted-to-close-local-connection>`

Processes
^^^^^^^^^

Processes are not further documented.

- :class:`<process>`
- :func:`process-host-machine`
- :func:`process-executable-file`
- :func:`process-id`
- :func:`lookup-process-by-id`
- :func:`process-debuggable?`
- :func:`do-active-processes`
- :func:`do-processes-on-machine`

Applications
^^^^^^^^^^^^

Applications are not further documented.

- :class:`<application>`
- :class:`<application-state>`
- :class:`<application-startup-option>`
- :func:`\with-application-transaction`
- :func:`perform-application-transaction`
- :func:`application-startup-option`
- :func:`application-client`
- :func:`application-machine`
- :func:`application-filename`
- :func:`application-arguments`
- :func:`application-temporary-stop?`
- :func:`application-temporary-stop?-setter`
- :func:`application-state`
- :func:`application-state-setter`
- :func:`application-threads`
- :func:`application-running?`
- :func:`application-stopped?`
- :func:`application-closed?`
- :func:`application-tethered?`
- :func:`application-pause-before-termination?`
- :func:`application-just-hit-breakpoint?`
- :func:`application-just-hit-dylan-error?`
- :func:`application-just-hit-error?`
- :func:`application-just-interacted?`
- :func:`application-just-stepped?`
- :func:`application-stop-reason-message`
- :func:`close-application`
- :func:`continue-application`
- :func:`ensure-application-proxy`
- :func:`find-application-proxy`
- :func:`application-proxy-id`
- :func:`run-application`
- :func:`initialize-application-client`
- :func:`attach-live-application`
- :func:`note-run-application-failed`
- :func:`stop-application`
- :func:`make-project-application`
- :func:`step-application-into`
- :func:`step-application-over`
- :func:`step-application-out`
- :func:`update-application`
- :func:`note-application-initialized`

Compiler Databases
^^^^^^^^^^^^^^^^^^

- :class:`<compiler-database>`
- :func:`ensure-database-proxy`
- :gf:`find-compiler-database-proxy`
- :gf:`compiler-database-proxy-id`
- :func:`invalidate-compiler-database`

.. class:: <compiler-database>
   :open:
   :abstract:
   :primary:

   :superclasses: :class:`<server>` :class:`<environment-object>`

.. generic-function:: find-compiler-database-proxy
   :open:

   :signature: find-compiler-database-proxy *database*, *id* ``#key`` *imported?* => *compiler-proxy*
   :parameter database: instance of :class:`<compiler-database>`
   :parameter id: instance of :class:`<id>`
   :parameter key imported?: instance of :drm:`<boolean>`
   :return compiler-proxy: the proxy

.. function:: ensure-database-proxy

   Get an object's proxy, looking it up in the database if necessary

   :signature: ensure-database-proxy *database*, *object* => *proxy*
   :parameter database: instance of :class:`<compiler-database>`
   :parameter object: instance of :class:`<compiler-object>`
   :return proxy: the proxy    

Project Objects
^^^^^^^^^^^^^^^

- :class:`<project-object>`
- :const:`<compilation-mode>`
- :const:`<project-target-type>`
- :const:`<project-interface-type>`
- :func:`active-project`
- :func:`active-project-setter`
- :func:`project-name`
- :gf:`project-proxy`
- :gf:`project-application`
- :gf:`project-compiler-database`
- :gf:`project-database-changed?`
- :gf:`project-sources-changed?`

- :func:`project-opened-by-user?`
- :func:`project-opened-by-user?-setter`
- :func:`project-used-libraries`
- :func:`project-used-projects`
- :func:`do-project-used-libraries`
- :func:`do-project-file-libraries`
- :func:`do-used-projects`
- :func:`edit-source-location`
- :func:`edit-source-record`
- :func:`edit-definition`
- :gf:`open-project`
- :gf:`find-project`
- :gf:`create-new-user-project`
- :gf:`open-project-from-file`
- :func:`create-exe-project-from-file`
- :func:`import-project-from-file`
- :func:`close-project`
- :func:`project-add-source-record`
- :func:`project-remove-source-record`
- :func:`project-reorder-source-records`
- :func:`save-project`
- :func:`save-project-database`
- :func:`open-projects`
- :func:`current-project,`
- :func:`current-project-setter`
- :func:`project-library`
- :func:`project-start-function-name,`
- :func:`project-start-function-name-setter`
- :func:`project-start-function`
- :func:`project-read-only?`
- :func:`project-can-be-built?`
- :func:`project-can-be-debugged?`
- :func:`project-compiled?`
- :func:`project-sources`
- :func:`project-canonical-sources`
- :func:`project-canonical-source-record`
- :func:`project-canonical-filename`
- :func:`project-other-sources`
- :func:`project-directory`
- :func:`project-filename`
- :func:`project-build-filename,`
- :func:`project-build-filename-setter`
- :func:`project-full-build-filename`
- :func:`project-debug-filename,`
- :func:`project-debug-filename-setter`
- :func:`project-debug-arguments,`
- :func:`project-debug-arguments-setter`
- :func:`project-debug-machine-address,`
- :func:`project-debug-machine-address-setter`
- :func:`project-debug-machine,`
- :func:`project-debug-machine-setter`
- :func:`project-debug-directory,`
- :func:`project-debug-directory-setter`
- :func:`project-build-directory`
- :func:`project-bin-directory`
- :func:`project-release-directory`
- :func:`project-server-path`
- :func:`project-compilation-mode,`
- :func:`project-compilation-mode-setter`
- :func:`project-compiler-back-end`
- :func:`project-compiler-back-end-setter`
- :func:`project-executable-name,`
- :func:`project-executable-name-setter`
- :func:`project-target-type,`
- :func:`project-target-type-setter`
- :func:`project-interface-type,`
- :func:`project-interface-type-setter`
- :func:`project-base-address,`
- :func:`project-base-address-setter`
- :func:`project-major-version,`
- :func:`project-major-version-setter`
- :func:`project-minor-version,`
- :func:`project-minor-version-setter`
- :func:`find-project-source-record`
- :func:`find-source-record-library`
- :func:`session-property`
- :func:`session-property-setter`
- :func:`source-record-top-level-forms`
- :func:`source-record-projects`
- :func:`source-record-colorization-info`
- :func:`open-project-compiler-database`
- :func:`parse-project-source`
- :func:`build-project`
- :func:`clean-project`
- :func:`link-project`
- :func:`note-user-project-opened`

.. class:: <project-object>
   :open:
   :abstract:
   :primary:

   :superclasses: :class:`<server>` :class:`<environment-object>`
   :keyword proxy:  An instance of :drm:`<object>`
   :keyword application: An instance of :class:`false-or(<application>) <<application>>`
   :keyword compiler-database: An instance of :class:`false-or(<compiler-database>) <<compiler-database>>`
   :keyword server-path: An instance of :class:`<server-path-type>`
   :slot project-proxy: An instance of :drm:`<object>`
   :slot project-application: An instance of :class:`false-or(<application>) <<application>>`, default #f
   :slot project-compiler-database: An instance of :class:`false-or(<compiler-database>) <<compiler-database>>`, default #f
   :slot project-next-numeric-id: An instance of :drm:`<integer>`
   :slot project-object-table: An instance of :drm:`<table>`
   :slot project-query-database: An instance of :drm:`<table>`
   :slot project-server-path: An instance of :class:`<server-path-type>`
   :slot environment-object-breakpoints: An instance of :drm:`<collection>`
   :slot source-location-breakpoints: An instance of :drm:`<collection>`
   :slot project-properties: An instance of :drm:`<list>`
   :slot project-profile-state: An instance of :class:`<profile-state>`
   
.. constant:: <compilation-mode>

   One of ``#"loose"``, ``#"tight"``

.. constant:: <project-target-type>

   One of ``#"executable"``, ``#"dll"``

.. constant:: <project-interface-type>

   One of ``#"console"``, ``#"gui"``

.. function:: active-project

   Get the currently active project.

   :signature: active-project () => *project*
   :return project: An instance of :class:`false-or(<project-object>) <<project-object>>` 

.. function:: active-project-setter

   Set the currently active project. Broadcasts a :class:`<project-now-active-message>` or 
   a :class:`<no-active-project>` message.

   :signature: active-project-setter *project* => *project*
   :parameter project: The project to set, an instance of :class:`false-or(<project-object>) <<project-object>>`
   :return project: An instance of :class:`false-or(<project-object>) <<project-object>>` 

.. function:: project-name

   Get the name of this project.

   :signature: project-name *project* => *name*
   :parameter project: An instance of :class:`<project-object>`
   :return name: An instance of :drm:`<string>`

.. generic-function:: project-proxy

   Get the proxy of this project (usually an instance of :class:`<project>`)

   :signature: project-proxy *project* => *proxy*
   :parameter project: An instance of :class:`<project-object>`
   :return proxy: An instance of :drm:`<object>`

.. generic-function:: project-application

   Get the application associated with this project

   :signature: project-application *project* => *application*
   :parameter project: An instance of :class:`<project-object>`
   :return application: An instance of :class:`false-or(<application>) <<application>>`

.. generic-function:: project-compiler-database

   Get the compiler database associated with this project

   :signature: project-compiler-database *project* => *compiler-database*
   :parameter project: An instance of :class:`<project-object>`
   :return compiler-database: An instance of :class:`false-or(<compiler-database>) <<compiler-database>>`

.. generic-function:: project-database-changed?

   Test if the project's database has changed.

   :signature: project-database-changed? *project* => *yes?*
   :parameter project: An instance of :class:`<project-object>`
   :return yes?: An instance of :drm:`<boolean>`

.. generic-function:: project-sources-changed?

   Test if the project's sources have changed.

   :signature: project-sources-changed? *project* => *yes?*
   :parameter project: An instance of :class:`<project-object>`
   :return yes?: An instance of :drm:`<boolean>`

Interactive Evaluation
^^^^^^^^^^^^^^^^^^^^^^

- :class:`<execution-id>`
- :class:`<execution-info>`
- :class:`<name-object>`
- :class:`<module-name-object>`
- :class:`<binding-name-object>`
- :class:`<namespace-object>`
- :class:`<library-object>`
- :class:`<module-object>`
- :class:`<macro-object>`
- :class:`<variable-object>`
- :class:`<module-variable-object>`
- :class:`<global-variable-object>`
- :class:`<thread-variable-object>`
- :class:`<constant-object>`
- :class:`<function-object>`
- :class:`<foreign-function-object>`
- :class:`<dylan-function-object>`
- :class:`<simple-function-object>`
- :class:`<generic-function-object>`
- :class:`<method-object>`
- :class:`<method-constant-object>`
- :class:`<internal-method-object>`
- :class:`<parameter>`
- :class:`<parameters>`
- :class:`<optional-parameter>`
- :class:`<optional-parameters>`
- :class:`<domain-object>`
- :class:`<type-object>`
- :class:`<singleton-object>`
- :class:`<class-object>`
- :class:`<slot-object>`
- :class:`<local-variable-object>`
- :class:`<stack-frame-object>`
- :class:`<warning-object>`
- :class:`<condition-object>`
- :class:`<duim-object>`
- :class:`<duim-frame-manager>`


Environment Protocols Module Classes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. class:: <class-object>

   :superclasses: :class:`<type-object>`


.. class:: <component-object>

   :superclasses: :class:`<application-object>`

   :description:
      A subclass of :class:`<application-object>`.
      Represents a runtime "component" - ie. a DLL/EXE file, or a shared
      object file.

      ``application-object-address`` can be called on objects of this class,
      and the result is interpreted as the "base address" of the component.

      ``environment-object-primitive-name`` for this class returns the name
      of the component as stripped of all platform-specific pathname
      and extension strings. Therefore, there is no ``component-name``
      protocol.

.. class:: <application-and-compiler-object>
   :open:
   :abstract:

   :superclasses: :class:`<application-object>` :class:`<compiler-object>`

.. class:: <composite-object>
   :abstract:

   :superclasses: :class:`<application-object>`



Environment Protocol Module Conditions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^





Environment Protocols Module Generics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- :gf:`application-object-class`
- :gf:`do-direct-subclasses`

.. generic-function:: application-object-class
   :open:

   :signature: application-object-class *server* *application-object* => false-or(*class-object*)
   :parameter server: An instance of :class:`<server>`
   :parameter application-object: An instance of :class:`<application-object>`
   :value class-object: An instance of :class:`<class-object>`

   :description:

      ?

   :example:

      .. code-block:: dylan

	 let obj = a-server.application-object-class(a-obj);

.. generic-function:: do-direct-subclasses
   :open:

   :signature: do-direct-subclasses *function* *server* *class* #key client *client* => ()
   :parameter function: An instance of :drm:`<function>`
   :parameter server: An instance of :class:`<server`
   :parameter class: An instance of :class:`<class-object>`
   :parameter client: An instance of :drm:`<object>`

.. generic-function:: do-direct-superclasses
   :open:

   :signature: do-direct-superclasses *function* *server* *class* #key client *client* => ()
   :parameter function: An instance of :drm:`<function>`
   :parameter server: An instance of :class:`<server`
   :parameter class: An instance of :class:`<class-object>`
   :parameter client: An instance of :drm:`<object>`

Environment Protocols Module Methods
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Environment Protocols Module Constants
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. constant:: <data-display-size>

   :description: One of

      * ``#"byte"``  - 8-bit value
      * ``#"short"`` - 16-bit value
      * ``#"long"``  - 32-bit value
      * ``#"hyper"`` - 64-bit value
      * ``#"float"`` - Single-precision floating-point value
      * ``#"double"`` -Double-precision floating-point value
