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
# que `[::DataStructuresBasics::Node new $valor]` deja la celda con su valor y sin
# enlace, y `[LinkedList new]` —igual `Stack` y `Queue`— deja la estructura vacía.
# Los constructores son el estado inicial del contrato. El paquete se publica como
# `1.0`, que es lo que declara `src/pkgIndex.tcl`.
#
# Indicadores de fallo (valores representables, sin excepciones):
#   - **int → -1**: `get_head`, `peek`, `pop` y `dequeue` cuando la estructura está
#     vacía. `get_value` y `size` devuelven su valor real.
#   - **bool → 0/1**: `is_empty` y `delete`; `is_empty` sale del puntero de entrada
#     y `delete` devuelve 1 cuando borró y 0 cuando el valor no estaba.
#   - **Solo las clases y los enlaces usan la ausencia nativa `{}`**: `get_next` y
#     `set_next` devuelven un enlace, y `{}` es la ausencia de nodo. Tcl no tiene
#     `null`/`nil`: `{}` es la representación nativa, no un centinela nuevo. Las
#     operaciones sin resultado de fallo (`insert_head`, `insert_tail`, `push`,
#     `enqueue`) devuelven también `{}` porque no tienen nada que informar.
#   - Ningún cuerpo lanza excepciones ni llama a `error`: el fallo viaja en el
#     valor devuelto.
#
# Mutabilidad: las tres estructuras mutan en sitio, así que cada escenario trabaja
# con una instancia (`[LinkedList new]` y luego las operaciones). `Node` es la
# celda compartida: el valor se fija al construir y el enlace se reengancha con
# `set_next`.
#
# Namespaces: los métodos de TclOO no ven los nombres sin cualificar —el namespace
# actual de un objeto es `::oo::ObjNN`, con el `namespace path` en `::oo::Helpers`,
# no el namespace donde se definió la clase—, así que las tres estructuras crean la
# celda con el nombre cualificado `::DataStructuresBasics::Node`.
#
# Complejidad: O(1) en `get_head`, `insert_head`, `insert_tail`, `push`, `pop`,
# `peek`, `enqueue`, `dequeue`, `is_empty` y `size` —las estructuras guardan sus
# punteros (cabeza/cola, cima, frente/final) y su contador— y O(n) en `delete`,
# como pide la especificación.

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

        # Valor de la celda.
        method get_value {} {
            return $value
        }

        # Enlace a la celda siguiente, o {} cuando no hay ninguna.
        method get_next {} {
            return $next
        }

        # Reengancha el enlace y devuelve el enlace nuevo: la celda es mutable.
        method set_next {n} {
            set next $n
            return $next
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

        # Valor de la cabeza, o -1 cuando la lista está vacía. No muta.
        method get_head {} {
            if {$head eq {}} {
                return -1
            }
            return [$head get_value]
        }

        # Inserta al principio: O(1) y sin resultado de fallo.
        method insert_head {v} {
            set node [::DataStructuresBasics::Node new $v]
            $node set_next $head
            set head $node
            if {$tail eq {}} {
                set tail $node
            }
            incr count
            return {}
        }

        # Inserta al final: O(1) y sin resultado de fallo. El final guardado es lo
        # que evita recorrer la lista.
        method insert_tail {v} {
            set node [::DataStructuresBasics::Node new $v]
            if {$tail eq {}} {
                set head $node
            } else {
                $tail set_next $node
            }
            set tail $node
            incr count
            return {}
        }

        # Borra la primera aparición: 1 si borró y 0 si el valor no estaba. O(n).
        method delete {v} {
            set prev {}
            set current $head
            set found 0
            while {$current ne {}} {
                if {[$current get_value] == $v} {
                    set found 1
                    if {$prev eq {}} {
                        set head [$current get_next]
                    } else {
                        $prev set_next [$current get_next]
                    }
                    if {$current eq $tail} {
                        set tail $prev
                    }
                    incr count -1
                    break
                }
                set prev $current
                set current [$current get_next]
            }
            return $found
        }

        # 1 solo si no hay nodos.
        method is_empty {} {
            return [expr {$head eq {}}]
        }

        # Número de nodos. O(1) sobre el contador.
        method size {} {
            return $count
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

        # Apila sobre la cima: O(1) y sin resultado de fallo.
        method push {v} {
            set node [::DataStructuresBasics::Node new $v]
            $node set_next $top
            set top $node
            incr count
            return {}
        }

        # Desapila: devuelve el valor de la cima, o -1 cuando está vacía. O(1).
        method pop {} {
            if {$top eq {}} {
                return -1
            }
            set node $top
            set top [$node get_next]
            incr count -1
            return [$node get_value]
        }

        # Valor de la cima, o -1 cuando está vacía. No muta.
        method peek {} {
            if {$top eq {}} {
                return -1
            }
            return [$top get_value]
        }

        # 1 solo si no hay nodos.
        method is_empty {} {
            return [expr {$top eq {}}]
        }

        # Número de nodos. O(1) sobre el contador.
        method size {} {
            return $count
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

        # Encola por el final: O(1) y sin resultado de fallo. El final guardado es
        # lo que evita recorrer la cola.
        method enqueue {v} {
            set node [::DataStructuresBasics::Node new $v]
            if {$rear eq {}} {
                set front $node
                set rear $node
            } else {
                $rear set_next $node
                set rear $node
            }
            incr count
            return {}
        }

        # Desencola: devuelve el valor del frente, o -1 cuando está vacía. O(1).
        method dequeue {} {
            if {$front eq {}} {
                return -1
            }
            set node $front
            set front [$node get_next]
            if {$front eq {}} {
                set rear {}
            }
            incr count -1
            return [$node get_value]
        }

        # Valor del frente, o -1 cuando está vacía. No muta.
        method peek {} {
            if {$front eq {}} {
                return -1
            }
            return [$front get_value]
        }

        # 1 solo si no hay nodos.
        method is_empty {} {
            return [expr {$front eq {}}]
        }

        # Número de nodos. O(1) sobre el contador.
        method size {} {
            return $count
        }
    }
}

package provide data_structures_basics 1.0
