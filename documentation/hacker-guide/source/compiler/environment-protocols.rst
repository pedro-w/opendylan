*********************
Environment Protocols
*********************

.. current-library:: environment-protocols
.. current-module:: environment-protocols

This is information about environment protocols.

Environment Protocols Module Classes
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

- :class:`<server>`
- :class:`<closed-server-error>`
- :class:`<invalid-object-error>`
- :class:`<id>`
- :class:`<library-id>`
- :class:`<module-id>`
- :class:`<definition-id>`
- :class:`<method-id>`
- :class:`<object-location-id>`
- :class:`<library-object-location-id>`
- :class:`<environment-object>`
- :class:`<environment-object-with-id>`
- :class:`<environment-object-with-library>`
- :class:`<environment-options>`
- :class:`<compiler-object>`
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

.. class:: <class-object>

   :superclasses: :class:`<type-object>`

.. class:: <server>

   :superclasses: :drm:`<object>`

.. class:: <closed-server-error>

   :superclasses: :class:`<simple-error>`

.. class:: <invalid-object-error>

   :superclasses: :class:`<simple-error>`

   :keyword project: an instance of :class:`<project-object>`. Required.
   :keyword object: an instance of :class:`<environment-object>`. Required.

.. class:: <id>
   :abstract:

   :superclasses: :drm:`<object>`

   :description:

      An identifier for an environment object. See the concrete subclasses of this class.

.. class:: <library-id>

   :superclasses: <named-id>

   :keyword name: an instance of :drm:`<string>`. Required.

   :description:

      An identifier for a library.

.. class:: <module-id>

   :superclasses: <named-id>

   :keyword name: an instance of :drm:`<string>`. Required.
   :keyword library: an instance of :class:`<library-id>`. Required.

   :description:

      An identifier for a module.


.. class:: <definition-id>

   :superclasses: <named-id>

   :keyword name: an instance of :drm:`<string>`. Required.
   :keyword module: an instance of :class:`<module-id>`. Required.

   :description:

      An identifier for a definition within a module.


.. class:: <method-id>

   :superclasses: <unique-id>

   :keyword generic-function: an instance of :class:`<definition-id>`. Required.
   :keyword specializers: an instance of :drm:`<simple-object-vector>`. Required.

   :description:

      An identifier for a method.   

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
