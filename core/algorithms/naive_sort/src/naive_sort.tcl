# naive_sort — ordenamientos elementales O(n²).
#
# Especificación: 05_Naive_Sort
#
# Contrato: las tres funciones reciben una lista de enteros y devuelven una lista
# nueva ordenada de menor a mayor, sin invocar `lsort` ni ninguna otra ayuda de
# ordenamiento de la biblioteca estándar y sin estructuras auxiliares complejas.
# Las listas de Tcl son valores, así que el resultado vuelve por el valor
# devuelto.
# API: los tres comandos del namespace `NaiveSort` — `selection_sort`,
# `bubble_sort` e `insertion_sort`, con los nombres `snake_case` de la
# especificación, como en el namespace `Numbers` de `core/foundations/numbers/`.
# El caso nulo se omite: Tcl no tiene `null`/`nil` y la lista vacía (`{}`) no se
# distingue de una cadena vacía. Si la lista está vacía o tiene un solo elemento
# se devuelve sin cambios. No lanza excepciones.
#
# Implementación pendiente: la escribe el autor. Esta delegación solo genera el
# esqueleto y las pruebas unitarias.

namespace eval NaiveSort {
    namespace export selection_sort bubble_sort insertion_sort

    proc selection_sort {array} {
      set n [llength $array]
      if {$n <= 1} {
          return $array
      }
      set result $array
      for {set i 0} {$i < $n - 1} {incr i} {
          set minIndex $i
          for {set j [expr {$i + 1}]} {$j < $n} {incr j} {
              if {[lindex $result $j] < [lindex $result $minIndex]} {
                  set minIndex $j
              }
          }
          if {$minIndex != $i} {
              set temp [lindex $result $i]
              lset result $i [lindex $result $minIndex]
              lset result $minIndex $temp
          }
      }
      return $result
    }
    
    proc bubble_sort {array} {
      set n [llength $array]
      if {$n <= 1} {
          return $array
      }
      set result $array
      for {set i 0} {$i < $n - 1} {incr i} {
          set swapped 0
          for {set j 0} {$j < $n - 1 - $i} {incr j} {
              if {[lindex $result $j] > [lindex $result [expr {$j + 1}]]} {
                  set temp [lindex $result $j]
                  lset result $j [lindex $result [expr {$j + 1}]]
                  lset result [expr {$j + 1}] $temp
                  set swapped 1
              }
          }
          if {!$swapped} {
              break
          }
      }
      return $result
    }

    proc insertion_sort {array} {
      set n [llength $array]
      if {$n <= 1} {
          return $array
      }
      set result $array
      for {set i 1} {$i < $n} {incr i} {
          set j $i
          while {$j > 0 && [lindex $result $j] < [lindex $result [expr {$j - 1}]]} {
              set temp [lindex $result $j]
              lset result $j [lindex $result [expr {$j - 1}]]
              lset result [expr {$j - 1}] $temp
              incr j -1
          }
      }
      return $result
    }
}

package provide naive_sort 1.0
