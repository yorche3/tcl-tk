# data_structures_basics — Node, lista enlazada, pila y cola.
#
# Especificación: 06_Data_Structures_Basics
#
# Contrato: cuatro clases públicas de TclOO —`Node`, `LinkedList`, `Stack` y
# `Queue`— en el namespace `DataStructuresBasics`, con los nombres `snake_case` de
# la especificación, como en el namespace `NaiveSort` de
# `core/algorithms/naive_sort/`. `Node` es la única celda enlazada del módulo y
# las tres estructuras la comparten sin delegar unas en otras: cada una guarda sus
# propios punteros y su contador.
# API: `Node` — `get_value`, `get_next`, `set_next`; `LinkedList` — `get_head`,
# `insert_head`, `insert_tail`, `delete`, `is_empty`, `size`; `Stack` — `push`,
# `pop`, `peek`, `is_empty`, `size`; `Queue` — `enqueue`, `dequeue`, `peek`,
# `is_empty`, `size`.
#
# Dependencias: TclOO (`oo::class`), que Tcl trae desde 8.6 (`package require
# TclOO` da 1.3.1 en Tcl 9.0.4 y 1.1.0 en Tcl 8.6.14). El mínimo se declara con el
# guion abierto (`Tcl 8.6-`): `package require Tcl 8.6` sin el guion **falla** en
# Tcl 9 con «version conflict … have 9.0.4, need 8.6».
#
# `init` de la especificación: en TclOO la inicialización es el `constructor`, así
# que `[Node new $valor]` deja la celda con su valor y sin enlace, y
# `[LinkedList new]` —igual `Stack` y `Queue`— deja la estructura vacía. Los
# constructores quedan implementados: son el estado inicial del contrato. El
# paquete se publica como `1.0`, que es lo que declara `src/pkgIndex.tcl`.
#
# Adecuaciones de salida de centinela (todavía no hay fallos reales):
#   - **int → -1**: `get_value`, `get_head`, `pop`, `peek`, `dequeue` y `size`
#     mientras su cuerpo sea un esqueleto.
#   - **bool → 0**: `is_empty` y `delete`, que devuelven 0/1 por el `expr` de Tcl.
#   - **Solo las clases y los enlaces usan la ausencia nativa `{}`**: `get_next` y
#     `set_next` devuelven un enlace, y `{}` es la ausencia de nodo. Tcl no tiene
#     `null`/`nil`: `{}` es la representación nativa, no un centinela nuevo, y es
#     también el retorno neutro de las operaciones sin resultado de fallo
#     (`insert_head`, `insert_tail`, `push`, `enqueue`).
#   - Ningún cuerpo lanza excepciones ni llama a `error`.
#
# Implementación pendiente: la escribe el autor. Esta delegación solo genera el
# contrato (firmas y esqueletos) con las adecuaciones de salida.

package require Tcl 8.6-
package require TclOO

namespace eval DataStructuresBasics {
    namespace export Node LinkedList Stack Queue

    # -----------------------------------------------------------------------
    # Node — celda enlazada compartida por LinkedList, Stack y Queue.
    # -----------------------------------------------------------------------

    oo::class create Node {
        variable value
        variable next

        # `init(value)` de la especificación: guarda el valor y deja el enlace
        # ausente. Queda implementado: es el estado inicial del contrato.
        constructor {v} {
            set value $v
            set next {}
        }

        # Esqueleto: valor de la celda.
        method get_value {} {
            return -1
        }

        # Esqueleto: enlace a la celda siguiente, o {} cuando no hay ninguna.
        method get_next {} {
            return {}
        }

        # Esqueleto: asigna el enlace y devuelve el enlace nuevo.
        method set_next {n} {
            return {}
        }
    }

    # -----------------------------------------------------------------------
    # LinkedList
    # -----------------------------------------------------------------------

    oo::class create LinkedList {
        variable head
        variable tail
        variable count

        # `init()` de la especificación: sin enlaces y con el contador a cero.
        # Queda implementado: es el estado inicial del contrato.
        constructor {} {
            set head {}
            set tail {}
            set count 0
        }

        # Esqueleto: valor de la cabeza, o -1 cuando la lista está vacía.
        method get_head {} {
            return -1
        }

        # Esqueleto: inserta al principio. Sin resultado de fallo.
        method insert_head {v} {
            return {}
        }

        # Esqueleto: inserta al final. Sin resultado de fallo.
        method insert_tail {v} {
            return {}
        }

        # Esqueleto: borra la primera aparición; 0 cuando el valor no estaba.
        method delete {v} {
            return 0
        }

        # Esqueleto: 1 solo si no hay nodos.
        method is_empty {} {
            return 0
        }

        # Esqueleto: número de nodos (el centinela es -1 mientras sea esqueleto).
        method size {} {
            return -1
        }
    }

    # -----------------------------------------------------------------------
    # Stack
    # -----------------------------------------------------------------------

    oo::class create Stack {
        variable top
        variable count

        # `init()` de la especificación: sin cima y con el contador a cero.
        # Queda implementado: es el estado inicial del contrato.
        constructor {} {
            set top {}
            set count 0
        }

        # Esqueleto: apila sobre la cima. Sin resultado de fallo.
        method push {v} {
            return {}
        }

        # Esqueleto: desapila el valor de la cima, o -1 cuando está vacía.
        method pop {} {
            return -1
        }

        # Esqueleto: valor de la cima, o -1 cuando está vacía. No muta.
        method peek {} {
            return -1
        }

        # Esqueleto: 1 solo si no hay nodos.
        method is_empty {} {
            return 0
        }

        # Esqueleto: número de nodos (el centinela es -1 mientras sea esqueleto).
        method size {} {
            return -1
        }
    }

    # -----------------------------------------------------------------------
    # Queue
    # -----------------------------------------------------------------------

    oo::class create Queue {
        variable front
        variable rear
        variable count

        # `init()` de la especificación: sin frente, sin final y con el contador a
        # cero. Queda implementado: es el estado inicial del contrato.
        constructor {} {
            set front {}
            set rear {}
            set count 0
        }

        # Esqueleto: encola por el final. Sin resultado de fallo.
        method enqueue {v} {
            return {}
        }

        # Esqueleto: desencola el valor del frente, o -1 cuando está vacía.
        method dequeue {} {
            return -1
        }

        # Esqueleto: valor del frente, o -1 cuando está vacía. No muta.
        method peek {} {
            return -1
        }

        # Esqueleto: 1 solo si no hay nodos.
        method is_empty {} {
            return 0
        }

        # Esqueleto: número de nodos (el centinela es -1 mientras sea esqueleto).
        method size {} {
            return -1
        }
    }
}

package provide data_structures_basics 1.0
