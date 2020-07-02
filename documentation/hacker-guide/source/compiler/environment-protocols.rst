*********************
Environment Protocols
*********************

.. current-library:: environment-protocols
.. current-module:: environment-protocols

This is information about environment protocols.

Server Objects
^^^^^^^^^^^^^^

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
   :parameter: server: an instance of :class:`<server>`
   :parameter: client: an instance of :drm:`<object>`
   :parameter: object: an instance of :drm:`<object>`
   :parameter: type:  an instance of :type:`<query-type>`

.. generic-function:: server-project
   :open:

   :signature: *server* => *project* 
   :parameter: server: an instance of :class:`<server>`
   :returns: project: an instance of :class:`<project-object>`

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
- :method:`note-object-properties-changed`
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

   :signature: *project*, *object*, *type* => ()

   :parameter: project: an instance of :class:`<project-object>`
   :parameter: object: an instance of :class:`<environment-object>`
   :parameter: type: an instance of :type:`<query-type>`
 
.. generic-function:: environment-object-id
   :open:

   :signature: *server*, *object* => *id*

   :parameter: server: an instance of :class:`<server>`
   :parameter: object: an instance of :class:`<environment-object>`

   :return: id: an instance of :class:`false-or(<id-or-integer>) <<id-or-integer>>`
 
.. generic-function:: environment-object-exists?
   :open:

   :signature: *server*, *object* => *exists?*

   :parameter: server: an instance of :class:`<server>`
   :parameter: object: an instance of :class:`<environment-object>`

   :return: exists?: an instance of :drm:`<boolean>`   

Environment options
^^^^^^^^^^^^^^^^^^^

- :class:`<environment-options>`

.. class:: <environment-options>

   :superclasses: :class:`<environment-object>`

Compiler Objects
^^^^^^^^^^^^^^^^
- :class:`<compiler-object>`

Application Objects
^^^^^^^^^^^^^^^^^^^

- :class:`<application-object>`
- :class:`<application-code-object>`
- :class:`<unbound-object>`
- :class:`<address-display-format>`
- :class:`<data-display-format>`
- :class:`<data-display-size>`
- :class:`<address-object>`
- :class:`<register-category>`
- :class:`<register-object>`
- :class:`<component-object>`
- :class:`<application-and-compiler-object>`

   .. 
      done to here

- :class:`<composite-object>`
- :class:`<user-object>`
- :class:`<user-class-info>`
- :class:`<internal-object>`
- :class:`<foreign-object>`
- :class:`<dylan-object>`
- :class:`<dylan-application-object>`
- :class:`<immediate-application-object>`
- :class:`<dylan-compiler-object>`
- :class:`<expression-object>`
- :class:`<type-expression-object>`
- :class:`<complex-type-expression-object>`
- :class:`<character-object>`
- :class:`<string-object>`
- :class:`<symbol-object>`
- :class:`<number-object>`
- :class:`<integer-object>`
- :class:`<boolean-object>`
- :class:`<collection-object>`
- :class:`<sequence-object>`
- :class:`<explicit-key-collection-object>`
- :class:`<array-object>`
- :class:`<range-object>`
- :class:`<pair-object>`
- :class:`<source-form-object>`
- :class:`<macro-call-object>`
- :class:`<simple-macro-call-object>`
- :class:`<top-level-expression-object>`
- :class:`<definition-object>`
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
- :class:`<thread-object>`
- :class:`<restart-object>`
- :class:`<machine>`
- :class:`<application>`
- :class:`<application-state>`
- :class:`<application-startup-option>`
- :class:`<compiler-database>`
- :class:`<project-object>`
- :class:`<compilation-mode>`
- :class:`<project-target-type>`
- :class:`<project-interface-type>`
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




.. class:: <compiler-object>

   :superclasses: :class:`<environment-object>`

   :keyword compiler-object-proxy: an instance of :drm:`<object>`. Required. 

.. class:: <address-object>

   :superclasses: :class:`<application-object>`





.. class:: <compiler-object>
   :abstract:
   :sealed:

   :superclasses: :class:`<environment-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword compiler-object-proxy: an instance of :drm:`<object>`. Required.

.. class:: <application-object>
   :abstract:
   :sealed:
   :primary:

   :superclasses: :class:`<environment-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword application-object-proxy: an instance of :drm:`<object>`.

.. class:: <application-code-object>
   :abstract:
   :sealed:

   :superclasses: :class:`<application-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword application-object-proxy: an instance of :drm:`<object>`.

.. class:: <unbound-object>

   :superclasses: :class:`<application-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword application-object-proxy: an instance of :drm:`<object>`.

.. class:: <register-object>

   :superclasses: :class:`<application-object>`

   :keyword name: an instance of :drm:`false-or(<string>) <<string>>`
   :keyword application-object-proxy: an instance of :drm:`<object>`.   

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
   :parameter: server: An instance of :class:`<server>`
   :parameter: application-object: An instance of :class:`<application-object>`
   :value: class-object: An instance of :class:`<class-object>`

   :description:

      ?

   :example:

      .. code-block:: dylan

	 let obj = a-server.application-object-class(a-obj);

.. generic-function:: do-direct-subclasses
   :open:

   :signature: do-direct-subclasses *function* *server* *class* #key client *client* => ()
   :parameter: function: An instance of :drm:`<function>`
   :parameter: server: An instance of :class:`<server`
   :parameter: class: An instance of :class:`<class-object>`
   :parameter: client: An instance of :drm:`<object>`

.. generic-function:: do-direct-superclasses
   :open:

   :signature: do-direct-superclasses *function* *server* *class* #key client *client* => ()
   :parameter: function: An instance of :drm:`<function>`
   :parameter: server: An instance of :class:`<server`
   :parameter: class: An instance of :class:`<class-object>`
   :parameter: client: An instance of :drm:`<object>`

Environment Protocols Module Methods
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Environment Protocols Module Constants
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. constant:: <address-display-format>

   :description: One of ``#"octal"``, ``#"decimal"`` or ``#"hexadecimal"``.

.. constant:: <data-display-format>

   :description: One of ``#"octal"``, ``#"decimal"``, ``#"hexadecimal"``, 
      ``#"byte-character"``, ``#"unicode-character"``, ``#"single-float"``
      or ``#"double-float"``.

.. constant:: <data-display-size>

   :description: One of

      * ``#"byte"``  - 8-bit value 
      * ``#"short"`` - 16-bit value 
      * ``#"long"``  - 32-bit value 
      * ``#"hyper"`` - 64-bit value 
      * ``#"float"`` - Single-precision floating-point value 
      * ``#"double"`` -Double-precision floating-point value 

.. constant:: $invalid-address-object

   :description: an instance of :class:`<address-object>`
      which is used only to indicate a failing result or argument

.. constant:: <id-or-integer>

   :description: a type union of :class:`<id>` and :drm:`<integer>`.

.. constant:: <register-category> 

   :description: one of ``#"general-purpose"``,
         ``#"special-purpose"``,
         or ``#"floating-point"``.